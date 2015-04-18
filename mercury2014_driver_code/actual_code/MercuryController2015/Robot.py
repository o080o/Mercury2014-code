#Program reads inputs from XBox 360 controller and sends
#data packets to IP address to be read by the robot 

import pygame
import time
import socket
import math
import os
import sys

#initiate pygame 
pygame.init()
pygame.joystick.init()
xbox360 = pygame.joystick.Joystick(0)
xbox360.init() 

#**********************************************************************************
# Connection information

ip		= "192.168.2.254"
port	= 1234

#**********************************************************************************

# Xbox controller definitions
AXIS_LX = 0
AXIS_LY = 1
AXIS_TRIGGERS = 2
AXIS_RY = 3
AXIS_RX = 4
BUTTON_A = 0
BUTTON_B = 1
BUTTON_X = 2
BUTTON_Y = 3
BUTTON_LB = 4
BUTTON_RB = 5

# Servo delay constants
lTurnServoMin		= 270
lTurnServoMax		= 350
lTurnServoNeutral	= 310
rTurnServoMin		= 270
rTurnServoMax		= 350
rTurnServoNeutral	= 310
vertServoMin		= 270
vertServoMax		= 350
vertServoNeutral	= 310
launchServoMin		= 270
launchServoMax		= 350
launchServoNeutral	= 310
horzServoMin		= 270
horzServoMax		= 350
horzServoNeutral	= 310

# Bit masks
_address		= 0xF0000000
_data			= 0x0FFFFFFF
_data_msb		= 0x08
_3rdByte		= 0x0F000000
_2ndByte		= 0x00FF0000
_1stByte		= 0x0000FF00
_0thByte		= 0x000000FF
_rxBuffer		= 0x00000000
_lspeedTarget	= 0x00000010
_rspeedTarget	= 0x00000020
_lTurnServo		= 0x00000030
_rTurnServo		= 0x00000040
_horzServo		= 0x00000050
_vertServo		= 0x00000060
_launchServo	= 0x00000070

#socket varibles
socket.setdefaulttimeout(10.0)
robot      = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
robot.settimeout(0.25)
robot.bind(("", port))
packetID   = 1
packetQueue = []  #used to keep track of acknowledged packets

# Miscellaneous variables
userInput = ""	
losCounter = 0
speed = 0
direction = 0
msg1 = ""
msg2 = ""
data = ['', '', '', '']
toSend = []
parameters1 = []
parameters2 = []
SENSITIVITY = 0.1

#sends packet to binded IP
def sendPacket(message):
	global packetID
	packet = chr(packetID) + message
	#for i in paramsList:
	#	packet += " " + str(i)
	robot.sendto(packet, (ip, port))
	packetID += 1
	if(packetID == 256):
		packetID = 1;

def parseMessage():
	message = robot.recv(500)
	receivedID = ord(message[0:1])
	receivedMessage = message[1:]
	lst = receivedMessage.split(" ")
	command = lst[0]
	params = lst[1:] 
	ack = "\0 ACK %d" % receivedID
	robot.sendto(ack, (ip, port))
	return (receivedID, command, params)

def buildMessage(value, mask):
	data[0] = chr(value & _0thByte)
	data[1] = chr( (value & _1stByte) >> 8)
	data[2] = chr( (value & _2ndByte) >> 16)
	data[3] = chr( (value & _3rdByte) >> 24 )
	data[3] = chr( mask | ord(data[3]) )
	return data[3] + data[2] + data[1] + data[0]
	
pygame.init()
size = width, height = 320, 240
black = 0, 0, 0
screen = pygame.display.set_mode(size)
screen.fill(black)
pygame.display.flip()

#Initialize messages to send to robot
lspeedOut 		= buildMessage(0, _lspeedTarget)
rspeedOut 		= buildMessage(0, _rspeedTarget)
lTurnServoOut 	= buildMessage(lTurnServoNeutral, _lTurnServo)
rTurnServoOut 	= buildMessage(rTurnServoNeutral, _rTurnServo)
vertServoOut 	= buildMessage(vertServoNeutral, _vertServo)
launchServoOut 	= buildMessage(launchServoNeutral, _launchServo)

