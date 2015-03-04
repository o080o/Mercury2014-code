import javax.swing.*;
import java.awt.*;
import net.java.games.input.*;

public class XboxRobotPanel extends JPanel {

	public XboxRobotPanel(XboxController xbox) {
	
		setLayout(new GridLayout(4, 4));
		
		for(int i = 0; i < xbox.getComponents().length; i++) {
			add(new XboxRobotLabel(xbox, i));
		}
	}
	
	/*private class ControllerHandler implements ControllerListener {
	
	public void controllerAdded(ControllerEvent e) {
		return;
	}
	
	public void controllerRemoved(ControllerEvent e) {
		return;
	}*/
}