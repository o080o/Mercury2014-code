// NOTE: This program requires installation of JInput and RXTX in order to run.

import net.java.games.input.*;
import javax.swing.*;

public class XboxRobotController {

	public static void main(String[] args) {
	
		long time = 0;
		
		XboxRobotFrame frame = new XboxRobotFrame();
		while(true) {
			time = System.currentTimeMillis();
			while((System.currentTimeMillis() - time) < 10) {
			}
			frame.repaint();
		}
	}
}