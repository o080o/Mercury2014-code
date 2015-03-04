import net.java.games.input.*;
import java.io.*;
import java.util.*;
import gnu.io.*;

public class XboxRobotModel {

	final String port = "COM3";
	
	private String image = "";
	private String instructionsImage = "";
	private String autonomousImage = "Autonomous_Off.png";
	private int missedData = 0;
	private int stuckCounter = 0;
	private byte leftData = 0;
	private byte rightData = 0;
	private byte override = 0;
	private byte sensorData = 0;
	private double autonomousEnable = 0;
	private double autonomousDisable = 0;
	private boolean detectLeft = false;
	private boolean detectRight = false;
	private boolean autonomous = false;
	private boolean stuck = false;
	private XboxController xbox = null;
	private PrintStream output = null;
	private DataInputStream input = null;
	
	public XboxRobotModel() {
		
		image = "Clear.png";
		xbox = new XboxController();
		try {
			CommPortIdentifier portID = CommPortIdentifier.getPortIdentifier(port);
			SerialPort serialPort = (SerialPort)portID.open(port, 2000);
			
			// Make sure to use 9600 baud rate, 8 data bits, 1 stop bit, no parity
			// and no handshaking.
			serialPort.setSerialPortParams(
				9600, SerialPort.DATABITS_8, SerialPort.STOPBITS_1, SerialPort.PARITY_NONE);
			output = new PrintStream(serialPort.getOutputStream());
			
			Thread thread = new Thread(new XboxRobotThread(output, this));
			thread.start();
			
			input = new DataInputStream(serialPort.getInputStream());
		}
		catch (Exception e) {
			System.out.println("ERROR: Unable to establish connection to " + port + ".");
			System.out.println("Quitting Program.");
			System.exit(0);
		}
	}
	
	public String getImage() {
		return image;
	}
	
	public String getInstructionsImage() {
		return instructionsImage;
	}
	
	public String getAutonomousImage() {
		return autonomousImage;
	}
	
	public byte getLeftData() {
		return leftData;
	}
	
	public byte getRightData() {
		return rightData;
	}
	
	public byte getOverrideState() {
		return override;
	}
	
	public void resetOverride() {
		override = 1;
	}
	
	public void pollController() {
	
		try {
			xbox.poll();
			
			if(!autonomous) {
				leftData = (byte)((xbox.STICK_LY.getPollData() * 100) + 100);
				rightData = (byte)((xbox.STICK_RY.getPollData() * 100) + 100);
			}
			override = (byte)((xbox.BUTTON_RB.getPollData()));
			
			autonomousEnable = xbox.BUTTON_A.getPollData();
			autonomousDisable = xbox.BUTTON_B.getPollData();
			
			if(autonomousEnable == 1) {
				autonomous = true;
				autonomousImage = "Autonomous_On.png";
			}
			else if(autonomousDisable == 1) {
				autonomous = false;
				autonomousImage = "Autonomous_Off.png";
			}
			
			if(autonomous) {
				override = 1;
			}
			
			if(override == 1 && !autonomous) {
				instructionsImage = "Override_Enabled.png";
			}
			else {
				instructionsImage = "Basic_Instructions.png";
			}
			
			//Xbox controller requires a large dead zone.
			if(leftData < 120 && leftData > 80) {
				leftData = 100;
			}
			else if(leftData >= 120) {
				leftData -= 20;
			}
			else if(leftData <= 80) {
				leftData += 20;
			}
			
			if(rightData < 120 && rightData > 80) {
				rightData = 100;
			}
			else if(rightData >= 120) {
				rightData -= 20;
			}
			else if(leftData <= 80) {
				rightData += 20;
			}
		}
		catch (Exception e) {
			System.out.println("Unable to communicate with Xbox controller.");
		}
	}
	
	public int getSensorData() {
		
		try {
			sensorData = input.readByte();
			missedData = 0;
		}
		catch(Exception e) {
			missedData++;
			
			if(missedData > 5) {
				sensorData = 4;
				image = "Signal_Lost.png";
			}
		}
		
		if(sensorData == 0) {
			image = "Clear.png";
			detectLeft = false;
			detectRight = false;
			
			if(autonomous) {
				leftData = 0;
				rightData = 0;
				stuck = false;
				stuckCounter = 0;
			}
		}
		else if(sensorData == 1) {
			image = "Alert_Left.png";
			detectLeft = true;
			detectRight = false;
			
			if(autonomous) {
				leftData = 0;
				rightData = (byte)200;
			}
		}
		else if(sensorData == 2) {
			image = "Alert_Right.png";
			detectLeft = false;
			detectRight = true;
			
			if(autonomous) {
				leftData = (byte)200;
				rightData = 0;
			}
		}
		else if(sensorData == 3) {
			image = "Alert_Both.png";
			detectLeft = true;
			detectRight = true;
			
			if(autonomous) {
			
				leftData = 0;
				rightData = (byte)200;
				
				stuckCounter++;
				
				if (stuckCounter > 3) {
					stuck = true;
				}
				else {
					stuck = false;
				}
			}
		}
		
		if(!autonomous) {
			stuck = false;
		}
		
		if(stuck) {
			leftData = 0;
			rightData = (byte)200;
		}
		
		return (int)sensorData;
	}
}