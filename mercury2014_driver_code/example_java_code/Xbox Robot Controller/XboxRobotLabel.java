import javax.swing.*;
import java.awt.*;
import net.java.games.input.*;

public class XboxRobotLabel extends JLabel {

	private String name = "";
	private int index = 0;
	private XboxController xbox = null;

	public XboxRobotLabel(XboxController x, int i) {
		
		index = i;
		xbox = x;
		name = xbox.getComponents()[index].getName();
		xbox.poll();
		setText(name + ": " + xbox.getComponents()[index].getPollData());
	}
	
	public void paintComponent(Graphics g) {
		xbox.poll();
		setText(name + ": " + xbox.getComponents()[index].getPollData());
		super.paintComponent(g);
	}
}