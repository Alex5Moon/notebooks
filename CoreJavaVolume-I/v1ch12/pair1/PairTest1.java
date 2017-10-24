package v1ch12.pair1;

import java.util.Arrays;

/**12-1
 * 
 * @author Administrator
 *
 */
public class PairTest1 
{
	public static void main(String[] args) 
	{
		String[] words = {"Mary","had","a","little","lamb"};
		Pair<String> mm = ArrayAlg.minmax(words);	
		System.out.println("min = "+mm.getFirst());
		System.out.println("max = "+mm.getSecond());
		Arrays.sort(words);
		System.out.println(Arrays.toString(words));
		System.out.println('a'-'M');
	}
}

class ArrayAlg
{
	/**
	 * Gets the minimum and maximum of an array of strings.
	 * @param a
	 * @return
	 */
	public static Pair<String> minmax(String[] a)
	{
		if(a==null || a.length==0) return null;
		String min = a[0];
		String max = a[0];
		for(int i=1; i<a.length; i++)
		{
			if (min.compareTo(a[i])>0) min = a[i];
			if (max.compareTo(a[i])<0) max = a[i];
		}
		return new Pair<>(min,max);
	}
}
