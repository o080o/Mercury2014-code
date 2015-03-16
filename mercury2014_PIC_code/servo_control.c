#include "prototypes.h"
#include <xc.h>
#include <stdio.h>
#include <stdlib.h>

#define PRESCALER 8
#define CLK_FREQ 16000000
#define MAXTIME 65535

int CLK_MULT = CLK_FREQ / (PRESCALER * 40000);

#define __NO_EVTS 1
# define __NULL_EVT 2
void error(int e){
	printf("ERROR: %d", e);
	while(1){}
}


typedef struct {
	unsigned int time;
	int parameter;
	void (*fs) (int);
} Event;

char head=0;
char tail=0;
const char size=12;
Event eventBuffer[13];

unsigned int time;

void servoLow(int);
void servoHigh(int);
void nopFunc(int p){};
Event nopEvent = {0,0,&nopFunc};

Event nextEvent( void (*fs) (int), unsigned int delay, int parameter);
Event newEvent( void (*fs) (int), unsigned int delay, int parameter);

void init_servos(){
	TRISD &= 0b11111100;
	T1CON = 0b00110001; // prescaler of 1, using external clock, synchronozed, with oscilator disabled. 
	//T1CON = 0b00000001; // prescaler of 1, using external clock, synchronozed, with oscilator disabled. 
	CCP1CON = 0b0001010; //set for compare mode using software intterupt
	INTCON = INTCON | 0b11000000; // enable Peripheral Interupts (includes compare modules)
	PIE1 = PIE1 | 0b00000100; //enable interrupts for CCP1IE, TMR1IE
}

// sets up the compare module to expire at this event's time
void scheduleEvent( Event* e ){
	if (e!=NULL && e->fs != NULL){
		CCPR1H = e->time >> 8;
		CCPR1L = e->time & 0xFF;
	}
}

char soonerThan( Event* e1, Event* e2){
	//  |--0-----------T-N-1|
	if(e1->time < time && e2->time >= time){
		return 0; // e2 is sooner
	}else if(e2->time < time && e1->time >=time){
		return 1; //e1 is sooner
	}else{
		if(e1->time < e2->time){
			return 1; // e1 is sooner
		} else if(e2->time < e1->time){
			return 0; //e2 is sooner
		} else {
			return 0; // they are equal
		}
	}
}

// add a new event into the queue
char addEvent( Event evt){
	eventBuffer[tail] = evt;
	char idx=tail;
	if (head!=tail){
		char prev = (idx==0)? size : idx-1;
		Event* prevEvt = &eventBuffer[prev]; // will at least be head, since at least 2 elements are now in the buffer.
		if( prevEvt->fs == NULL ){
			error(1);
		}
		while( soonerThan(&evt, prevEvt) ){
			if( prevEvt->fs == NULL ){
				error(0);
			}
			eventBuffer[ idx ] = *prevEvt; // push this event further down the buffer
			eventBuffer[ prev ] = evt;
			idx = prev;

			if (idx==head){ // we have searched the entire buffer and this event is now the first event to be fired.
				scheduleEvent(&evt);
				break;
			}

			prev = (prev==0)? size : prev-1;
			prevEvt = &eventBuffer[prev];
		}
	}else{
		scheduleEvent(&evt);
	}

	tail = (tail==size)? 0 : tail+1;
	if (head==tail){ // NEVER fill the buffer.
		tail = (tail==0)? size : tail-1;
		error(0);
	}
	return idx;
}

// remove the specified index from the queue
void removeEvent( char idx ){
	char i=tail;
	char removed = 0;
	if(idx==head){
		head = (head==size)? 0 : head+1;
		if(head!=tail){ // if buffer is not empty
			scheduleEvent( &eventBuffer[head] );
		}else{
			while(1){
				error(__NO_EVTS);
			}
		}
	}else{
		i = idx;
		while( idx != tail){
			char next = (idx==size)? 0 : idx+1;
			Event evt = eventBuffer[next];
			eventBuffer[idx] = evt;
			//eventBuffer[idx] = eventBuffer[next]; // throws strange error about registers being unavailable...
			idx = next;
		}
		tail = (tail==0)? size : tail-1;
	}
}


