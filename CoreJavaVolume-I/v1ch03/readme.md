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
> Math.sin, Math.con, Math.tan, Math.atan, Math.atan2, Math.sqrt, Math.pow, Math.exp, Math.log, Math.log10, Math.PI, Math.E, Math.round
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
> 如果虚拟机始终将相同的字符串共享，就可以用 == 检测是否相等。但实际上只有字符串**常量**是共享的，而 + 或 substring 等操作产生的结果并不是共享的。因此，千万不要使用 == 运算符测试字符串的相等行。
- 5. 空串 与 Null 串
> 空串""是长度为0 的字符串。可以用以下代码





