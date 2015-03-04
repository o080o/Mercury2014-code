import net.java.games.input.*;
import java.io.*;
import java.util.*;
import gnu.io.*;

public class ConsoleTest {

	public static void main(String[] args) {
	
		final String port = "COM3";
		
		byte leftData = 0;
		byte rightData = 0;
		byte sensorData = 0;
		PrintStream output = null;
		DataInputStream input = null;
		
		XboxController xbox = new XboxController();
		
		try {
			CommPortIdentifier portID = CommPortIdentifier.getPortIdentifier(port);
			SerialPort serialPort = (SerialPort) portID.open(port, 2000);
			
			// Make sure to use 9600 baud rate, 8 data bits, 1 stop bit, no parity
			// and no handshaking.
			serialPort.setSerialPortParams(
				9600, SerialPort.DATABITS_8, SerialPort.STOPBITS_1, SerialPort.PARITY_NONE);
			output = new PrintStream(serialPort.getOutputStream());
			
			input = new DataInputStream(serialPort.getInputStream());
		}
		catch (Exception e) {
			System.out.println("ERROR: Unable to establish connection to " + port + ".");
			System.out.println("Quitting Program.");
			System.exit(0);
		}
		
		while(true) {
			xbox.poll();
			
			leftData = (byte)((xbox.STICK_LY.getPollData() * 100) + 100);
			rightData = (byte)((xbox.STICK_RY.getPollData() * 100) + 100);
			
			try {
				output.print("LDLD");
				output.write(leftData);
				//output.print("\n");
				output.print("RDRD");
				output.write(rightData);
				//output.print("\n");
				output.flush();
				
				sensorData = input.readByte();
				
				//DEBUG
				System.out.print("leftData = " + leftData + "    ");
				System.out.print("RightData = " + rightData + "    ");
				System.out.println("sensorData = " + sensorData);
			}
			catch (Exception e) {
				System.out.println("Unable to send data.");
			}
		}
	}
}