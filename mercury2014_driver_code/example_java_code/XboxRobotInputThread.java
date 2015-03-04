import net.java.games.input.*;
import java.io.*;
import java.util.*;
import gnu.io.*;

public class XboxRobotInputThread {

	private XboxRobotModel model = null;
	private DataInputStream input = null;
	private XboxRobotFrame frame = null;
	
	public XboxRobotInputThread(DataInputStream stream, XboxRobotModel m, XboxRobotFrame f) {
		model = m;
		input = stream;
		frame = f;
	}
	
	public void run() {
	
		try {
			while(true) {
				if(input.available() > 0) {
					frame.repaint();
				}
			}
		}
		catch(Exception e) {
			System.out.println("ERROR: Error in XboxRobotInputThread.");
		}
	}
}