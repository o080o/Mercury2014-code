import net.java.games.input.*;

public class ConsoleTest {

	public static void main(String[] args) {
	
		XboxController xbox = new XboxController();
		
		while(true) {
			xbox.poll();
			System.out.print("A        = ");
			System.out.println(xbox.button_A.getPollData());
			System.out.print("B        = ");
			System.out.println(xbox.button_B.getPollData());
			System.out.print("X        = ");
			System.out.println(xbox.button_X.getPollData());
			System.out.print("Y        = ");
			System.out.println(xbox.button_Y.getPollData());
			System.out.print("LB       = ");
			System.out.println(xbox.button_LB.getPollData());
			System.out.print("RB       = ");
			System.out.println(xbox.button_RB.getPollData());
			System.out.print("LS       = ");
			System.out.println(xbox.button_LS.getPollData());
			System.out.print("RS       = ");
			System.out.println(xbox.button_RS.getPollData());
			System.out.print("Start    = ");
			System.out.println(xbox.button_Start.getPollData());
			System.out.print("Back     = ");
			System.out.println(xbox.button_Back.getPollData());
			System.out.print("LX       = ");
			System.out.println(xbox.stick_LX.getPollData());
			System.out.print("LY       = ");
			System.out.println(xbox.stick_LY.getPollData());
			System.out.print("RX       = ");
			System.out.println(xbox.stick_RX.getPollData());
			System.out.print("RY       = ");
			System.out.println(xbox.stick_RY.getPollData());
			System.out.print("Triggers = ");
			System.out.println(xbox.triggers.getPollData());
			System.out.print("D-Pad    = ");
			System.out.println(xbox.dPad.getPollData());
		}
	}
}