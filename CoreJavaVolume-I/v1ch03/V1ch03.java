package v1ch03;

public class V1ch03 
{
	public static void main(String[] args) 
	{	
		// Unicode 编码
		char[] chars = {'\u2122','\u03c0','\u005b','\u005d'};
		//                 ™        π         [        ]
		for(int i=0;i<chars.length;i++)
			System.out.print("chs["+i+"] = "+chars[i]);
		System.out.println();
		char[] chs = {'\u0008','\u0009','\u0022'};
		for(int i=0;i<chs.length;i++)
			System.out.print("chs["+i+"] = "+chs[i]);
		
		// 检查一个字符串既不是null也不为空串
		String str = " ";
		if(str!=null&&str.length()!=0)
			System.out.println("str="+str);
		
	}

}
