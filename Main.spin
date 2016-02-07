con
  _CLKMODE      = XTAL1 + PLL16X
  _XINFREQ      = 5_000_000                          ' 5MHz Crystal

  BUFFERSIZE    = 3 'how many PWM events to buffer

  NPWM  = 8
  BAUD = 115200
  MINSPEED  = 80000000
  ZEROSPEED = 500
  STARTSPEED = 200000
  LOWSPEEDTHRESH = 5000000 'the threshold for "low power" speeds. due to the low communtation speed, we need to limit the power(via pwm) to avoid overloading the battery
  HIGHSPEEDTHRESH = 200000 'the threshold for "high power" speeds. When the motors are spinning fast enough, we can drive them at 100% duty cycle.
                         'speeds between HIGHSPEEDTHRESH and LOWSPEEDTHRESH are lerped between 50-100% duty. In this zone we can go faster than 50%

  ' define servo pins
  LSERVO_Pin      = 22
  RSERVO_Pin      = 23
  LAUNCHSERVO_Pin = 1
  HSERVO_Pin      = 0
  VSERVO_Pin      = 24
                          
  RPINS = %000000000001100
  GPINS = %000000000110000
  BPINS = %000000011000000
  
  SERVOPERIOD = 255

obj
Com   :       "FullDuplexSerial_rr004"

dat


' Pin0 is burned out, DO NOT USE IT
                                     
motor_l_low byte 10,12,14
motor_l_high  byte 15,13,11

motor_r_low byte 16,18,20
motor_r_high  byte 21,19,17

                                   
phaseMask_l             long    0[8]
phaseMask_r             long    0[8]

                           


nextTimeBuffer      long      0[BUFFERSIZE]
nextMaskBuffer      long      0[BUFFERSIZE]

dbg1 long 0
dbg2 long 0
dbg3 long 0
dbg4 long 0

lspeed        long 00000
rspeed        long 00000

rxBuffer      long 5
lspeedTarget  long 0
rspeedTarget  long 0
lTurnServo    long 350
rTurnServo    long 250
horzServo     long 0
vertServo     long 0
launchServo   long 0
res 16

                        
PwmArrayZ               long 00[NPWM*2]
PwmServoArrayZ              long 0[NPWM*2]
         
dat

AccelTable_Entries      long  4
AccelTable_Accel        long  1000,  200  , 0,  1
AccelTable_Speed        long  200000,50000,50000, ZEROSPEED
 
MotorAccel              long 0[2]

MotorPower              long 50
MotorPeriod             long 100       
pub main | n 
  MemorySetup
  PhaseSetup
  PwmStart              
  enableMotors 'starts 2 cogs, one for each motor     
  Com.Start(31,30,%0000,BAUD)       

                             
'  setMotor(0, MotorPower)
'  setMotor(1, MotorPower)
                   
  repeat 20
    Com.dec(rxBuffer)
    Com.tx(13)
    delayms(100)

    
  cognew(@TxSpi, 0)

  
  'repeat
    
  repeat
    ' handle acceleration                     
    Com.dec(rxBuffer)
    Com.tx(13)
  

    setServo(2, lTurnServo, 1<<LSERVO_Pin)                    
    setServo(3, rTurnServo, 1<<RSERVO_Pin)
    setServo(4, launchServo, 1<<LAUNCHSERVO_Pin)                    
    setServo(5, vertServo, 1<<VSERVO_Pin)

    lspeed := accelerate(lspeed, lspeedTarget, 0)
    rspeed := accelerate(rspeed, rspeedTarget, 1)


pub Fun |h,v,s

repeat
  h:= h+1
  hsvToRgb(0, h,255,255, RPINS, GPINS, BPINS)

  if h>255
    h:=0
  delayms(100)

