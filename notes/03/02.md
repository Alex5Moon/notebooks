## day02
### regex
```
package day02;
/**
 * boolean matches(String regex)
 * 根据给定的正则表达式来验证当前字符串是否满足
 * 格式要求，满足则返回true
 * 需要注意:无论正则表达式是否有边界匹配(^$)，都是
 * 做全匹配验证。
 * @author Administrator
 *
 */
public class StringDemo1 {
	public static void main(String[] args) {
		/*
		 * 
		 * [0-9a-zA-Z_]+@[0-9a-zA-Z_]+(\.[a-zA-Z]+)+
		 * 
		 */
		String regex = "[0-9a-zA-Z_]+@[0-9a-zA-Z_]+(\\.[a-zA-Z]+)+";
		String email = "fancq@tedu.cn";
		boolean tf = email.matches(regex);
		if(tf){
			System.out.println("是一个邮箱");
		}else{
			System.out.println("不是一个邮箱");
		}
	}
}
```
>
```
package day02;
/**
 * String[] split(String regex)
 * 将当前字符串中满足给定正则表达式的部分进行拆分，
 * 返回所有剩下的部分。
 * @author Administrator
 *
 */
public class StringDemo2 {
	public static void main(String[] args) {
		String str = "aaa123bbb456ccc789ddd012eee";
		//获取所有字符部分(按照数字部分拆分)
		String[] data = str.split("\\d+");
		for(int i=0;i<data.length;i++){
			System.out.println(data[i]);
		}
		
		
		String imgName = "1.jpg";
		String[] names = imgName.split("\\.");
		long time = System.currentTimeMillis();
		imgName = time+"."+names[1];
		System.out.println(imgName);
		
		
		
	}
}

```
>
```
package day02;
/**
 * String replaceAll(String regex,String str)
 * 将当前字符串中满足给定正则表达式的部分替换为给定的
 * 字符串。
 * @author Administrator
 *
 */
public class StringDemo3 {
	public static void main(String[] args) {
		String str = "aaa111bbb222ccc333ddd444eee";
		/*
		 * 将数字部分替换为"#NUMBER#"
		 */
		str = str.replaceAll("\\d+", "#NUMBER#");
		System.out.println(str);
	}
}

```
>
```
package day02;
/**
 * 和谐用语
 * @author Administrator
 *
 */
public class StringDemo4 {
	public static void main(String[] args) {
		String regex = "(wqnmlgdsb|cnm|nc|md|tmd|djb)";
		String message = "wqnmlgdsb!你这个nc!你这个djb!tmd!";
		message = message.replaceAll(regex, "****");
		System.out.println(message);
	}
}

```
>
### object 
```
package day02;
/**
 * 使用该类测试Object中的方法:
 * String toString()
 * boolean equals(Object o)
 * @author Administrator
 *
 */
public class Point {
	private int x;
	private int y;
	
	public Point(int x,int y){
		this.x = x;
		this.y = y;
	}
	
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	/**
	 * 重写toString方法
	 * 当我们调用一个类的toString方法时，就
	 * 应当重写该方法，因为Object提供的toString
	 * 方法返回的句柄没有什么实际意义。
	 * toString返回的字符串应当包含当前类的属性
	 * 信息。具体格式可以根据实际开发需求而定。需要
	 * 看到那些属性，就将那些属性拼接到字符串中。
	 * 
	 * 
	 */
	public String toString(){
		return "("+x+","+y+")";
	}
	/**
	 * 重写equals方法
	 * 目的是比较两个对象的内容是否一致。
	 * 并不是说所有属性都一样，才叫内容一致，这个
	 * 要结合将来实际开发需求。
	 */
	public boolean equals(Object obj){
		if(obj == null){
			return false;
		}
		if(obj == this){
			return true;
		}
		if(obj instanceof Point){
			Point p = (Point)obj;
			return this.x==p.x&&this.y==p.y;
		}
		return false;
	}
	
}
```
>
```

package day02;
/**
 * 测试Point类重写Object的相关方法
 * @author Administrator
 *
 */
public class TestPoint {
	public static void main(String[] args) {
		Point p = new Point(1,2);
		/*
		 * Object中定义的toString方法
		 * 返回的是对象的句柄(对象的地址)
		 * 格式为:类名@地址
		 */
		String str = p.toString();
		System.out.println(str);
		
		Point p1 = new Point(1,2);
		
		System.out.println(p==p1);
		/*
		 * Object提供的equals方法就是使用
		 * "=="进行比较的，所以并无实际意义。
		 * 当我们需要使用一个类的equals方法
		 * 时应当重写它。java API提供的类基本
		 * 都实现了该方法。
		 * 
		 * 对于引用类型变量而言:
		 * "==":值比较，在这里就是地址的比较，
		 *      所以两个引用类型变量指向同一个
		 *      对象时才为true,所以比较的是
		 *      是否为"同一个"
		 * "equals":内容比较，比较的是连个对象
		 *      的内容是否一样，所以比较的是
		 *      "像不像"
		 */
		System.out.println(p.equals(p1));
			
	}
}

```
>
### Integer
```
package day02;
/**
 * 包装类
 * 基本类型由于没有面向对象特性，所以不能直接
 * 参与面向对象开发，为此java为8个基本类型定义了
 * 8个包装类，使用包装类可以将基本类型以对象的形式
 * 存在，从而参与面向对象开发。
 * 6个数字类型包装类继承自Number。
 * Number要求数字类型包装类提供了6个数字类型转换
 * 的方法。
 * @author Administrator
 *
 */
public class IntegerDemo {
	public static void main(String[] args) {
		// 基本类型->引用类型
		Integer in = new Integer(127);	
		/*
		 * 将基本类型转换为包装类时，推荐使用
		 * 包装类的静态方法valueOf(),而不是直接
		 * 使用new创建。
		 */
		Integer in1 = Integer.valueOf(127);
		
		int i = in.intValue();
		System.out.println(i);
		//以double形式返回
		double d = in.doubleValue();
		System.out.println(d);
		//以byte形式返回，注意取值范围
		byte b = in.byteValue();
		System.out.println(b);
		
	}
	
}
```
>
```
package day02;
/**
 * 数字类型包装类支持两个常量
 * MAX_VALUE：包装类对应基本类型的最大值
 * MIN_VALUE：包装类对应基本类型的最小值
 * @author Administrator
 *
 */
public class IntegerDemo2 {
	public static void main(String[] args) {
		int imax = Integer.MAX_VALUE;
		int imin = Integer.MIN_VALUE;
		
		System.out.println("imax:"+imax);
		System.out.println("imin:"+imin);
		
		long lmax = Long.MAX_VALUE;
		System.out.println("lmax:"+lmax);
	}
}
```
>
```
package day02;
/**
 * 包装类都提供了一个静态方法:parseXXX(String str)
 * 可以将给定的字符串转换为对应的基本类型值。
 * 但是前提是该字符串必须能正确描述该基本类型值。
 * @author Administrator
 *
 */
public class IntegerDemo3 {
	public static void main(String[] args) {
		String istr = "123.123";
		int i = Integer.parseInt(istr);
		System.out.println(i);
	}
}
```
>
```
package day02;
/**
 * JDK在1.5(5.0)之后推出了一个新特性
 * 自动拆装箱
 * 自动拆装箱是编译器认可，而不是JVM认可的。
 * 编译器在编译源程序时，自动补充了代码在基本类型
 * 与引用类型之间转换的过程，称为自动拆装箱。
 * @author Administrator
 *
 */
public class IntegerDemo4 {
	public static void main(String[] args) {
		/*
		 * 下面的代码触发了自动装箱:
		 * 编译器会将代码改为:
		 * Integer in = Integer.valueOf(1);
		 */
		Integer in = 1;
		
		/*
		 * 下面的代码触发了自动拆箱:
		 * 编译器会将代码改为:
		 * int i = in.intValue();
		 */
		int i = in;
		
	}
}

```


