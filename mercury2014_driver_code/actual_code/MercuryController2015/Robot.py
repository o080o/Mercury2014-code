#Program reads inputs from XBox 360 controller and sends
#data packets to IP address to be read by the robot 

import pygame.surfarray
import time
import socket
import math

#initiate pygame 
pygame.init()
pygame.joystick.init()
xbox360 = pygame.joystick.Joystick(0)
xbox360.init() 

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

#socket varibles
ip         = "192.168.42.1"
port       = 1234
socket.setdefaulttimeout(10.0)
robot      = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
robot.settimeout(0.25)
robot.bind(("", port))
packetID   = 1
packetQueue = []  #used to keep track of acknowledged packets

#sends packet to binded IP
def sendPacket(message, paramsList):
	global packetID
	packet = chr(packetID) + message
	for i in paramsList:
		packet += " " + str(i)
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

userInput = ""	
losCounter = 0
speed = 0
direction = 0
msg1 = ""
msg2 = ""
parameters1 = []
parameters2 = []
SENSITIVITY = 0.25

pygame.init()
size = width, height = 640, 480
black = 0, 0, 0
screen = pygame.display.set_mode(size)
screen.fill(black)
pygame.display.flip()

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
					msg1 = "setSpeed"
					parameters1 = [ "5000", "1" ]
				elif event.key == pygame.K_DOWN:
					msg1 = "setSpeed"
					parameters1 = [ "5000", "0" ]
				elif event.key == pygame.K_LEFT:
					msg1 = "setSteering"
					parameters1 = [ "0" ]
				elif event.key == pygame.K_RIGHT:
					msg1 = "setSteering"
					parameters1 = [ "90" ]
				elif event.key == pygame.K_w:
					msg1 = "setClawMotion"
					parameters1 = [ "2" ]
				elif event.key == pygame.K_s:
					msg1 = "setClawMotion"
					parameters1 = [ "0" ]
			elif event.type == pygame.KEYUP:
				if event.key == pygame.K_UP or event.key == pygame.K_DOWN:
					msg1 = "setSpeed"
					parameters1 = [ "0", "1" ]
				if event.key == pygame.K_w or event.key == pygame.K_s:
					msg1 = "setClawMotion"
					parameters1 = [ "1" ]
				if event.key == pygame.K_LEFT or event.key == pygame.K_RIGHT:
					msg1 = "setSteering"
					parameters1 = [ "45" ]
			elif event.type == pygame.JOYBUTTONDOWN:               #button press
				'''for i in range(0, xbox360.get_numbuttons()):
					if(xbox360.get_button(i) == True):
						buttonPressed = i'''
				buttonPressed = event.button
				print "Button %d pressed!" % buttonPressed
				if buttonPressed == BUTTON_B:
					msg1 = "setClawMotion"
					parameters1 = [ "2" ]
				elif buttonPressed == BUTTON_A:
					msg1 = "setClawMotion"
					parameters1 = [ "0" ]
			elif event.type == pygame.JOYBUTTONUP:
				if (event.button == BUTTON_B) or (event.button == BUTTON_A):
					msg1 = "setClawMotion"
					parameters1 = [ "1" ]
			elif event.type == pygame.JOYAXISMOTION:                #joystick movement
				if event.axis == AXIS_LY or event.axis == AXIS_LX:
					x = xbox360.get_axis(AXIS_LX)
					y = xbox360.get_axis(AXIS_LY)
					
					x = int( ( SENSITIVITY * (x * x * x) ) + ( (1 - SENSITIVITY) * x ) )
					y = int( ( SENSITIVITY * (y * y * y) ) + ( (1 - SENSITIVITY) * y ) )
					speed = -100 * math.sqrt(x*x + y*y)
					if( (speed < 20) and (speed > -20) ):
						speed = 0;
					elif(speed > 20):
						speed = speed - 20
					elif(speed < -20):
						speed = speed + 20
					
					print "DEBUG -- speed = %d" % (speed)
					
					direction = 0
					if speed > 0:
						direction = 1
						
					#Scale from range of (-80, 80) to range of (0, 5000)
					speed = ( ( ( 5000 - 0 ) * ( speed - (-80) ) ) / (80 - (-80) ) ) + 0
	
					msg1 = "setSpeed"
					parameters1 = [str(speed), str(direction)]
				#elif event.axis == AXIS_LX:
					wheelAngle = 100 * xbox360.get_axis(AXIS_LX)
					if( (wheelAngle < 20) and (wheelAngle > -20) ):
						wheelAngle = 0;
					elif(wheelAngle > 20):
						wheelAngle = wheelAngle - 20
					elif(wheelAngle < -20):
						wheelAngle = wheelAngle + 20
						
					#Scale from range of (-80, 80) to range of (0, 90)
					wheelAngle = ( ( ( 90 - 0 ) * ( wheelAngle - (-80) ) ) / (80 - (-80) ) ) + 0
					
					msg2 = "setSteering"
					parameters2 = [ str(wheelAngle) ]
				elif event.axis == AXIS_RY:
					cannonMotion = 100 * xbox360.get_axis(AXIS_RY)
					if( (cannonMotion < 20) and (cannonMotion > -20) ):
						cannonMotion = 0;
					elif(cannonMotion > 20):
						cannonMotion = cannonMotion - 20
					elif(cannonMotion < -20):
						cannonMotion = cannonMotion + 20
						
					#Scale from range of (-80, 80) to range of (0, 2)
					cannonMotion = ( ( ( 2 - 0 ) * ( cannonMotion - (-80) ) ) / (80 - (-80) ) ) + 0
					
					msg1 = "setCannonMotion"
					parameters1 = [ str(cannonMotion) ]
			'''elif event.type == JOYHATMOTION:                        #D-pad
				if xbox360.get_hat(0) == [0, 1]:
					print "D-Pad up!"
				elif xbox360.get_hat(0) == [1, 0]:
					print "D-Pad right!"
				elif xbox360.get_hat(0) == [0, -1]:
					print "D-Pad down!"
				elif xbox360.get_hat(0) == [-1, 0]:
					"D-pad left!" '''
	sendPacket(msg1, parameters1)
	print "%d %s %s" %(packetID - 1, msg1, parameters1)
	time.sleep(0.05)
	try:
		id, command, params = parseMessage()
		if(id == 0 and int(params[0]) == packetID - 1):
			print "%d %s %s" % (id, command, params)
			losCounter = 0
		else:
			print "Robot didn't acknowledge"
			losCounter += 1
	except:
		print "Robot didn't acknowledge"
		losCounter += 1
	if(losCounter >= 10):
		print "SIGNAL LOST!"
	
	if(msg2 != ""):
		sendPacket(msg2, parameters2)
		print "%d %s %s" %(packetID - 1, msg1, parameters1)
		time.sleep(0.05)
		try:
			id, command, params = parseMessage()
			if(id == 0 and int(params[0]) == packetID - 1):
				print "%d %s %s" % (id, command, params)
				losCounter = 0
			else:
				print "Robot didn't acknowledge"
				losCounter += 1
		except:
			print "Robot didn't acknowledge"
			losCounter += 1
		if(losCounter >= 10):
			print "SIGNAL LOST!"