pub hsvToRgb(idx,h,v,s, rmask, gmask, bmask) | r,g,b,p,q,t, region, remainder


 'calculate rgb from hvs
  if  s==0
    r:=v
    g:=v
    b:=v

  region := h/43
  remainder := ( h - (region*43) ) * 6

  p := (v * ( 255 - s ) ) >> 8
  q := (v * (255  - (( s * remainder) >> 8 )))>>8
  t := (v * (255 - ((s * (255 - remainder)) >> 8 ))) >> 8

  if region==0
    r:=v
    g:=t
    b:=p   
  elseif region==1
    r:=q
    g:=v
    b:=p   
  elseif region==2
    r:=p
    g:=v
    b:=t   
  elseif region==3
    r:=p
    g:=q
    b:=v   
  elseif region==4 
    r:=t
    g:=p
    b:=v   
  else     
    r:=v
    g:=p
    b:=q
                         
  setServo(idx, r, rmask)
  setServo(idx+1, g, gmask)
  setServo(idx+2, b, bmask)
       
pub setLED(pwm, time, mask)          
  PwmServoArrayZ[ (pwm*2) + 1] := off
  PwmServoArrayZ[ (pwm*2) + 0] := mask
pub setServo(pwm, on, mask)               
  if on > PwmPeriod
    on:=PwmPeriod
  PwmServoArrayZ[ (pwm*2) + 1] := PwmPeriod - on
  PwmServoArrayZ[ (pwm*2) + 0] := mask  
pub setMotor(pwm, off)               
  PwmArrayZ[ (pwm*2) + 1] := off

pub accelerate(speed, targetSpeed, id) | section, reverse
    reverse := 0
    if reverse
      dirBit:= targetSpeed & $F8000000 
      speed := speed & $07FFFFFF
      targetSpeed := targetSpeed & $07FFFFFF
    
    
    if targetSpeed =< ZEROSPEED                       ' enter motor stall
      speed:=0                                                           
      MotorAccel[id] := 0 
      return speed
      
    if targetSpeed > ZEROSPEED and speed =< ZEROSPEED 'come out of motor stall
      speed:=STARTSPEED                               
      MotorAccel[id] := 0 
      
    if speed =< targetSpeed 'check if we are already at speed
      speed := targetSpeed                    
      return speed

    section := MotorAccel[id]
    
    if speed > accelTable_Speed[section]                ' accelerate if we are within the limit
      speed := speed - accelTable_Accel[section]
    else                                                ' proceed to the next acceleration step
      section++
      if section=>AccelTable_entries
        section:=AccelTable_entries-1
      MotorAccel[id] := section


  if speed =< HIGHSPEEDTHRESH
    setMotor(id, 0)
  elseif speed => LOWSPEEDTHRESH
    setMotor(id, MOTORPERIOD/2)
  else
    setMotor(id, MOTORPERIOD/2)
  
  'else
    't:=(speed-LOWSPEEDTHRESH) / (LOWSPEEDTHRESH-HIGHSPEEDTHRESH)
    ' this calculation is bound to overflow...
    'setMotor(id, (MOTORPERIOD/2) + (MOTORPERIOD*(LOWSPEEDTHRESH-speed))/(LOWSPEEDTHRESH-HIGHSPEEDTHRESH)) 

  if reverse
    return speed | dirBit
  return speed

pri PwmStart
  PwmZAddr:=@PwmArrayZ        
  PwmPeriod := MOTORPERIOD 
  cognew(@PwmCog, 0)

  PwmZAddr:=@PwmServoArrayZ   
  PwmPeriod := SERVOPERIOD 
  'cognew(@PwmCog, 0)
pri MemorySetup
  'nextTimeAddr := @nextTimeBuffer
  'nextMaskAddr := @nextMaskBuffer
  'nextTimeAddr2 := @nextTimeBuffer
  'nextMaskAddr2 := @nextMaskBuffer

  rxBufferAddr := @rxBuffer     

pri enableMotors
                              
  phaseMask_l[6] := @lspeed
  phaseMask_l[7] := @PwmArrayZ       
  'pwmArrayAddr := @PwmArray
  cognew(@MotorControl, @phaseMask_l)

  phaseMask_r[6] := @rspeed
  phaseMask_r[7] := @PwmArrayZ + 8
  cognew(@MotorControl, @phaseMask_r)
                          

pri phaseSetup | N, i
  'set all motor pins to output (low)
  n:=0
  repeat 3               
    dira[motor_l_high[N]]~~
    dira[motor_r_high[N]]~~    
    outa[motor_l_high[N]]~
    outa[motor_r_high[N]]~
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
dat
              org 0

