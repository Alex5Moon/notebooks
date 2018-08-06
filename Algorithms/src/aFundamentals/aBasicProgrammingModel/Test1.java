package aFundamentals.aBasicProgrammingModel;

import static java.lang.System.*;

public class Test1 {
	
	public static void main(String[] args) {
		int a = gcd(100,50);
		out.println(a);
		
		out.println(sqrt(4));
	}
	
	
	/**
	 * 最大公约数
	 * 计算两个非负整数p 和 q的最大公约数：若 q是0，则最大公约数为 p。否则，将 p除以 q得到余数 r，
	 * p 和 q 的最大公约数即为 q 和 r 的最大公约数。
	 * 
	 * @param p
	 * @param q
	 * @return
	 */
	public static int gcd(int p, int q){
		if(q == 0) return p;
		int r = p%q;
		return gcd(q,r);
	}
	
	/**
	 * 数组最大值
	 * @param arr
	 * @return
	 */
	public static double getMax(double[] arr){
		double max = arr[0];
		for(int i = 1; i < arr.length;i++)
			if(arr[i] > max) max = arr[i];
		return 0.0;
	}
	
	/**
	 * 数组平均值
	 * @param arr
	 * @return
	 */
	public static double getAve(double[] arr){
		int N = arr.length;
		double sum = 0.0;
		for(int i = 0; i < arr.length; i++)
			sum += arr[i];
		double average = sum/N;
		return average;
	}
	
	/**
	 * 数组复制
	 * @param arr
	 * @return
	 */
	public static double[] copyArr(double[] arr){
		
		double[] newArr = new double[arr.length];
		for(int i = 0; i < arr.length; i++)
			newArr[i] = arr[i];
		return newArr;
		
	}
	
	/**
	 * 数组倒置
	 * @param arr
	 */
	public static void revArr(double[] arr){
		for(int i = 0; i < arr.length; i++){
			double temp = arr[i];
			arr[i] = arr[arr.length-1-i];
			arr[arr.length-1-i] = temp;
		}
	}
	
	/**
	 * 矩阵相乘（方阵）
	 * a[][] * b[][] = c[][]
	 * @param arr1
	 * @param arr2
	 * @return
	 */
	public static double[][] mulArr(double[][] arr1, double[][] arr2){
		double[][] newArr = new double[arr1.length][arr2.length];
		for(int i = 0; i < arr1.length; i++)
			for (int j = 0; j < arr2.length; j++)
				for(int k = 0; k < arr1.length; k++)
					newArr[i][j] += arr1[i][k]*arr2[k][j];
		return newArr;
	}
	
	/**
	 * 整数绝对值
	 * @param x
	 * @return
	 */
	public static int abs(int x){
		if (x < 0) return -x;
		else return x;
	}
	
	/**
	 * 浮点数绝对值
	 * @param x
	 * @return
	 */
	public static double abs(double x){
		if (x < 0.0) return -x;
		else return x;
	}
	
	/**
	 * 判断素数
	 * @param N
	 * @return
	 */
	public static boolean isPrime(int N){
		if (N < 2) return false;
		for (int i = 2; i*i <= N; i++)
			if (N % i == 0) return false;
		return true;
	}
	
	/**
	 * 计算平方根（牛顿迭代法）
	 * @param c
	 * @return
	 */
	public static double sqrt(double c){
		if (c < 0) return Double.NaN;
		double err = 1e-15;
		double t = c;
		while (Math.abs(t-c/t) > err*t)
			t = (c/t+t)/2.0;
		return t;
	}
	
	/**
	 * 计算直角三角形的斜边
	 * @param a
	 * @param b
	 * @return
	 */
	public static double hypotenuse(double a, double b){
		return Math.sqrt(a*a + b*b);
	}
	
	/**
	 * 计算调和级数
	 * @param N
	 * @return
	 */
	public static double H(int N){
		double sum = 0.0;
		for (int i = 1; i <= N; i++)
			sum += 1.0/i;
		return sum;
	}
	
	/**
	 * 二分查找的递归实现
	 * @param key
	 * @param a
	 * @return
	 */
	public static int rank(int key, int[] a){
		return rank(key, a, 0, a.length-1);
	}
	public static int rank(int key, int[] a, int lo, int hi){
		if (lo > hi) return -1;
		int mid = lo + (hi-lo)/2;
		if (key < a[mid])      return rank(key, a, lo, mid-1);
		else if (key > a[mid]) return rank(key, a, mid+1, hi);
		else 				   return mid;
	}
}
