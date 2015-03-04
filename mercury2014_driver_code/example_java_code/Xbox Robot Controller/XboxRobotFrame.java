import net.java.games.input.*;
import javax.swing.*;
import java.awt.*;

public class XboxRobotFrame extends JFrame {

	XboxController xbox = null;

	public XboxRobotFrame(XboxController x) {
		
		xbox = x;
		
		Toolkit kit = Toolkit.getDefaultToolkit();
		Dimension screenSize = kit.getScreenSize();
		
		setSize(2*screenSize.height/3, 2*screenSize.height/3);
		setTitle("Xbox Controller Test");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		Container contentPane = getContentPane();
		contentPane.add(new XboxRobotPanel(xbox));
		setVisible(true);
	}
}