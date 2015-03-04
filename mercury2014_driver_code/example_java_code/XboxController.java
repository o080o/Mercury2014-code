import net.java.games.input.*;

public class XboxController implements Controller {

	private ControllerEnvironment environment;
	private Controller[] controllers;
	private Component[] components;
	private Controller xbox;
	
	public static Component BUTTON_A;
	public static Component BUTTON_B;
	public static Component BUTTON_X;
	public static Component BUTTON_Y;
	public static Component BUTTON_LB;
	public static Component BUTTON_RB;
	public static Component BUTTON_LS;
	public static Component BUTTON_RS;
	public static Component BUTTON_Start;
	public static Component BUTTON_Back;
	public static Component STICK_LX;
	public static Component STICK_LY;
	public static Component STICK_RX;
	public static Component STICK_RY;
	public static Component TRIGGERS;
	public static Component DPAD;
	
	public XboxController() {
		environment = ControllerEnvironment.getDefaultEnvironment();
		controllers = environment.getControllers();
		
		for(int i = 0; i < controllers.length; i++) {
			if(controllers[i].getType().equals(Controller.Type.GAMEPAD)) {
				xbox = controllers[i];
				break;
			}
		}
		
		components = xbox.getComponents();
		for(int i = 0; i < components.length; i++) {
			if(components[i].getName().equals("Button 0")) {
				BUTTON_A = components[i];
			}
			else if(components[i].getName().equals("Button 1")) {
				BUTTON_B = components[i];
			}
			else if(components[i].getName().equals("Button 2")) {
				BUTTON_X = components[i];
			}
			else if(components[i].getName().equals("Button 3")) {
				BUTTON_Y = components[i];
			}
			else if(components[i].getName().equals("Button 4")) {
				BUTTON_LB = components[i];
			}
			else if(components[i].getName().equals("Button 5")) {
				BUTTON_RB = components[i];
			}
			else if(components[i].getName().equals("Button 6")) {
				BUTTON_Back = components[i];
			}
			else if(components[i].getName().equals("Button 7")) {
				BUTTON_Start = components[i];
			}
			else if(components[i].getName().equals("Button 8")) {
				BUTTON_LS = components[i];
			}
			else if(components[i].getName().equals("Button 9")) {
				BUTTON_RS = components[i];
			}
			else if(components[i].getName().equals("X Axis")) {
				STICK_LX = components[i];
			}
			else if(components[i].getName().equals("Y Axis")) {
				STICK_LY = components[i];
			}
			else if(components[i].getName().equals("X Rotation")) {
				STICK_RX = components[i];
			}
			else if(components[i].getName().equals("Y Rotation")) {
				STICK_RY = components[i];
			}
			else if(components[i].getName().equals("Z Axis")) {
				TRIGGERS = components[i];
			}
			else if(components[i].getName().equals("Hat Switch")) {
				DPAD = components[i];
			}
		}
	}
	
	public Component getComponent(Component.Identifier id) {
		return xbox.getComponent(id);
	}
	
	public Component[] getComponents() {
		return xbox.getComponents();
	}
	
	public Controller[] getControllers() {
		return xbox.getControllers();
	}
	
	public EventQueue getEventQueue() {
		return xbox.getEventQueue();
	}
	
	public String getName() {
		return xbox.getName();
	}
	
	public int getPortNumber() {
		return xbox.getPortNumber();
	}
	
	public Controller.PortType getPortType() {
		return xbox.getPortType();
	}
	
	public Rumbler[] getRumblers() {
		return xbox.getRumblers();
	}
	
	public Controller.Type getType() {
		return xbox.getType();
	}
	
	public boolean poll() {
		return xbox.poll();
	}
	
	public void setEventQueueSize(int size) {
		xbox.setEventQueueSize(size);
	}
}