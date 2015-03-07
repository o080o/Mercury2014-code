all:	main.hex

main.hex:	main.c motor_control.c sensors.c usart.c
	xc8 main.c motor_control.c sensors.c usart.c --chip=16F877A

tmp:
	rm *.p1 *.as *.pre *.cmf *.cof *.d *.sdb *.sym *.obj *.rlf *.hxl *.lst -f
clean: tmp
	rm *.hex -f
