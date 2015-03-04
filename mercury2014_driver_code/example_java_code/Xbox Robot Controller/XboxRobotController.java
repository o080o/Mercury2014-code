import net.java.games.input.*;
import javax.swing.*;

public class XboxRobotController {
	
	public static void main(String[] args) {
	
		XboxController xbox = new XboxController();
		XboxRobotFrame frame = new XboxRobotFrame(xbox);
		while(true) {
			xbox.poll();
			frame.repaint();
		}
	}
}