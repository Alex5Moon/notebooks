package v1ch05.objectAnalyzer;

import java.util.*;

/**5-14
 * This program uses reflection to spy on objects
 * @author Administrator
 *
 */
public class ObjectAnalyzerTest 
{
	public static void main(String[] args)
	{
		ArrayList<Integer> squares = new ArrayList<>();
		for(int i=1;i<6;i++)
			squares.add(i*i);
		System.out.println(new ObjectAnalyzer().toString(squares));
	}
}
