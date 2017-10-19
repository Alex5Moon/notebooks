package v1ch06.clone;

import java.util.*;

public class Employee implements Cloneable 
{
	private String name;
	private double salary;
	private Date hireDay;
	
	public Employee(String n, double s)
	{
		name = n;
		salary = s;
		hireDay = new Date();
	}
	
	public Employee clone() throws CloneNotSupportedException 
	{
		// call Object.clone()
		Employee cloned = (Employee)super.clone();
		
		// clone mutable fields
		cloned.hireDay = (Date)hireDay.clone();
	
		return cloned;
	}
	
	/**
	 * Set the hire day to a given date.
	 * @param year
	 * @param month
	 * @param day
	 */
	public void setHireDay(int year,int month,int day)
	{
		Date newHireDay = new GregorianCalendar(year,month-1,day).getTime();
		
		// Example of instance field mutation
		hireDay.setTime(newHireDay.getTime());
	}
	
	public void raiseSalary(double byPercent)
	{
		double raise = salary*byPercent/100;
		salary += raise;
	}
	
	public String toString()
	{
		return "Employee[name="+name+",salary="+salary+",hireDay="+hireDay+"]";
	}
}