while 1:	
	#Joystick input 
	if pygame.joystick.get_count < 1:
		print "No Joysticks!"
		exit = True
	
	msg2 = ""
	
	for event in pygame.event.get():
			if event.type == pygame.QUIT:
				exit = True
			elif event.type == pygame.KEYDOWN:
				if event.key == pygame.K_UP:
					data[0] = chr(1000000 & _0thByte)
					data[1] = chr( (1000000 & _1stByte) >> 8)
					data[2] = chr( (1000000 & _2ndByte) >> 16)
					data[3] = chr( (1000000 & _3rdByte) >> 24 )
					data[3] = chr( _lspeedTarget | ord(data[3]) )
					data[3] = chr( ord(data[3]) | _data_msb )
					lspeedOut = data[3] + data[2] + data[1] + data[0]
					data[0] = chr(1000000 & _0thByte)
					data[1] = chr( (1000000 & _1stByte) >> 8)
					data[2] = chr( (1000000 & _2ndByte) >> 16)
					data[3] = chr( (1000000 & _3rdByte) >> 24 )
					data[3] = chr( _rspeedTarget | ord(data[3]) )
					data[3] = chr( ord(data[3]) | _data_msb )
					rspeedOut = data[3] + data[2] + data[1] + data[0]
				elif event.key == pygame.K_DOWN:
					data[0] = chr(1000000 & _0thByte)
					data[1] = chr( (1000000 & _1stByte) >> 8)
					data[2] = chr( (1000000 & _2ndByte) >> 16)
					data[3] = chr( (1000000 & _3rdByte) >> 24 )
					data[3] = chr( _lspeedTarget | ord(data[3]) )
					data[3] = chr( ord(data[3]) & (~_data_msb) )
					lspeedOut = data[3] + data[2] + data[1] + data[0]
					data[0] = chr(1000000 & _0thByte)
					data[1] = chr( (1000000 & _1stByte) >> 8)
					data[2] = chr( (1000000 & _2ndByte) >> 16)
					data[3] = chr( (1000000 & _3rdByte) >> 24 )
					data[3] = chr( _rspeedTarget | ord(data[3]) )
					data[3] = chr( ord(data[3]) & (~_data_msb) )
					rspeedOut = data[3] + data[2] + data[1] + data[0]
				elif event.key == pygame.K_LEFT:
					lTurnServoOut 	= buildMessage(lTurnServoMin, _lTurnServo)
					rTurnServoOut 	= buildMessage(rTurnServoMax, _rTurnServo)
				elif event.key == pygame.K_RIGHT:
					lTurnServoOut 	= buildMessage(lTurnServoMax, _lTurnServo)
					rTurnServoOut 	= buildMessage(rTurnServoMin, _rTurnServo)
				elif event.key == pygame.K_w:
					#msg1 = "setClawMotion"
					#parameters1 = [ "2" ]
				elif event.key == pygame.K_s:
					#msg1 = "setClawMotion"
					#parameters1 = [ "0" ]
			elif event.type == pygame.KEYUP:
				if event.key == pygame.K_UP or event.key == pygame.K_DOWN:
					data[0] = chr(0 & _0thByte)
					data[1] = chr( (0 & _1stByte) >> 8)
					data[2] = chr( (0 & _2ndByte) >> 16)
					data[3] = chr( (0 & _3rdByte) >> 24 )
					data[3] = chr( _lspeedTarget | ord(data[3]) )
					data[3] = chr( ord(data[3]) | _data_msb )
					lspeedOut = data[3] + data[2] + data[1] + data[0]
					data[0] = chr(0 & _0thByte)
					data[1] = chr( (0 & _1stByte) >> 8)
					data[2] = chr( (0 & _2ndByte) >> 16)
					data[3] = chr( (0 & _3rdByte) >> 24 )
					data[3] = chr( _rspeedTarget | ord(data[3]) )
					data[3] = chr( ord(data[3]) | _data_msb )
					rspeedOut = data[3] + data[2] + data[1] + data[0]
				if event.key == pygame.K_w or event.key == pygame.K_s:
					#msg1 = "setClawMotion"
					#parameters1 = [ "1" ]
				if event.key == pygame.K_LEFT or event.key == pygame.K_RIGHT:
					lTurnServoOut 	= buildMessage(lTurnServoNeutral, _lTurnServo)
					rTurnServoOut 	= buildMessage(rTurnServoNeutral, _rTurnServo)
			elif event.type == pygame.JOYBUTTONDOWN:               #button press
				buttonPressed = event.button
				print "Button %d pressed!" % buttonPressed
				if buttonPressed == BUTTON_LB:
					clawMotion = launchServoMin		#Down
					launchServoOut = buildMessage(clawMotion, _launchServo)
					toSend = [launchServoOut]
				elif buttonPressed == BUTTON_RB:
					clawMotion = launchServoMax		#Up
					launchServoOut = buildMessage(clawMotion, _launchServo)
					toSend = [launchServoOut]
			elif event.type == pygame.JOYBUTTONUP:
				if (event.button == BUTTON_LB) or (event.button == BUTTON_RB):
					clawMotion = launchServoNeutral		#Motionless
					launchServoOut = buildMessage(clawMotion, _launchServo)
					toSend = [launchServoOut]
			elif event.type == pygame.JOYAXISMOTION:                #joystick movement
				if event.axis == AXIS_LY or event.axis == AXIS_LX:
					x = xbox360.get_axis(AXIS_LX)
					y = xbox360.get_axis(AXIS_LY)
					
					if( (x < .2) and (x > -.2) ):
						x = 0;
					elif(x > .2):
						x = x - .2
					elif(x < -.2):
						x = x + .2
						
					if( (y < .2) and (y > -.2) ):
						y = 0;
					elif(y > .2):
						y = y - .2
					elif(y < -.2):
						y = y + .2
					
					if(y < 0):
						direction = 1
					else:
						direction = 0
					
					x = ( SENSITIVITY * (x * x * x) ) + ( (1 - SENSITIVITY) * x )
					y = ( SENSITIVITY * (y * y * y) ) + ( (1 - SENSITIVITY) * y )
					speed = int(100 * math.sqrt(x*x + y*y))
					if(speed > 80):
						speed = 80
					elif(speed < -80):
						speed = -80
						
					#Scale from range of (0, 80) to range of (8000000, 500)
					speed = ( ( ( 500 - 8000000 ) * ( speed - (0) ) ) / (80 - (0) ) ) + 8000000
					if(speed > 7950000):
						speed = 0
					
					data[0] = chr(speed & _0thByte)
					data[1] = chr( (speed & _1stByte) >> 8)
					data[2] = chr( (speed & _2ndByte) >> 16)
					data[3] = chr( (speed & _3rdByte) >> 24 )
					data[3] = chr( _lspeedTarget | ord(data[3]) )
					
					if(direction == 1):
						data[3] = chr( ord(data[3]) | _data_msb )
					else:
						data[3] = chr( ord(data[3]) & (~_data_msb) )
					
					lspeedOut = data[3] + data[2] + data[1] + data[0]
					
					data[0] = chr(speed & _0thByte)
					data[1] = chr( (speed & _1stByte) >> 8)
					data[2] = chr( (speed & _2ndByte) >> 16)
					data[3] = chr( (speed & _3rdByte) >> 24 )
					data[3] = chr( _rspeedTarget | ord(data[3]) )
					
					if(direction == 1):
						data[3] = chr( ord(data[3]) | _data_msb )
					else:
						data[3] = chr( ord(data[3]) & (~_data_msb) )
					
					rspeedOut = data[3] + data[2] + data[1] + data[0]
					
					wheelAngle = int( 100 * xbox360.get_axis(AXIS_LX) )
					if( (wheelAngle < 20) and (wheelAngle > -20) ):
						wheelAngle = 0;
					elif(wheelAngle > 20):
						wheelAngle = wheelAngle - 20
					elif(wheelAngle < -20):
						wheelAngle = wheelAngle + 20
						
					#Scale left servo input from range of (-80, 80) to range of (lTurnServoMin, lTurnServoMax)
					lServoAngle = ( ( ( lTurnServoMax - lTurnServoMin ) * ( wheelAngle - (-80) ) ) / (80 - (-80) ) ) + lTurnServoMin
					
					#Scale right servo input from range of (-80, 80) to range of (rTurnServoMax, rTurnServoMin)
					rServoAngle = ( ( ( rTurnServoMin - rTurnServoMax ) * ( wheelAngle - (-80) ) ) / (80 - (-80) ) ) + rTurnServoMax

					lTurnServoOut = buildMessage(lServoAngle, _lTurnServo)
					rTurnServoOut = buildMessage(rServoAngle, _rTurnServo)
					
					toSend = [lspeedOut, rspeedOut, lTurnServoOut, rTurnServoOut]
				
				elif event.axis == AXIS_RY:
					cannonMotion = 100 * xbox360.get_axis(AXIS_RY)
					if( (cannonMotion < 20) and (cannonMotion > -20) ):
						cannonMotion = 0;
					elif(cannonMotion > 20):
						cannonMotion = cannonMotion - 20
					elif(cannonMotion < -20):
						cannonMotion = cannonMotion + 20
						
					#Scale from range of (-80, 80) to range of (0, 2)
					cannonMotion = int( round( ( ( ( 2 - 0 ) * ( cannonMotion - (-80) ) ) / (80 - (-80) ) ) + 0 ) )
					if(cannonMotion == 0):
						vertServoOut = vertServoMin	#Down
					elif(cannonMotion == 2):
						vertServoOut = vertServoMax	#Up
					else:
						vertServoOut = vertServoNeutral	#Motionless
					
					vertServoOut = buildMessage(vertServoOut, _vertServo)
					toSend = [vertServoOut]
					
					msg1 = "setCannonMotion"
					#parameters1 = [ str(cannonMotion) ]

	# END OF EVENT LOOP -----------------------------------------------------------
	
	for msg in toSend:
		sendPacket(msg)
		print "%d %s" %(packetID - 1, ' '.join(format(ord(x), 'b') for x in msg))
		time.sleep(0.2)
		try:
			id, command, params = parseMessage()
			if(id == 0 and int(params[0]) == packetID - 1):
				print "%d %s %s" % (id, command)
				losCounter = 0
			else:
				print "Robot didn't acknowledge"
				losCounter += 1
		except:
			print "Robot didn't acknowledge"
			losCounter += 1
		if(losCounter >= 10):
			print "SIGNAL LOST!"
