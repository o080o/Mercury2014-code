import net.java.games.input.*;
import javax.swing.*;

public class XboxTestController {
	
	public static void main(String[] args) {
	
		XboxController xbox = new XboxController();
		XboxTestFrame frame = new XboxTestFrame(xbox);
		while(true) {
			xbox.poll();
			frame.repaint();
		}
	}
}