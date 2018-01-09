## Java的基本程序设计结构
### 一个简单的Java应用程序
```
public class FirstSample{
  public static void main(String[] args){
    System.out.println("We will not use 'Hello, World!'");
  }
}
```
- 1. Java对大小写敏感
- 2. 关键字public称为访问修饰符（access modifier），她用于控制程序的其他部分对这段代码的访问级别。第5章有详细介绍。
- 3. 关键字class表面Java程序的全部内容都包含在类中。第4章有详细介绍。
- 4. 关键字class后面紧跟类名，必须以字母开头，不能使用Java保留字。类名是以大写字母开头的名词。骆驼命名法CamelCase
- 5. javac FirstSample.java 编译程序，生成FirstSample.class文件；java FirstSample 运行程序，Java虚拟机将从指定类中的main方法开始执行。
### 注释（三种方式）
- 1. 最常用的是使用 // ，其注释内容从 // 开始到本行结尾
- 2. 长篇注释：既可以在每行注释前标记 //，也可以用/* 和 */ 将一段比较长的注释括起来。
- 3. 第三种注释可以自动地生成文档，以 /** 开始，以 */ 结束。具体方法第4章
### 数据类型（Java是一种强类型语言）
- **必须为每一个变量声明一种类型。**
> Java中一共有8种基本类型（primitive type）：4种整型、2种浮点类型、1种表示Unicode编码的字符单元的字符类型char，和1种表示真值的Boolean类型
#### 整型
- 1. byte    1字节 
- 2. short   2字节
- 3. int     4字节
- 4. long    8字节
> 通常情况下，int类型最常用。但如果表示星球上的居住人数，就需要使用long类型了。byte和short类型主要用于特定的应用场合，例如，底层文件处理或者控制占用存储空间的大数组。
- 关于取值范围，底层是用二进制表示的，一个字节是8位，所以byte 可以表示 2 的 1x8 个数，short 可以表示 2 的 2x8 个数，int 可以表示 2 的 4x8 个数...，所以操作的时候需要考虑**溢出**
- **整数直接默认int型**,long型有一个后缀L，十六进制有前缀 0x （如0xCAFE），八进制有前缀 0 （如010对应8）。
- 从Java 7 开始，加上前缀 0b 就可以写二进制数。（如 0b1001 就是 9）
- 注意，Java没有任何无符号类型（unsigned）
```
  在这里就可以看出java虚拟机的一个优势，平台无关性。
  在Java中，整型的范围与运行Java代码的机器无关。于此相反，C/C++ 需要针对不同的处理器选择最为有效的整型，这样就有可能
  造成一个在32位处理器上运行很好的程序在16位系统上运行却发生整数溢出。
  在C/C++ 中，int 表示的整型与目标平台相关。在8086这样的16位处理器上占 2 字节，在32位处理器上，占 4 字节。
  类似的，在32位处理器上long 占4 字节，在 64位处理器上占 8字节。由于存在这些差别，对编写跨平台程序带来了很大难度。
  在Java中，所有的数值类型所占据的字节数量与平台无关。
  有优势也有劣势，牺牲了一些性能。
```
#### 浮点类型
- 1. float   4字节   大约 +- 3.402 823 47E + 38F （有效位数为 6 ~ 7）
- 2. double  8字节   大约 +- 1.797 693 134 862 315 70E + 308 （有效位数 15）
- 浮点型默认double（双精度），float 类型有一个后缀 F
- 2.0-1.1 二进制系统中无法精确的表示分数 1/10,浮点数值不适用于禁止出现舍入误差的金融计算中。如果需要在数据计算中不含有任何舍入误差，适用BigDecimal 类。
#### char类型
- char 2字节 表示字符常量，Unicode编码，取值范围 \u0000 到 \uffff
- 'A'与"A" 不同。
#### boolean类型
- 有两个值： false 和 true，用来判定逻辑条件。整型值和布尔值不能相互转换。
> 在C++中，数值或指针可以代替 boolean值，0相当于false，非 0 相当于true。 
```
  if ( x = 0) // oops ... meant x == 0 
```
> 在C++ 中这个测试可以编译运行，其结果总是 false。而在 Java中，这个测试将不能通过，因为整数表达式 x=0 不能转换为布尔值。
### 变量
> 在Java中，每一个变量属于一种类型（type）。在变量声明时，变量所属的类型位于变量名之前。
- 1. 变量初始化：声明一个变量之后，必须用赋值语句对变量进行显式初始化，**千万不要使用未被初始化的变量**。
- 2. 常量：利用关键字final 指示常量，一旦被赋值后，就不能再更改了。 用关键字 static final 设置一个类常量。
### 运算符
- 加、减、乘、除、求余（取模）、二元算术运算符
- 1. 自增和自减  ++n 与 n++ 的区别
- 2. 关系运算符与boolean运算符  ==，!=，&&，|| （短路） ， 三元操作符 condition ? expression1 : expression2 
- 3. 位运算符 &（与），|（或），^（异或），~（非），
>  << 、>> 运算符将二进制位进行左移或右移操作,当需要建立位模式屏蔽某些位时，使用这两个运算符十分方便。>>> 用0 填充高位，>> 运算符用符号位填充高位。没有 <<< 运算符。
- 4. 数学函数与常量：Math类中，提供了各种各样的数学函数。
> Math.sin, Math.con, Math.tan, Math.atan, Math.atan2, 
> 
> Math.sqrt, Math.pow,
> 
> Math.exp, Math.log, Math.log10,
> 
> Math.PI, Math.E, 
> 
> Math.round, Math.random
- 5. 数值类型之间的转换 优先级 double > float > long > int 
- 6. 强制类型转换
```
    double x = 9.9997;
    int nx = (int) x; // 9
        nx = (int) Math.round(x); // 10
    byte n = (byte)300 ; // 44 ?    
```
- 7. 括号与运算符级别
- 8. 枚举类型:有限个命名的值
```
 enum Size {SMALL, MEDIUM, LARGE, EXTRA_LARGE};
 Size s = Size.MEDIUM;
```
### 字符串
> 从概念上讲，Java字符串就是Unicode 字符序列。例如 串 “Java\u2112” 由5 个Unicode字符。 Java没有内置的字符串类型，而是在标准Java类库中提供了一个预定义类，String。每个用双引号括起来的字符串都是**String类的一个实例。**
- 1. 子串 String类的 substring 方法可以从一个较大的字符串提取出一个子串。
```
  String greeting = "Hello";
  String s = greeting.substring(0,3); // Hel
```
- 2. 拼接 +
- 3. 不可变字符串
> String 类没有提供用于**修改**字符串的方法。如果希望将greeting 的内容修改为 “Help!”，不能直接地将greeting 的最后两个位置的字符修改为 ‘p’ 和 ‘!’。
```
  greeting = greeting.substring(0,3) + "p!"; 
```
> 上面这条语句将greeting当前值修改为 “Help!”。
- 由于不能修改Java字符串中的字符，所以在Java文档中将String 类对象称为**不可变字符串**。上面的其实是将greeting 的引用指向了 “Help!”对象。
- 4. 检测字符串是否相等 s.equals(t) s 与 t 可以是字符串变量，也可以是字符串常量。 equalsIgnoreCase
```
  "Hello".equals(greeting)
  "Hello".equalsIgnoreCase("hello")
```
> **一定不能用 == 运算符检测两个字符串是否相等！**这个运算符只能确定两个字符串是否放在同一个位置上。
```
  String greeting = "Hello"; // initialize greeting to a string
  if (greeting == "Hello")...
     // probably true
  if (greeting.substring(0,3) == "Hel")...
     // probable false
```
> 如果虚拟机始终将相同的字符串共享，就可以用 == 检测是否相等。但实际上只有字符串**常量**是共享的，而 + 或 substring 等操作产生的结果并不是共享的。因此，千万不要使用 == 运算符测试字符串的相等性。
- 5. 空串 与 Null 串
> 空串""是长度为0 的字符串。可以用以下代码
```
  if(str.length() == 0)
  或
  if(str.equals(""))
```
> 空串是一个Java对象，有自己的串长度（0）和内容（空）。不过，String变量还可以存放一个特殊的值，名为null。检查一个字符串是否是null
```
  if(str == null)
```
> 有时要检查一个字符串既不是null 也不为空串，需要以下条件:  首先要检查 str 不为null。
```
  if(str != null && str.length() != 0)
```
- 6. 代码点与代码单元 ？ 没用过
- 7. 字符串API
> char charAt (int index);
> 
> int length();
> 
> int indexOf(String str); 
> 
> int lastIndexOf(String str);
> 
> boolean startsWith(String prefix); 
> 
> boolean endsWith(String suffix);
> 
> boolean equals(Object other); 
> 
> String trim(); 
> 
> String substring(int beginIndex);
> 
> String toLowerCase();
> 
> String replace(CharSequence oldString, CharSequence newString);
- 8. 阅读联机 API 文档
> API文档是JDK 的一部分，它是HTML格式的。让浏览器指向安装JDK 的 docs/api/index.html 子目录
- 9. 构建字符串
> 有些时候，需要由较短的字符串构建字符串，例如，按键或来自文件中的单词。采用字符串连接的方式达到此目的效率比较低。每次连接字符串，都会构建一个新的String对象，**既耗时，又浪费空间。**使用StingBuilder 类就可以避免这个问题的发生。操作步骤如下：
```
  StringBuilder builder = new StringBuilder();  // 1. 构建一个空的字符串构建器。
  // 当每次需要添加一部分内容时，就调用 append 方法
  builder.append(ch);  // appends a single character
  builder.append(str); // appends a string
  // 当需要构建字符串时就调用 toString 方法，将可以得到一个String对象，其中包含了构建器中的字符序列
  String completedString = builder.toString();
```
> 在JDK 5.0中引入 StringBuilder 类。这个类的前身是 StringBuffer，其效率稍有些低，但允许采用**多线程**的方式执行添加或删除字符的操作。如果所有字符串在一个单线程中编辑（通常都是这样），则应该用 StringBuilder 替代它。这两个类的 API 是相同的。
> 
> StringBuilder(); 
> 
> int length();
> 
> StringBuilder append(String str); 
> 
> StringBuilder append(char c); 
> 
> void setCharAt(int i, char c); 
> 
> StringBuilder insert(int offset, String str);
> 
> StringBuilder insert(int offset, char c); 
> 
> StringBuilder delete(int startIndex, int endIndex); 
> 
> String toString()
### 输入输出
- 1. 读取输入
> [inputTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch03/InputTest/InputTest.java)
> 
> Scanner 类定义在 java.util包中。当使用的类不是定义在基本 java.lang 包中时，一定要使用 import 指示字将相应的包加载进来。
> 
> Scanner(InputStream in); 
> 
> String nextLine();
> 
> String next(); 
> 
> int nextInt(); 
> 
> double nextDouble(); 
> 
> boolean hasNext();...
- 2. 格式化输出
> 类似C 语言中的 printf()
- 3. 文件输入与输出
> 要想对文件进行读取，需要一个用File 对象构造一个Scanner 对象，如
```
  Scanner in = new Scanner(Paths.get("myfile.txt"));
```
> 如果文件名中包含反斜杠符号，就要记住**在每个反斜杠之前再加一个额外的反斜杠**
```
  Scanner in = new Scanner(Paths.get("c:\\mydirectory\\myfile.txt"));
```
> 要想写入文件，需要构造一个PrintWriter 对象。在构造器中，只需要提供文件名：
```
  PrintWriter out = new PrintWriter("c:\\mydirectory\\myfile.txt");
```
### 控制流程
- 与任何程序设计语言一样，Java 使用条件语句和循环结构确定控制流程。
- 1. 块（block）作用域 
- 2. 条件语句
> if (condition1) statement1; else if(condition2) statement2; else statement3
- 3. 循环
> while (condition) statement 、 do statement while (condition) 、 
> 
> [Retirement.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch03/Retirement/Retirement.java)
> 
> [Retirement2.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch03/Retirement2/Retirement2.java)
- 4. 确定循环
> for循环语句是支持迭代的一种通用结构，利用每次迭代之后更新的计数器或类似的变量来控制迭代次数。下面的程序将数字 1 ~ 10 输出到屏幕上。
```
  for (int i=1; i <= 10; i++)
    System.out.println(i);
```
> for语句的第 1 部分通常用于对计数器初始化；第 2 部分给出每次新一轮循环执行前要检测的循环条件；第 3 部分指示如何更新计数器。
> 
> 在循环中，检测两个浮点数是否相等需要格外小心。下面的for循环可能永远都不会结束。因为 0.1 无法精确地用二进制表示。
```
  for (double x = 0; x != 10; x += 0.1)...
```
> [LotteryOdds.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch03/LotteryOdds/LotteryOdds.java)
- 5. 多重选择：switch 语句
> switch case break default;
- 6. 中断控制流程语句
> break continue
### 大数值
- 如果基本的整数和浮点数精度不能够满足需求，那么可以使用 java.match 包中的两个很有用的类：BigInteger 和 BigDecimal
- BigInteger 实现了任意精度的整数运算   
- BigDecimal 实现了任意精度的浮点数运算 
>  [BigIntegerTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch03/BigIntegerTest/BigIntegerTest.java)
### 数组
- 数组是一种数据结构，用来存储同一类型值的集合。通过一个整型下标可以访问数组中的每一个值。
```
  int[] a;
   或
  int a[]; 
```
- 创建一个**数字数组**时，所有的元素都**初始化为0**.**boolean数组**的元素会**初始化为false**。**对象数组**的元素则**初始化为一个特殊值null**，这表示这些元素还未存放任何对象。
```
  String[] names = new String[10];  // 创建一个包含10个字符串的数组，所有字符串都为null。
  //  如果希望这个数组包含空串，可以为元素指定空串：
  for (int i = 0; i < 10; i++) names[i] = "";
```
- 如果创建了一个100个元素的数组，并且试图访问任何在 0 ~ 99 之外的下标时，会引发 “ array index out of bounds” 异常而终止执行。
- **array.length** 可以获得数组中元素的个数
```
  for（int i = 0;i < a.length; i++）
    System.out.println(a[i]);
```
- 一旦创建了数组，就**不能再改变它的大小**（尽管可以改变每一个数组元素）。如果经常需要在运行中扩展数组的大小，就应该使用另一种数据结构——数组列表（array list）
- 1. for each 循环
> Java有一种功能很强的循环结构，可以用来依次处理数组中的每个元素而不必为指定下标值而分心。
```
  // for (variable : collection) statement
  for (int element : a)
    System.out.println(element);
  for (int i = 0; i < a.length; i++)
    System.out.println(a[i]);
  // 有个更加简单的方式打印数组中的所有值
  System.out.println(Arrays.toString(a));
```
- 2. 数组初始化以及匿名数组
- 3. 数组拷贝
> 在Java中，允许将一个数组变量拷贝给另一个数组变量。这时，两个变量将引用同一个数组。**Arrays 类的 copyOf方法**，第二个参数是新数组的长度。
```
  int[] copiedLuckNumbers = Arrays.copyOf(luckNumbers,luckNumbers.length)
```
- 4. 命令行参数
> 每一个Java应用程序都有一个带 String arg[] 参数的main方法。这个参数表明main方法将接收一个字符串数组，也就是命令行参数。
- 5. 数组排序
> 要想对数值型数组进行排序，可以使用**Arrays 类中的 sort方法**：这个方法使用了优化的 快速排序算法。
```
  int[] a = new int[10000];
  ...
  Arrays.sort(a);
```
> [LotteryDrawing.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch03/LotteryDrawing/LotteryDrawing.java)
- API
```
  static  String  toString(type[] a)
  static  type    copyOf(type[] a, int lengh)
  static  type    copyOfRange(type[] a, int start, int end)
  static  void    sort(type[] a)
  static  int     binarySearch(type[] a, type v)
  static  int     binarySearch(type[] a, int start, int end, type v)
  static  void    fill(type[] a, type v)  // 将数组所有元素值设置为 v
  static  boolean  equals(type[] a, type[] b)
```
- 6. 多维数组
> 多维数组将使用多个下标访问数组元素，它使用于表示格式或更加复杂的排列形式。
>
> for each 循环语句不能自动处理二维数组的每一个元素。它是按照行，也就是一维数组处理的。要想访问二维数组a的所有元素，需要使用两个嵌套的循环：
```
  for (double[] row : a)
    for (double value : row)
      do something with value      
```
> 快速地打印一个二维数组的数据元素列表
```
  System.out.pringln(Arrays.deepToString(a));
```
> 计算投资增长情况[CompoundInterest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch03/CompoundInterest/CompoundInterest.java) 
- 7. 不规则数组
> 目前为止，数组与其他程序设计语言中提供的数组没有多大区别。但实际上存在着一些细微的差异，这正是Java的优势所在：Java实际上没有多维数组，只有一维数组。多维数组被解释为**“数组的数组”**。
> 
> [LotteryArray.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch03/LotteryArray/LotteryArray.java)






