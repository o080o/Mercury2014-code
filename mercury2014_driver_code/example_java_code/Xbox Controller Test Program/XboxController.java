import net.java.games.input.*;

public class XboxController implements Controller {

	private ControllerEnvironment environment;
	private Controller[] controllers;
	private Component[] components;
	private Controller xbox;
	
	public Component button_A;
	public Component button_B;
	public Component button_X;
	public Component button_Y;
	public Component button_LB;
	public Component button_RB;
	public Component button_LS;
	public Component button_RS;
	public Component button_Start;
	public Component button_Back;
	public Component stick_LX;
	public Component stick_LY;
	public Component stick_RX;
	public Component stick_RY;
	public Component triggers;
	public Component dPad;
	
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
				button_A = components[i];
			}
			else if(components[i].getName().equals("Button 1")) {
				button_B = components[i];
			}
			else if(components[i].getName().equals("Button 2")) {
				button_X = components[i];
			}
			else if(components[i].getName().equals("Button 3")) {
				button_Y = components[i];
			}
			else if(components[i].getName().equals("Button 4")) {
				button_LB = components[i];
			}
			else if(components[i].getName().equals("Button 5")) {
				button_RB = components[i];
			}
			else if(components[i].getName().equals("Button 6")) {
				button_Back = components[i];
			}
			else if(components[i].getName().equals("Button 7")) {
				button_Start = components[i];
			}
			else if(components[i].getName().equals("Button 8")) {
				button_LS = components[i];
			}
			else if(components[i].getName().equals("Button 9")) {
				button_RS = components[i];
			}
			else if(components[i].getName().equals("X Axis")) {
				stick_LX = components[i];
			}
			else if(components[i].getName().equals("Y Axis")) {
				stick_LY = components[i];
			}
			else if(components[i].getName().equals("X Rotation")) {
				stick_RX = components[i];
			}
			else if(components[i].getName().equals("Y Rotation")) {
				stick_RY = components[i];
			}
			else if(components[i].getName().equals("Z Axis")) {
				triggers = components[i];
			}
			else if(components[i].getName().equals("Hat Switch")) {
				dPad = components[i];
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