// schedules a function to execute after a delay of *delay* microseconds from
// when this function is called
Event newEvent( void (*fs) (int), unsigned int delay, int parameter ){
	delay = delay * CLK_MULT; // convert from microseconds to clock ticks
	Event event;
	unsigned int now = TMR1H;
	now = now<<8 + TMR1L;
	event.time = now + delay; // time is global counter
	event.parameter = parameter;
	event.fs = fs;
	return event;
}	

// schedules a function to execute after a delay of *delay* microseconds from
// the last event
Event nextEvent( void (*fs) (int), unsigned int delay, int parameter) {
	delay = delay * CLK_MULT; // convert from microseconds to clock ticks
	Event event;
	event.time = time + delay; // time is global counter
	event.parameter = parameter;
	event.fs = fs;

	return event;
}	


void pulsePinLow(int);
void pulsePinHigh(int);
void pulsePinHigh(int p){
	LED=1;
	Event evt = nextEvent( &pulsePinLow, 20, p);
	addEvent( evt );
}
void pulsePinLow(int p){
	LED=0;
	p = (p+3<30 || p+3 > 500)? 30 : p+3;
	Event evt = nextEvent( &pulsePinHigh, p, p);
	addEvent( evt );
	//scheduleEvent(&evt);
}
void servoHigh(int p){
	__SERVO_PIN = 1;
	Event evt = nextEvent( &servoLow, p, p);
	addEvent( evt );
	//scheduleEvent(&evt);
}

void servoLow(int p){
	__SERVO_PIN = 0;
	Event evt = nextEvent( &servoHigh, 200, p);
	addEvent( evt );
	//scheduleEvent(&evt);
}


//#define EPSILON 1*CLK_FREQ
#define EPSILON 0
void interrupt isr(void){
	if (CCP1IF){
		CCP1IF = 0; //reset interrupt flag
		if(head==tail){ // there are no scheduled events
			LED = (LED)? 0 : 1;
			printf(".");
			return;
		}
		
		Event* evt = &eventBuffer[head];

		unsigned int now;
		char expired;

		now = TMR1L;
		now += (TMR1H<<8);
		expired = (time>now)? (evt->time <= now+EPSILON) || (evt->time >= time) : (evt->time <= now+EPSILON) && (evt->time >= time); 
		// remove all events that have expired, or very close to expiring
		do{
			removeEvent(head);

			if( evt->fs != NULL ){
				time = evt->time;
				evt->fs( evt->parameter ); 
			}else{
				error( __NULL_EVT );
			}

			evt = &eventBuffer[head];
			now = TMR1L;
			now += (TMR1H<<8);
			expired = (time>now)? (evt->time <= now+EPSILON) || (evt->time >= time) : (evt->time <= now+EPSILON) && (evt->time >= time); 
		} while ( tail!=head && expired );	

	}
}

void delayms(unsigned int n){
	for(n=n; n>0; n--){
		__delay_ms(1);
	}
}

void setServo(int pin, unsigned int position){
	/*
	// start capture compare loop
	position = 14;
	//position = position * CLK_FREQ / (4000 * PRESCALER);
	position = position * CLK_MULT;
	ticks = position;
	ticksHigh = position >> 8;
	ticksLow = position & 0xFF;

	position = 300;
	//position = position * CLK_FREQ / (4000 * PRESCALER);
	position = position * CLK_MULT;
	ticks2 = position;
	ticks2High = position >> 8;
	ticks2Low = position & 0xFF;

	TMR1H=0;
	TMR1L=0;

	servoLow(0);
	*/

addEvent( newEvent( &pulsePinHigh, 50, 50 ) );
addEvent( newEvent( &servoHigh, 30, 10) );
	//servoHigh(10);
	//nextEvent = scheduleEvent( &servoHigh, 10, position);
}
