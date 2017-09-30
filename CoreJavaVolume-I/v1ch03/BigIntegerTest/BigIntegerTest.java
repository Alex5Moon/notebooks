package v1ch03.BigIntegerTest;

import java.math.BigInteger;
import java.util.Scanner;
//  lotteryOdds = lotteryOdds.multiply(BigInteger.valueOf(n-i+1)).divide(BigInteger.valueOf(i));
public class BigIntegerTest 
{
	public static void main(String[] args) 
	{
		/**
		 * BigInteger类实现了任意精度的   整数   运算
		 * BigDecimal类实现了任意精度的 浮点数 运算
		 */
//		BigInteger a = BigInteger.valueOf(100);
//		BigInteger b = BigInteger.valueOf(100);
//		BigInteger c = a.add(b); // c = a + b
//		BigInteger d = c.multiply(b.add(BigInteger.valueOf(2))); // d = c * (b + 2)
		
		Scanner in = new Scanner(System.in);
		
		System.out.print("How many numbers do you need to draw? ");
		int k = in.nextInt();
		
		System.out.print("What is the highest number you can draw? ");
		int n = in.nextInt();
		
		/*
		 * compute binomial coefficient n*(n-1)*(n-2)*...*(n-k+1)/(1*2*3*...*k)
		 */
		
		BigInteger lotteryOdds = BigInteger.valueOf(1);
		
		for(int i=1;i<=k;i++)
			lotteryOdds = lotteryOdds.multiply(BigInteger.valueOf(n-i+1)).divide(
					BigInteger.valueOf(i));
		
		System.out.println("Your odds are 1 in "+lotteryOdds+". Good luck!");
		
		in.close();
	}

}
