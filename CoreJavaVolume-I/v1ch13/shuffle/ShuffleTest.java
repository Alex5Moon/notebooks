package v1ch13.shuffle;

import java.util.*;

/**13-7
 * This program demonstrates the random shutffle and sort algorithms.
 * @author Administrator
 *
 */
public class ShuffleTest 
{
	public static void main(String[] args) 
	{
		List<Integer> numbers = new ArrayList<>();
		for(int i=1; i<=49; i++)
			numbers.add(i);
		Collections.shuffle(numbers);
		List<Integer> winningCombination = numbers.subList(0, 6);
		Collections.sort(winningCombination);
		System.out.println(winningCombination);
		Collections.sort(winningCombination, Collections.reverseOrder());
		System.out.println(winningCombination);
	}
}
