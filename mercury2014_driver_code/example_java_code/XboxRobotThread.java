import net.java.games.input.*;
import java.io.*;
import java.util.*;
import gnu.io.*;

public class XboxRobotThread implements Runnable {

	private XboxRobotModel model = null;
	private PrintStream output = null;
	private int leftData = 100;
	private int rightData = 100;
	
	public XboxRobotThread(PrintStream stream, XboxRobotModel m) {
		model = m;
		output = stream;
	}
	
	public void run() {
		
		long time = 0;
		
		try {
			while(true) {
				time = System.currentTimeMillis();
				while((System.currentTimeMillis() - time) < 5) {}
				leftData = model.getLeftData();
				rightData = model.getRightData();
				output.print("DATA");
				output.write(leftData);
				output.write(rightData);
				output.write(model.getOverrideState());
				output.flush();
				
				/*if(model.getOverrideState() == 5) {
					time = System.currentTimeMillis();
					while((System.currentTimeMillis() - time) < 20) {}
					model.resetOverride();
					
					//DEBUG
					System.out.println("Reset override.");
				}*/
			}
		}
		catch(Exception e) {
			System.out.println("ERROR: Unable to send movement commands.");
		}
	}
}