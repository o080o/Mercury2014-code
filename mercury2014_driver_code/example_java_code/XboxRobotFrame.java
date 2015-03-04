import net.java.games.input.*;
import javax.swing.*;
import java.awt.*;

public class XboxRobotFrame extends JFrame{

	XboxController xbox = null;

	public XboxRobotFrame() {
		
		XboxRobotModel model = new XboxRobotModel();
		
		Toolkit kit = Toolkit.getDefaultToolkit();
		Dimension screenSize = kit.getScreenSize();
		
		setSize(screenSize.height/2, screenSize.height/2 + 200);
		setTitle("Xbox Robot Controller");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		Container contentPane = getContentPane();
		contentPane.add(new XboxRobotPanel(model, this));
		setVisible(true);
	}
}