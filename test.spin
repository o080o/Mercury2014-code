{
 ************************************************************************************************************
 *                                                                                                          *
 *  AUTO-RECOVER NOTICE: This file was automatically recovered from an earlier Propeller Tool session.      *
 *                                                                                                          *
 *  ORIGINAL FOLDER:                                                                                        *
 *  TIME AUTO-SAVED:     over 3 days ago (3/21/2015 5:05:44 AM)                                             *
 *                                                                                                          *
 *  OPTIONS:             1)  RESTORE THIS FILE by deleting these comments and selecting File -> Save.       *
 *                           The existing file in the original folder will be replaced by this one.         *
 *                                                                                                          *
 *                           -- OR --                                                                       *
 *                                                                                                          *
 *                       2)  IGNORE THIS FILE by closing it without saving.                                 *
 *                           This file will be discarded and the original will be left intact.              *
 *                                                                                                          *
 ************************************************************************************************************
.}
con
  _CLKMODE      = XTAL1 + PLL16X
  _XINFREQ      = 5_000_000                          ' 5MHz Crystal

  BUFFERSIZE    = 2 'how many PWM events to buffer

  NPWM  = 8
               
dat


' Pin0 is burned out, DO NOT USE IT
              
'motor_l_high byte 1,3,5
'motor_l_low  byte 11,9,7

motor_l_high byte 16,18,20
motor_l_low  byte 17,19,21

motor_r_high byte 22,24,26
motor_r_low  byte 23,25,27


phaseMask_l long 0[6]
phaseMask_r long 0[6]

nextTimeBuffer      long      0[BUFFERSIZE]
nextMaskBuffer      long      0[BUFFERSIZE]
                    
pwmArray      long      0[NPWM*4]
pub main | p,n, high, low, val, spd
  init
{
  repeat
    outa[16]~
    outa[19]~
    delayms(100)
    outa[16]~~
    outa[19]~~
'    delayms(600)


    outa[18]~
    outa[21]~
    delayms(100)
    outa[18]~~
    outa[21]~~
'    delayms(600)

    outa[20]~
    outa[17]~
    delayms(100)
    outa[20]~~
    outa[17]~~
'    delayms(600)
}

  n:=0
  dira[1]~~
  outa[1]~~
  nextTimeAddr := @nextTimeBuffer
  nextMaskAddr := @nextMaskBuffer
  nextTimeAddr2 := @nextTimeBuffer
  nextMaskAddr2 := @nextMaskBuffer       
  pwmAddr := @pwmArray     
  setPwm(0, 10, 500, 0)
  setPwm(1, 30, 2000, 0)
  setPwm(2, 30, 5000, 0)
  setPwm(3, 400,100, 0)
  setPwm(4, 30, 100, 0)
  setPwm(5, 15, 200, 0)

  cognew(@WaveBufferGen, 0)
  cognew(@WaveGen, 0)
delayms(1000)
  setPwm(3, 400,1, 1<<23)
delayms(900)
  setPwm(3, 30, 500, 1<<21)


  p := 0
  high:=0
  low:=0
  outa[1]~
  dira[18]~~
  spd:=1000000

  repeat
    p:=p + 1
    if p=>6
      p:=0
      spd:= (spd * 10)/11
    if spd=<10000
      spd:=10000
    setPwm(3, 500,50, phaseMask_l[p])
'    outa:= phaseMask_l[p]

    setPwm(5, p+10, 200, 1<<1)
    delayms(10)
    waitcnt( cnt + spd )
              
