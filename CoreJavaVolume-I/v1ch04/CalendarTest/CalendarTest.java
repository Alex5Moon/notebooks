package v1ch04.CalendarTest;

import java.text.DateFormatSymbols;
import java.util.Calendar;
import java.util.GregorianCalendar;
/**
 * 打印当前月的日历
 * @author Administrator
 *星期日   星期一   星期二   星期三   星期四   星期五   星期六
 *  1    2*   3    4    5    6    7 
 *  8    9   10   11   12   13   14 
 * 15   16   17   18   19   20   21 
 * 22   23   24   25   26   27   28 
 * 29   30   31 
 */
public class CalendarTest 
{
	public static void main(String[] args) 
	{
		// construct d as current date
		GregorianCalendar d = new GregorianCalendar();
		
	//	System.out.println(d.toString());
	//	System.out.println(Calendar.DAY_OF_MONTH+","+Calendar.MONTH);
		int today = d.get(Calendar.DAY_OF_MONTH);
		int month = d.get(Calendar.MONTH);
		
	//	System.out.println(today+","+month);
		// set d to start date of the month
		d.set(Calendar.DAY_OF_MONTH, 1);
		
		int weekday = d.get(Calendar.DAY_OF_WEEK);
		
		// get first day of week (Sunday in the U.S.)
		int firstDayOfWeek = d.getFirstDayOfWeek();
		
		// determine the required indentation for the first line
		int indent = 0;
		while(weekday != firstDayOfWeek)
		{
			indent++;
			d.add(Calendar.DAY_OF_MONTH, -1);
			weekday = d.get(Calendar.DAY_OF_WEEK);
		}
		
		// print weekday names
		String[] weekdayNames = new DateFormatSymbols().getShortWeekdays();
		do
		{
			System.out.printf("%6s", weekdayNames[weekday]);
			d.add(Calendar.DAY_OF_MONTH, 1);
			weekday = d.get(Calendar.DAY_OF_WEEK);
		}
		while(weekday != firstDayOfWeek);
		
		System.out.println();
		for(int i=1;i<=indent;i++)
			System.out.print("     ");
		
		d.set(Calendar.DAY_OF_MONTH, 1);
		do
		{
			// print day 
			int day = d.get(Calendar.DAY_OF_MONTH);
			System.out.printf("%4d",day);
			
			// mark current day with *
			if(day==today)System.out.print("*");
			else System.out.print(" ");
			
			// advance d to the next day 
			d.add(Calendar.DAY_OF_MONTH, 1);
			weekday = d.get(Calendar.DAY_OF_WEEK);
			
			// start a new line at the start of the week
			if(weekday==firstDayOfWeek) System.out.println();
		}
		while((d.get(Calendar.MONTH)) == month);
		// the loop exits when d is day 1 of the next month
		
		// print final end of line if necessary
		if(weekday != firstDayOfWeek) System.out.println();
	}

}
