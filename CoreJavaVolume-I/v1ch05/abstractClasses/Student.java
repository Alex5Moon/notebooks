package v1ch05.abstractClasses;

public class Student extends Person 
{
	private String major;
	
	public Student(String n,String m) {
		// pass n to superclass constructor
		super(n);
		// TODO Auto-generated constructor stub
		major = m;
	}

	@Override
	public String getDescription() 
	{
		// TODO Auto-generated method stub
		return "a student majoring in "+major;
	}

}
