import net.java.games.input.*;
import javax.swing.*;

public class ControllerTest {
	
	public static void main(String[] args) {
	
		XboxController xbox = new XboxController();
		ControllerFrame frame = new ControllerFrame(xbox);
		while(true) {
			xbox.poll();
			frame.repaint();
		}
	}
}