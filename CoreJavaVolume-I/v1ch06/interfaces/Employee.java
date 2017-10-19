package v1ch06.interfaces;

public class Employee implements Comparable<Employee> 
{
	
	private String name;
	private double salary;
	
	public Employee(String n, double s)
	{
		name = n;
		salary = s;
	}
	
	public String getName()
	{
		return name;
	}
	
	public double getSalary()
	{
		return salary;
	}
	
	public void raiseSalary(double byPercent)
	{
		double raise = salary*byPercent/100;
		salary += raise;
	}
	
	/**
	 * Compares employees by salary
	 */
	@Override
	public int compareTo(Employee o) 
	{
		// TODO Auto-generated method stub
		return Double.compare(salary, o.salary);
	}
	
}
