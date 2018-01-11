package v1ch04.ParamTest;

import java.util.Arrays;
import java.util.Date;

public class CallTest {
	public static void main(String[] args) {
		
		int i = 5;
		System.out.println("before: "+ i);  // 5
		changeInt(i);
		System.out.println("after: "+ i);   // 5
		
		String str = "unchanged";
		System.out.println("before: "+ str);  // unchanged
		changeString(str);
		System.out.println("after: "+str);    // unchanged
		
		int[] arr = {1,1,1,1,1};
		System.out.println("before: "+ Arrays.toString(arr));  // [1, 1, 1, 1, 1]
		changeArr(arr);
		System.out.println("after: "+ Arrays.toString(arr));   // [0, 1, 1, 1, 1]
		
		Date date = new Date();
		System.out.println("before: "+ date.getYear());        // 118    
		changeDate(date);
		System.out.println("after: "+ date.getYear());         // 0
		
		int a = 1;
		int b = 2;
		System.out.println("before: a = "+a+",b = "+b);        // before: a = 1,b = 2
		swapInt(a,b);
		System.out.println("after: a = "+a+",b = "+b);         // after: a = 1,b = 2

		String str1 = "first";
		String str2 = "last";
		System.out.println("befor str1 = "+str1+",str2 = "+str2);
		swapString(str1,str2);
		System.out.println("after str1 = "+str1+",str2 = "+str2);

	}
	
	public static void swapString(String str1,String str2){
		
		String temp = str1;
		str1 = str2;
		str2 = temp;
		System.out.println("end of swapString str1 = "+str1+",str2 = "+str2);
		
	}
	
	public static void swapInt(int a,int b){
		int temp = a;
		a = b;
		b = temp;
		System.out.println("end of swapInt: a = "+a+",b = "+b );
	}
	
	public static void changeDate(Date date){
		date.setYear(0);
		System.out.println("end of changeDate:"+date.getYear());
	}
	
	public static void changeArr(int[] arr){
		arr[0] = 0;
		System.out.println("end of changeArr:"+Arrays.toString(arr));
	}
	public static void changeInt(int x){
		x *= 2;
		System.out.println("end of changeInt :" + x);
	}
	
	public static void changeString(String s){
		s = "changed";
		System.out.println("end of changeString:" + s);
	}
	
}
