package aFundamentals.aBasicProgrammingModel;

import static java.lang.System.*;
import java.util.Arrays;
import java.util.Scanner;

public class BinarySearch {
	
	public static int rank(int key, int[] a){
		// 数组必须是有序的
		int lo = 0;
		int hi = a.length-1;
		while (lo <= hi){
			// 被查找的键要么不存在，要么必然存在于 a[lo..hi] 之中
			int mid = lo+(hi-lo)/2;
			if	    (key < a[mid]) hi = mid - 1;
			else if (key > a[mid]) lo = mid + 1;
			else 				   return mid;
		}
		return -1;
	}
	
	public static void main(String[] args) {
		
		int[] arr = new int[10];
		for (int i = 0; i < arr.length; i++)
			arr[i] = (int)(Math.random()*100);
		out.println(Arrays.toString(arr));
		Arrays.sort(arr);
		out.println(Arrays.toString(arr));
		Scanner scan = new Scanner(in);
		int n = scan.nextInt();
		scan.close();
		out.println(rank(n,arr));
	}
}