pub init | N, i
  'turn off ALL motor control pins
  n:=0
  repeat 3
      outa[ motor_l_high[n] ]~
      dira[ motor_l_high[n] ]~~
      outa[ motor_l_low[n] ]~
      dira[ motor_l_low[n] ]~~

      outa[ motor_r_high[n] ]~
      dira[ motor_r_high[n] ]~~
      outa[ motor_r_low[n] ]~
      dira[ motor_r_low[n] ]~~
      n++

  'fill the phases buffer by merging the values of the motor pins into a single 32 bitp value
  N := 0
  i:=0
  repeat 3
    phaseMask_l[i++] := (1<< motor_l_high[N] | 1<<motor_l_low[ (N+1)//3 ])
    phaseMask_l[i++] := (1<<motor_l_high[N] | 1<<motor_l_low[ (N+2)//3 ])
    N:=(N+1) // 3

  i:=0
  N:=0
  repeat 3
    phaseMask_r[i++] := (1<< motor_r_high[N] | 1<<motor_r_low[ (N+1)//3 ])
    phaseMask_r[i++] := (1<<motor_r_high[N] | 1<<motor_r_low[ (N+2)//3 ])

    N := (N+1) // 3

pub delayms (ms)
  if ms==0
    return
  waitcnt( cnt + ms*(CLKFREQ/1000))

pub setPwm(pwm, on, off, mask)

  pwmArray[(pwm*4)+1]:= mask
  pwmArray[(pwm*4)+2]:= on
  pwmArray[(pwm*4)+3]:= off
  if pwmArray[ (pwm*4)+0 ]==0
    pwmArray[(pwm*4)+0]:=1

dat
SpiAdc
              org 0

ReadADC
        or outa, ADCCSMASK ' cs high
        or dira, ADCDINMASK ' din high
        andn outa, ADCCLKMASK ' clk low
        ' start com, send out 5 bits.
        mov ADCcount,#5
        mov tmpval, #$18 ' setup for single mode, with start bit
        or tmpval, curCh
        andn outa, ADCCSMASK ' low cs
:sendbit
        test tmpval, #$10 wc 'update DIN/DOUT
        muxc outa, ADCDINMASK
        shl tmpval, #1
        call #ClkPulse
        djnz ADCcount,#:sendbit
        andn dira, ADCDINMASK
        call #ClkPulse ' dummy
        call #ClkPulse ' skip null bit
        mov ADCcount,#12
        xor tmpval, tmpval
:readbit
        test ADCDINMASK, ina WC
        rcl tmpval, #1 ' store bit for output
        call #ClkPulse
        djnz ADCcount,#:readbit
        or outa, ADCCSMASK ' reset cs high.
ReadADC_ret ret

ClkPulse
        nop
        nop
        or outa, ADCCLKMASK
        nop
        nop
        nop
        nop
        andn outa, ADCCLKMASK
        nop
        nop
ClkPulse_ret ret

curCh   long 0
ADCcount long 0
tmpVal long 0

ADCCSMASK long 0
ADCCLKMASK long 0
ADCDINMASK long 0

ADCDataPtr long 0

dat
SpiSlave
              org 0

:Loop
              ' wait for CS to go high/low (depending on mode)
:wait_cs      mov input, ina
              and input, CSMASK                 wz
if_z          jmp #:wait_cs

              and mode, CPOL    wz
if_z          cmp 0,0           wc 'write to the C flag.

              and mode, CPHA    wz
if_z_and_c    cmp 0,0   wc 'clear the C flag
if_z_and_nc   cmp 0,0   wc 'set the C flag
if_z          jmp #:skip_edge


:SpiLoop      ' wait for falling/rising edge

:wait_edge      mov input, ina
if_c          xor input, Neg1_2
              and input, CSMASK                 wz
if_z          jmp #:wait_edge
:skip_edge

:setbit
              'set bit if the data bit is set
              and data, #1      wz,nr
              or  outa, TXMASK
if_z          xor outa, TXMASK


:wait_edge2      mov input, ina
if_nc          xor input, Neg1_2
              and input, CSMASK                 wz
if_z          jmp #:wait_edge2

:readbit

              shl data, #1
              and ina, #1       wz, nr
if_z          or datain, #1
              sub nbits, #1     wz
if_z          call #nextWord
              jmp #:loop

nextWord
              wrlong datain, bufferPtr
              add bufferPtr, #1
              rdlong dataout, outBufferPtr
              add outBufferPtr, #1
nextWord_ret          ret

Neg1_2  long -1
input long 0
data long 0
datain long 0
dataout long 0
nbits long 0
mode long 0
CSMASK long 0
RXMASK long 0
TXMASK long 0
CLKMASK long 0
CPOL long 0
CPHA long 0

bufferPtr long 0
outBufferPtr long 0


dat
MotorControl
        org 0
              ' control a single motor at a certain speed.
dat
WaveGen
        org 0
              mov lastAddr, #1
              shl lastAddr, #20
              or dira, testpin1
              or dira, testpin2
              or dira, testpin3
              
              or dira, lastAddr
              
              mov lastAddr, #BUFFERSIZE
              shl lastAddr, #2
              add lastAddr, nextMaskAddr

              mov nextTimePtr, nextTimeAddr
              mov nextMaskPtr, nextMaskAddr
:Loop                                
              ' read in the next set of values for our waiting loop
              rdlong nextMask, nextMaskPtr
              rdlong nextTime, nextTimePtr      wz
if_z          jmp #:Loop ' wait until we actually have a value
              wrlong zero, nextTimePtr 'correct operand order?

              ' setup for the next loop. (increment buffer pointers)              
              add nextMaskPtr, #4
              add nextTimePtr, #4
              cmp nextMaskPtr, lastAddr         wz
if_z          mov nextMaskPtr, nextMaskAddr
if_z          mov nextTimePtr, nextTimeAddr


              ' test if wee need to rollover.
              mov lastCnt, lastTime                  
              cmp nextTime, lastCnt            wc,wz   
              
if_nc_and_nz  jmp #:norollover
:rollover     ' if so, wait until cnt rolls over   
              
              mov now, cnt
              cmp lastCnt, now                  wc
              mov lastCnt, now
if_c          jmp #:rollover
:norollover
              ' wait until the next event is scheduled.
    '          mov nextTime, cnt
    '          add nextTime, delay2
                              
:wait         mov now, cnt                         
              cmp nextTime, now                 wc ' test if we have passed it.
if_nc         cmp now, lastCnt                  wc ' test if we rolled over (perhaps for a second time)
              mov lastCnt, now
if_nc         jmp #:wait

              ' change the state, and continue to the next loop
              or dira, nextMask
              mov outa, nextMask
              mov lastTime, nextTime
                              
              jmp #:Loop
delay         long      2000000
delay2        long     50000000

tmp1          long      0
tmp2          long      0
tmp3          long      0
 
testPin1      long      %0010000000000000000
testPin2      long      %0100000000000000000
testPin3      long      %1000000000000000000

zero          long      0


nextTime      long      0
nextMask      long      0

nextTimeAddr  long      0
nextMaskAddr  long      0
lastAddr      long      0

nextTimePtr   long      0
nextMaskPtr   long      0

now           long      0
lastCnt       long      0
lastTime      long      0              

               

        
        
        
                          
dat
WaveBufferGen
        org 0                              
              or dira, testpin4
              or dira, testpin5
              or dira, testpin6

              mov lastAddr2, #BUFFERSIZE
              shl lastAddr2, #2
              add lastAddr2, nextMaskAddr2

              mov nextTimePtr2, nextTimeAddr2
              mov nextMaskPtr2, nextMaskAddr2

              mov nextTime3,    cnt  
WaveBufferGenLoop
                         
              mov finalPwmPtr, #NPWM
              shl finalPwmPtr, #4 '(x16)
              add finalPwmPtr, pwmAddr  
FindNextEvent
              ' reset for the next loop
              mov pwmPtr, pwmAddr
              mov minDeltaT, neg1
              
:loop

                        
              rdlong time, pwmPtr               wz
if_z          jmp #:skip
              
              mov deltaT, time
              sub deltaT, lastTime2 '(time-lastTime2) 

              cmp deltaT, minDeltaT              wc   
               
if_c          mov nextTime2, time
if_c          mov minDeltaT, deltaT


:skip
              add pwmPtr, #16
              cmp pwmPtr, finalPwmPtr           wz
if_nz         jmp #:loop

SetupNextEvent
              ' reset for the next loop   
              mov pwmPtr, pwmAddr
              mov pwmPin, #1
              mov nextMask2, #0

:loop
                        
              rdlong time, pwmPtr               wz
if_z          jmp #:skip

                  
              mov deltaT, time
              sub deltaT, nextTime2 '(time-nextTime2) 

              cmp deltaT, EPSILON              wc
if_nc         jmp #:skip                            
              ' retreive the mask for this PWM
              add pwmPtr, #4
              rdlong thisMask, pwmPtr
              or nextMask2, thisMask ' OR it to the current mask
              ' calculate the next time for this PWM
              and pwmPin, state                    wz,nr
              xor state, pwmPin
                             
if_z          add pwmPtr, #4
if_nz         add pwmPtr, #8
              rdlong deltaT, pwmPtr
if_z          sub pwmPtr, #8
if_nz         sub pwmPtr, #12
              add time, deltaT               wz
if_z          add time, #1 'value of 0 is reserved.
              ' save the next time
              wrlong time, pwmPtr

:skip         ' setup for the next iteration
              add pwmPtr, #16
              shl pwmPin, #1
              cmp pwmPtr, finalPwmPtr            wz
if_nz         jmp #:loop

FindNextState
              ' reset for the next loop
              mov pwmPtr, pwmAddr
              mov pwmPin, #1
              mov nextMask2, #0

:loop
              add pwmPtr, #4
              rdlong thisMask, pwmPtr
              and pwmPin, state                    wz,nr
'              or nextMask2, thisMask
if_nz         or nextMask2, thisMask ' OR it to the current mask

              ' setup for the next iteration
              add pwmPtr, #12
              shl pwmPin, #1
              cmp pwmPtr, finalPwmPtr            wz
if_nz         jmp #:loop


WriteNextEvent
:waitForClear rdLong time, nextTimePtr2          wz
if_nz         jmp #:waitForClear                    

              add nextTime3, delay5
              wrlong nextTime2, nextTimePtr2
              mov lastTime2, nextTime2
              wrlong nextMask2, nextMaskPtr2
              
              add nextMaskPtr2, #4
              add nextTimePtr2, #4
              cmp nextMaskPtr2, lastAddr2         wz
if_z          mov nextMaskPtr2, nextMaskAddr2
if_z          mov nextTimePtr2, nextTimeAddr2

              jmp #WaveBufferGenLoop

tmp10 long 0

testPin4      long   %00100000000000000000000
testPin5      long   %01000000000000000000000
testPin6      long   %10000000000000000000000 
testPin7      long   %00010000000000000000000

delay3         long      2000000   
delay4        long     50000000
delay5        long     90000000

              
EPSILON       long 100
pwmAddr   long 0
pwmPtr    long 0
finalPwmPtr long 0

state   long  0

neg1    long            -1

time    long            0
pwmPin  long            0
thisMask long           0
deltaT   long           0
minDeltaT long           0

nextTime3 long          0
lastTime2 long          0
nextTime2 long          0
nextMask2 long          0
nextTimeAddr2 long      0
nextMaskAddr2 long      0
lastAddr2     long      0
nextTimePtr2  long      0
nextMaskPtr2  long      0
    
