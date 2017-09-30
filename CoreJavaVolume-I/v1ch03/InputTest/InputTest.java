package v1ch03.InputTest;

import java.io.Console;
import java.util.Scanner;

public class InputTest 
{
	public static void main(String[] args) 
	{
		Scanner in = new Scanner(System.in);
		
		// get first input
		System.out.print("what's your name?");
		String name = in.nextLine();
		
		// get second input
		System.out.print("how old are you?");
		int age = in.nextInt();
		
		// display output on console
		System.out.println("Hello, "+name+".Next year,you'll be "+(age+1));
		System.out.printf("Hello, %s.Next year,you'll be %d",name,age+1);
		in.close();
		
		/**
		 * Scanner类输入可见，不适用于从控制台读取密码。
		 * Console类可以实现这个目的。
		 */
//		Console cons = System.console();
//		String username = cons.readLine("User name: ");
//		char[] passwd = cons.readPassword("Password: ");
		
	}

}