PwmCog

                              
              mov LastPwmZAddr, #NPWM
              shl LastPwmZAddr, #3 'x8 x12??
              add LastPwmZAddr, PwmZAddr
              
                             

              
:NextPeriod

        ' Turn everything off
              mov PwmZPtr, PwmZAddr   
              mov count, #0
              mov outa, #0

:resetPwm           
              rdlong zmask, PwmZPtr
              or dira, zmask                
              add PwmZPtr, #8
              cmp PwmZPtr, LastPwmZAddr wc,wz
        if_nz jmp #:resetPwm  
                              
:Loop                   
        
        ' check if one of the PWM's is expired
              mov PwmZPtr, PwmZAddr   
              add count, #1 

:testPwm                                
              rdlong zmask, PwmZPtr 
              add PwmZPtr, #4                     
              rdlong expire, PwmZPtr
              cmp count, expire wc  
        if_nc or outa, zmask
              add PwmZPtr, #4
              cmp PwmZPtr, LastPwmZAddr wc,wz
        if_nz jmp #:testPwm

              cmp count, PwmPeriod              wc
        if_nc jmp #:NextPeriod
              jmp #:Loop
                        
PwmPeriod     long 80
PwmZPtr       long 0
PwmZAddr      long 0
LastPwmZAddr long 0

expire  long 0
zmask   long 0

count long 0


dat
MotorControl
        org 0
              ' control a single motor at a certain speed
        mov pwmArrayPtr, par
                                        
        
        rdlong phase1, pwmArrayPtr
        add pwmArrayPtr, #4

        rdlong phase2, pwmArrayPtr
        add pwmArrayPtr, #4

        rdlong phase3, pwmArrayPtr
        add pwmArrayPtr, #4

        rdlong phase4, pwmArrayPtr
        add pwmArrayPtr, #4

        rdlong phase5, pwmArrayPtr
        add pwmArrayPtr, #4

        rdlong phase6, pwmArrayPtr      
        add pwmArrayPtr, #4
        
        rdlong spdAddr, pwmArrayPtr
        add pwmArrayPtr, #4   

        rdlong pwmArrayAddr, pwmArrayPtr
        add pwmArrayPtr, #4   
                               
'        call #Activate                          ' activate the pwm

      
:stall  'turn off the motors when we have no target speed

        call #Stall                             ' disable motor pwms
               
        rdlong phaseDelay, spdAddr              ' check if we are too slow
        cmp phaseDelay, minDelay wc
if_c    jmp #:stall
               
        mov phaseTime, cnt                      ' reset the next phase time
        add phaseTime, phaseDelay
        
:Loop                                         

        rdlong phaseDelay, spdAddr              ' read in the new delay
        mov dir, phaseDelay           ' get direction bit
        and phaseDelay, speedBits     ' only use the lower bits for speed control
        cmp phaseDelay, minDelay wc             ' test if we are too slow
if_c    jmp #:stall

        mov phaseTime, cnt                      ' reset the next phase time
        add phaseTime, phaseDelay


        waitcnt phaseTime, phaseDelay           ' wait for the next commutation phase

        test dir, dirBit wz
if_z    call #nextPhase                         ' switch bitmask for the next phase
if_nz   call #prevPhase        
        jmp #:Loop

Stall
        mov pwmArrayPtr, pwmArrayAddr
        'add pwmArrayPtr, #4
        mov phaseMask, #0
        wrlong phaseMask, pwmArrayPtr                           
Stall_ret ret

'Activate
'        mov pwmArrayPtr, pwmArrayAddr
'        wrlong offTime, pwmArrayPtr  
'Activate_ret ret

PrevPhase                             
:get    mov phaseMask, phase1
        sub :get, #1 'update to previous phase mask
        
        add phase, #1
        cmp phase, #7 wz
if_z    mov phase, #1
if_z    movs :get, #phase6 



        mov pwmArrayPtr, pwmArrayAddr
        wrlong phaseMask, pwmArrayPtr       
PrevPhase_ret ret

NextPhase          
:get    mov phaseMask, phase1
        add :get, #1 'update to next phase mask
        
        sub phase, #1   wz
