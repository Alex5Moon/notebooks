package v1ch06.innerClass;

import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Date;

import javax.swing.JOptionPane;
import javax.swing.Timer;


/**6-6
 * This program demonstrates the use of inner classes.
 * @author Administrator
 *
 */
public class InnerClassTest 
{
	public static void main(String[] args) 
	{
		TalkingClock clock = new TalkingClock(1000,true);
		clock.start();
		
		// keep program running until user selects "OK"
		JOptionPane.showMessageDialog(null, "Quit program?");
		System.exit(0);
	}
}

/**
 * A clock that prints the time in regular intervals.
 * @author Administrator
 *
 */
class TalkingClock
{
	private int interval;
	private boolean beep;
	
	/**
	 * Constructs a talking clock
	 * @param interval
	 * @param beep
	 */
	public TalkingClock(int interval, boolean beep)
	{
		this.interval = interval;
		this.beep = beep;
	}
	
	public void start()
	{
		ActionListener listener = new TimerPrinter();
		Timer t = new Timer(this.interval,listener);
		t.start();
	}
	
	public class TimerPrinter implements ActionListener
	{
		@Override
		public void actionPerformed(ActionEvent event)
		{
			Date now = new Date();
			System.out.println("At the tone, the time is "+now);
			if(beep) Toolkit.getDefaultToolkit().beep();
		}

	}
}