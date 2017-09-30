package v1ch03.LotteryOdds;

import java.util.Scanner;

public class LotteryOdds 
//  lotteryOdds = lotteryOdds*(n-i+1)/i;
{
	/*
	 * 在循环中，检测两个浮点数是否相等需要格外小心。下面的for循环
	 * 	for(double x = 0; x != 10; x　+= 0.1)...
	 * 可能永远不会结束。
	 * 由于舍入的误差，最终可能得不到精确值。
	 */
	public static void main(String[] args) 
	{
		Scanner in = new Scanner(System.in);
		
		System.out.print("How many numbers do you need to draw? ");
		int k = in.nextInt();
		
		System.out.print("What is the highest number you can draw? ");
		int n = in.nextInt();
		/*
		 * compute binomial coefficient n*(n-1)*(n-2)*...*(n-k+1)/(1*2*3*...*k)
		 */
		int lotteryOdds = 1;
		for(int i=1;i<=k;i++)
			lotteryOdds = lotteryOdds*(n-i+1)/i;
		
		System.out.println("Your odds are 1 in "+lotteryOdds+". Good luck!");
		in.close();
	}
}
