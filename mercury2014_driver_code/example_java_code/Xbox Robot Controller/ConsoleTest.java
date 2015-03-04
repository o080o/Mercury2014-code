import net.java.games.input.*;
import java.io.*;
import java.util.*;
import gnu.io.*;

public class ConsoleTest {

	public static void main(String[] args) {
	
		final String port = "COM3";
		
		byte leftData = 0;
		byte rightData = 0;
		PrintStream output = null;
		
		XboxController xbox = new XboxController();
		
		try {
			CommPortIdentifier portID = CommPortIdentifier.getPortIdentifier(port);
			SerialPort serialPort = (SerialPort) portID.open(port, 2000);
			serialPort.setSerialPortParams(
				9600, SerialPort.DATABITS_8, SerialPort.STOPBITS_1, SerialPort.PARITY_NONE);
			output = new PrintStream(serialPort.getOutputStream());
		}
		catch (Exception e) {
			System.out.println("ERROR: Unable to establish connection to " + port + ".");
			System.out.println("Quitting Program.");
			System.exit(0);
		}
		
		while(true) {
			xbox.poll();
			
			//leftData = (byte)((xbox.STICK_LY.getPollData() * -100) - 100);
			//rightData = (byte)((xbox.STICK_RY.getPollData() * 100) + 100);
			leftData = (byte)((xbox.STICK_LY.getPollData() * 100) + 100);
			rightData = (byte)((xbox.STICK_RY.getPollData() * 100) + 100);
			
			try {
				output.print("LD");
				output.write(leftData);
				//output.print("\n");
				output.print("RD");
				output.write(rightData);
				//output.print("\n");
				output.flush();
			}
			catch (Exception e) {
				System.out.println("Unable to send data.");
			}
		}
	}
}