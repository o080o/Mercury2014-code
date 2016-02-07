all:	main.hex

main.hex:	main.c motor_control.c servo_control.c
	xc8 main.c motor_control.c servo_control.c sensors.c usart.c --chip=16F877A
	rm *.p1 *.as *.pre *.cmf *.cof *.d *.sdb *.sym *.obj *.rlf *.hxl *.lst -f

rmtmp:
	rm *.p1 *.as *.pre *.cmf *.cof *.d *.sdb *.sym *.obj *.rlf *.hxl *.lst -f

clean: rmtmp
	rm *.hex -f