if_z    mov phase, #6
if_z    movs :get, #phase1 


        'or dira,        phaseMask
        'mov outa,       phaseMask  

        mov pwmArrayPtr, pwmArrayAddr
        'add pwmArrayPtr, #4
        wrlong phaseMask, pwmArrayPtr 
NextPhase_ret ret

dir           long 0
dirBit        long $F8000000
speedBits     long $07FFFFFF
         
offTime       long 1
minDelay      long ZEROSPEED


phaseTime     long 0       

phaseMask     long 0
phaseDelay    long 0
phase         long 6

pwmArrayAddr  long 0
pwmArrayPtr   long 0
                  
                  
spdAddr       long 0
phase1        long 0
phase2        long 0
phase3        long 0
phase4        long 0
phase5        long 0
phase6        long 0



dat
SpiAdc
              org 0
        andn outa, ADCCSMASK ' cs low
        or outa, ADCCLKMASK

        or dira, ADCCLKMASK
        or dira, ADCCSMASK
        or dira, ADCDINMASK
Loop
        mov curCh, 0
        call #ReadADC
        'mov tmpVal, #20
        wrlong tmpVal, dbg1Ptr
        jmp #Loop

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

ADCCSMASK  long %100000
ADCDINMASK long %001000
ADCCLKMASK long %000010

ADCDataPtr long 0

dbg1Ptr long 0
dbg2Ptr long 0
dbg3Ptr long 0
dbg4Ptr long 0

dat
        org 0
        
txSpi

              or dira, p16
              or dira, p17
              or dira, p18
              or dira, p19
              or dira, p20
              or dira, p21
              or dira, p22


              or outa, p16

              mov rxWord, #0
              mov curBit, #1

:waitOff      test TxCLKMASK, ina  WZ
if_nz         jmp #:waitOff


:waitOn
              test TxCLKMASK, ina  WZ
if_z          jmp #:waitOn


              mov tmp1, cnt
              add tmp1, startDelay
              waitcnt tmp1, #0
              
              
:Loop
                                   

              mov tmp1, cnt
              add tmp1, freqDelay
              waitcnt tmp1, #0

              
              test TxDIMASK, ina WZ       
if_nz         or rxWord, curBit
              xor outa, p18
              
              cmp curBit, maxBit WZ
              shl curBit, #1  

if_z          jmp #:NextWord

jmp #:Loop


:nextWord
              xor outa, p16
              mov rxBufferPtr, rxWord
              shr rxBufferPtr, #28              ' take only the upper 4 bytes to use as an index 
              shl rxBufferPtr, #2               ' multiply offset by 4 to get word-aligned address
              add rxBufferPtr, rxBufferAddr     ' add offset to base address

              wrlong rxWord, rxBufferAddr
              
              and rxWord, rxDataMask            ' crop the index bits out of the rx'd value     
              wrlong rxWord, rxBufferPtr        ' store rx'd value into the designated array index  
              
              mov rxWord, #0                    'reset input word
              mov curBit,  #1                   'reset bit counter
              jmp :waitOff
'nextWord_ret  ret
                        
startDelay    long  25000
freqDelay     long 100000

TxCLKMASK    long %0000000100
TxDIMASK     long %0000010000

tmp1    long 0

rxWord  long 0
curBit  long 1
rxBufferAddr  long 0
rxBufferPtr   long 0

maxBit  long  %10000000000000000000000000000000
rxDataMask long %00001111111111111111111111111111
                                       
p16     long %10000000000000000
p17     long %100000000000000000
p18     long %1000000000000000000 
p19     long %10000000000000000000
p20     long %100000000000000000000
p21     long %1000000000000000000000
p22     long %10000000000000000000000



