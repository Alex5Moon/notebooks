package v1ch04.EmployeeTest;

import java.util.Date;
import java.util.GregorianCalendar;

public class EmployeeTest 
{	
	/**
	 * 注意不要编写返回引用可变对象的访问器方法。
	 * 在Employee类中就违反了这个设计原则，其中getHireDay 方法返回了一个Date类对象。
	 * 这样会破坏封装性！
	 * 如果需要返回一个可变对象的引用，应该首先对她进行克隆clone。
	 * return hireDay.clone();
	 */
	public static void test1(){
		Employee harry = new Employee("Harry Hacker", 50000, 1989, 10, 1);
		Date d = harry.getHireDay();
		double tenYearsInMilliSeconds = 10*365.25*24*60*60*1000;
		d.setTime(d.getTime()-(long)tenYearsInMilliSeconds);
		// let's give Harry ten years of added seniority
		System.out.println(harry.getHireDay());
	}
	 public static void main(String[] args)
	   {	
		 test1();	
	      // fill the staff array with three Employee objects
	      Employee[] staff = new Employee[3];

	      staff[0] = new Employee("Carl Cracker", 75000, 1987, 12, 15);
	      staff[1] = new Employee("Harry Hacker", 50000, 1989, 10, 1);
	      staff[2] = new Employee("Tony Tester", 40000, 1990, 3, 15);

	      // raise everyone's salary by 5%
	      for (Employee e : staff)
	         e.raiseSalary(5);

	      // print out information about all Employee objects
	      for (Employee e : staff)
	         System.out.println("name=" + e.getName() + ",salary=" + e.getSalary() + ",hireDay="
	               + e.getHireDay());
	   }
	 
}
class Employee
{
   private String name;
   private double salary;
   private Date hireDay;

   public Employee(String n, double s, int year, int month, int day)
   {
      name = n;
      salary = s;
      GregorianCalendar calendar = new GregorianCalendar(year, month - 1, day);
      // GregorianCalendar uses 0 for January
      hireDay = calendar.getTime();
   }

   public String getName()
   {
      return name;
   }

   public double getSalary()
   {
      return salary;
   }

   public Date getHireDay()
   {
//	      return hireDay;
	      return (Date)hireDay.clone();
   }

   public void raiseSalary(double byPercent)
   {
      double raise = salary * byPercent / 100;
      salary += raise;
   }
}
