package v1ch06.anonymousInnerClass;

import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Date;

import javax.swing.JOptionPane;
import javax.swing.Timer;

/**6-7
 * This program demonstrates anonymous inner classes
 * @author Administrator
 *
 */
public class AnonymousInnerClassTest 
{
	public static void main(String[] args) 
	{
		TalkingClock clock = new TalkingClock();
		clock.start(1000, true);
		
		// keep program running until user selects "Ok"
		JOptionPane.showMessageDialog(null, "Quit program?");
		System.exit(0);
	}
}
/**
 * A clock that prints the time in regular intervals
 * @author Administrator
 *
 */
class TalkingClock
{
	/**
	 * Starts the clock.
	 * @param interval
	 * @param beep
	 */
	public void start(int interval, final boolean beep)
	{
		ActionListener listener = new ActionListener()
		{
			public void actionPerformed(ActionEvent event)
			{
				Date now = new Date();
				System.out.println("At the tone, the time is "+now);
				if(beep) Toolkit.getDefaultToolkit().beep();
			}
		};
		
		Timer t = new Timer(interval, listener);
		t.start();
	}
}
