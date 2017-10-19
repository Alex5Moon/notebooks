package v1ch06.timer;

/**
 * 6-5
 * @author Administrator
 *
 */
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.*;
import javax.swing.*;
import javax.swing.Timer;

public class TimerTest 
{
	public static void main(String[] args) 
	{
		ActionListener listener = new TimePrinter();
		
		// construct a timer that calls the listener
		// once every 10 seconds
		Timer t = new Timer(10000,listener);
		t.start();
		
		JOptionPane.showMessageDialog(null, "Quit program?");
		System.exit(0);
	}
}
class TimePrinter implements ActionListener
{

	@Override
	public void actionPerformed(ActionEvent e) 
	{
		// TODO Auto-generated method stub
		Date now = new Date();
		System.out.println("At the tone, the time is "+now);
		Toolkit.getDefaultToolkit().beep();
	}
	
}