{


dat
TxSpi                 
              org 0                    
              or dira, p16
              or dira, p17
              or dira, p18
              or dira, p19
              or dira, p20
              or dira, p21
              or dira, p22


              or outa, p20

              mov rxWord, #0
              mov curBit, #1
              
:Loop
              
:waitOff
              test TxCLKMASK, ina  WZ
if_nz         jmp #:waitOff

              nop
              nop
              nop
              nop
              nop
              nop

              test TxCLKMASK, ina  WZ
if_nz         jmp #:waitOff

              andn outa, p17


:waitPulse
              test TxCLKMASK, ina  WZ
if_z          jmp #:waitpulse

              
              test TxCLKMASK, ina  WZ
if_z          jmp #:waitpulse

              or outa, p17 
              xor outa, p21

:readBit
                 
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
              nop
                    
              test TxDIMASK, ina WZ 
if_nz         test TxDIMASK, ina WZ       
if_nz         or rxWord, curBit


              cmp curBit, maxBit WZ
              shl curBit, #1  

if_z          call #NextWord

jmp #:Loop


nextWord
              xor outa, p16
              mov rxBufferPtr, rxWord
              shr rxBufferPtr, #28              ' take only the upper 4 bytes to use as an index 
              shl rxBufferPtr, #2               ' multiply offset by 4 to get word-aligned address
              add rxBufferPtr, rxBufferAddr     ' add offset to base address

              wrlong rxWord, rxBufferAddr
              
              and rxWord, rxDataMask            ' crop the index bits out of the rx'd value     
              wrlong rxWord, rxBufferPtr        ' store rx'd value into the designated array index  
              
              mov rxWord, #0                    'reset input word
              mov curBit,  #1                   'reset bit counter
nextWord_ret  ret
                              
TxCLKMASK    long %0000000100
TxDIMASK     long %0000010000

rxWord  long 0
curBit  long 1
rxBufferAddr  long 0
rxBufferPtr   long 0

maxBit  long  %10000000000000000000000000000000

rxDataMask long %00001111111111111111111111111111
                                       
p16     long %10000000000000000
p17     long %100000000000000000
p18     long %1000000000000000000 
p19     long %10000000000000000000
p20     long %100000000000000000000
p21     long %1000000000000000000000
p22     long %10000000000000000000000

}

                          {
dat
SpiSlave
              org 0

              or dira, p23
              or dira, p22 
              or dira, TXMASK

              andn dira, RXMASK
              andn dira, CSMASK
              andn dira, CLKMASK
              
:Loop2                                   
              mov rxWord, #0  'reset input word
              mov rxBits,  #32 'reset bit counter

              
              andn outa, p23
:wait_cs      test CSMASK, ina WZ
if_nz         jmp #:wait_cs


:SpiLoop      ' wait for falling/rising edge
          
:wait_edge1   test CSMASK, ina  WZ
if_nz         jmp #:Loop2
              test CLKMASK, ina WZ
if_z          jmp #:wait_edge1
              
:setbit
              

:wait_edge2   test CSMASK, ina  WZ
if_nz          jmp #:Loop2
              test CLKMASK, ina WZ
if_nz         jmp #:wait_edge2
              
:readbit
              test RXMASK, ina  WZ
                            

              shl rxWord, #1
              
if_z          andn outa, p23
if_nz         or outa, p23
if_nz         add rxWord, #1
              sub rxBits, #1     WZ
if_z          call #nextWord
                            

              jmp #:SpiLoop

nextWord
              xor outa, p22
              mov rxBufferPtr, rxWord
              shr rxBufferPtr, #28              ' take only the upper 4 bytes to use as an index 
              shl rxBufferPtr, #2               ' multiply offset by 4 to get word-aligned address
              add rxBufferPtr, rxBufferAddr     ' add offset to base address

              and rxWord, rxDataMask            ' crop the index bits out of the rx'd value     
              wrlong rxWord, rxBufferPtr        ' store rx'd value into the designated array index  
              mov rxWord, #0                    'reset input word
              mov rxBits,  #32                  'reset bit counter
nextWord_ret  ret

Neg1_2  long -1  
rxBits long 0
rxWord long 0
rxDataMask long %00001111111111111111111111111111


mode long 0
CSMASK long  %00000000100
RXMASK long  %00000010000
TXMASK long  %00001000000
CLKMASK long %00100000000
CPOL long 0
CPHA long 0

rxBufferAddr long 0
rxBufferPtr   long 0
          
p23 long %00000000000000000000000
p22 long %0000000000000000000000 
                            }
{dat
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
              'or nextMask2, thisMask ' OR it to the current mask
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
}    