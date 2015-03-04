import javax.swing.*;
import java.awt.*;
import net.java.games.input.*;

public class XboxRobotPanel extends JPanel {

	private XboxRobotModel model = null;
	private XboxRobotFrame frame = null;
	
	public XboxRobotPanel(XboxRobotModel m, XboxRobotFrame f) {
		super();
		model = m;
		frame = f;
		setBackground(Color.white);
	}
	
	public void paintComponent(Graphics g) {
		
		super.paintComponent(g);
		Toolkit kit = Toolkit.getDefaultToolkit();
		
		try {
			model.getSensorData();
			model.pollController();
		}
		catch(Exception e) {
			System.out.println("ERROR: Unable to retrieve controller data.");
		}
		
		Image pic = kit.getImage(model.getImage());
		Image instructions = kit.getImage(model.getInstructionsImage());
		Image autonomous = kit.getImage(model.getAutonomousImage());
		g.drawImage(pic, frame.getWidth()/8, 20, this);
		g.drawImage(instructions, frame.getWidth()/8, 320, this);
		g.drawImage(autonomous, frame.getWidth()/8, 510, this);
	}
}