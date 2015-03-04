import javax.swing.*;
import java.awt.*;
import net.java.games.input.*;

public class ControllerPanel extends JPanel {

	public ControllerPanel(XboxController xbox) {
	
		setLayout(new GridLayout(4, 4));
		
		for(int i = 0; i < xbox.getComponents().length; i++) {
			add(new ControllerLabel(xbox, i));
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