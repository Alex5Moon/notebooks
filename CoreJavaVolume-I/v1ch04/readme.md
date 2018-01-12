## 对象与类
> 面向对象程序设计与面向过程程序设计在思维方式上存在着很大的差别。改变一种思维方式并不是一件很容易的事情，而且为了继续学习Java也要弄清楚对象的概念。
### 4.1 面向对象程序设计概述
- 面向对象程序设计（简称OOP）是当今主流的程序设计范型。Java是完全面向对象的，必须熟悉OOP才能够编写Java程序。
> 面向对象的程序是由对象组成的，每个对象包含对用户公开的特定功能部分和隐藏的实现部分。程序中的很多对象来自标准库，还有一些是自定义的。究竟是自己构造对象，还是从外界购买对象完全取决于开发项目的预算和时间。但是，从根本上说，只要对象能够满足要求，就不必关心其功能的具体实现过程。在OOP中，不必关心对象的具体实现，只要能够满足用户的需求即可。
> 
> 传统的结构化程序设计通过设计一系列的过程（即算法）来求解问题。一旦确定了这些过程，就要开始考虑存储数据的方式。这就是Pascal 语言的设计者 Niklaus Wirth 将其著作命名为《算法 + 数据结构 = 程序》（ Algorithms + Data Structures = Programs,Prentice Hall,1975）的原因。需要注意的是，在 Wirth命名的书名中，算法是第一位的，数据结构是第二位的，这就表述了程序员的工作方式。首先要确定如何操作数据，然后再决定如何组织数据，以便于数据操作。而OOP 却调换了这个次序，将数据放在第一位，然后再考虑操作数据的算法。
> 
> 对于一些规模较小的问题，将其分解为过程的开发方式比较理想。而面向对象更加使用于解决规模较大的问题。要想实现一个简单的Web 浏览器可能需要大约 2000个过程，这些过程可能需要对一组全局数据进行操作。采用面向对象的设计风格，可能只需要大约100个类，每个类平均包含20个方法（如下图所示）。后者更易于程序员掌握，也容易找到bug。假设给定对象的数据出错了，在访问过这个数据项的 20 个方法中查找错误要比在2000 个过程中查找容易得多。
> 
> ![1](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/pic/1.JPG)
### 4.1.1 类
> 类（Class）是构造对象的模板或蓝图。我们可以将类想象成制作小甜饼的切割机，将对象想象为小甜饼。由类**构造（construct）**对象的过程称为创建类的**实例（instance）**。
>  
> 封装（encapsulation，有时称为数据隐藏）是与对象有关的一个重要概念。从形式上看，封装不过是将数据和行为组合在一个包中，并对对象的使用者隐藏了数据的实现方式。对象中的数据称为**实例域（instance field）**，操纵数据的过程称为**方法（method）**。对于每个特定的类实例（对象）都有一组特定的实例域值。这些值的集合就是这个对象的当前**状态（state）**。无论何时，只要向对象发送一个消息，它的状态就有可能发送改变。
> 
> 实现封装的关键在于**绝对不能**让类中的方法直接访问其他类的实例域。程序仅通过对象的方法与对象数据进行交互。封装给对象赋予了“黑盒”的特征，这个提高重用性和可靠性的关键。这意味着一个类可以全面地改变存储数据的方式，只要仍旧使用同样的方法操作数据，其他对象就不会知道或介意所发生的变化。
> 
> OOP的另一个原则会让用户自定义Java类变得轻而易举，这就是：可以通过扩展一个类来建立另外一个新的类。事实上，在Java中，所有的类都源自于一个“神通广大的超类”，它就是 Object。下一章有详细介绍。
> 
> 在扩展一个已有的类时，这个扩展后的新类具有所扩展的类的全部属性和方法。在新类中，只需要提供适用于这个新类的新方法和数据域就可以了。通过扩展一个类来建立另外一个类的过程称为**继承（inheritance）**，下一章介绍。
### 4.1.2 对象
- 要想使用OOP，一定要清楚对象的三个主要特性：
1. 对象的行为（behavior）——可以对对象施加哪些操作，或可以对对象施加哪些方法？
2. 对象的状态（state）——当施加那些方法时，对象如何响应？
3. 对象标识（identity）——如何辨别具有相同行为与状态的不同对象？
> 同一个类的所有对象实例，由于支持相同的行为而具有家族式的相似性。对象的行为是用可调用的方法定义的。
> 
> 此外，每个对象都保存着描述当前特征的信息。这就是对象的状态。对象的状态可能会随着时间而发生改变，但这种改变不会是自发的。对象状态的改变必须通过调用方法实现（如果不经过方法调用就可以改变对象状态，只能说明封装性遭到了破坏）。
> 
> 但是，对象的状态并不能完全描述一个对象。每个对象都有一个唯一的身份（identity）。例如，在一个订单处理系统中，任何两个订单都存在着不同之处，即使所订购的货物完全相同也是如此。需要注意的是，作为一个类的实例，每个对象的标识**永远**是不同的，状态**常常**存在着差异。
> 
> 对象的这些关键特性在彼此之间相互影响着。例如，对象的状态影响它的行为（如果一个订单“已送货”或“已付款”，就应该拒绝调用具有增删订单中条目的方法。反过来，如果订单是“空的”，即还没有加入预订的物品，这个订单就不应该进入“已送货”状态）。（如果一个人的信用卡的账单金额是0，就应该拒绝调用还款类方法。反过来，如果信用卡账单金额大于0，拒绝调用账户重置方法，如果账单金额达到最大额度，拒绝调用支付方法）（一个人住院状态不允许结算门诊）
### 4.1.3 识别类
> 传统的过程化程序设计，必须从顶部的main 函数开始编写程序。在面向对象程序设计时没有所谓的“顶部”。对于学习OOP 的初学者来说常常会感觉无从下手。答案是：**首先从设计类开始，然后再往每个类中添加方法。**
> 
> 识别类的简单规则是在分析问题的过程中寻找名词，而方法对应着动词。
> 
> 例如，在订单处理系统中，有这样一些名词：
- 项目（Item）
- 订单（Order）
- 送货地址（Shipping address）
- 付款（Payment）
- 账户（Account）
> 这些名词很可能成为类 Item、Order等。
> 
> 接下来，查看动词：物品项目被添加到订单中，订单被发送或取消，订单货款被支付。对于每一个动词如：“添加”、“发送”、“取消”以及“支付”，都要标记出主要负责完成相应动作的对象。例如，当一个新的条目添加到订单中时，那个订单对象就是被指定的对象，因为它知道如何存储条目以及如何对条目进行排序。也就是说，add应该是Order 类的一个方法，而 Item 对象是一个参数。
### 4.1.4 类之间的关系
- 在类之间，最常见的关系有
1. 依赖（“uses-a”）
2. 聚合（“has-a”）
3. 继承（“is-a”）
> 依赖（dependence），即 “uses-a” 关系，是一种最明显的、最常见的关系。例如，Order类使用Account 类是因为Order 对象需要访问Account 对象查看信用状态。但是Item 类不依赖于 Account类，这是因为Item 对象与客户账户无关。如果一个类的方法操纵另一个类的对象，我们就说一个类依赖于另一个类。
> 
> 应该尽可能地将相互依赖的类减至最少。如果类A 不知道 B 的存在，它就不会关心 B 的任何改变（这意味着 B 的改变不会导致 A 产生任何 bug）。用软件工程的术语来说，就是让类之间的耦合度最小。
> 
> 聚合（aggregation），即 “has-a” 关系，是一种具体且易于立即的关系。例如，一个Order 对象包含一些 Item 对象。 聚合关系意味着类A的对象包含类B的对象。
> 
> 继承（inheritance），即 “is-a” 关系，是一种用于表示特殊与一般关系的。例如，RushOrder 类由 Order 类继承而来。在具有特殊性的 RushOrder类中包含了一些用于优先处理的特殊方法，以及一个计算运费的不同方法（电子产品不需要运费）；而其他的方法，如添加条目、生成账单等都是从 Order类继承来的。一般而言，如果类A 扩展 类B，类A 不但从类B 继承的方法，还会拥有一些额外的功能。
> 
> 很多程序员采用 UML（Unified Modeling Language，统一建模语言）绘制类图，用来描述类之间的关系。类用矩形表示，类之间的关系用带有各种修饰符的箭头表示。
- ![2](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/pic/2.png)
- ![3](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/pic/3.png)

### 4.2 使用预定义类
> 在Java中，没有类就无法做任何事情，我们前面曾经接触过几个类。然而，并不是所有的类都具有面向对象特征。例如，Math 类。在程序中，可以使用Math类的几个方法，如 Math.random，并只需要知道方法名和参数（如果有的话），而不必了解它的具体实现过程。这正是封装的关键所在，当然所有类都是这样。但遗憾的是，Math类只封装了功能，它不需要也不必隐藏数据。由于没有数据，因此也不必担心生成对象以及初始化实例域。
> 
> 接下来将给出一个更典型的类——Date类，从中可以看出如何构造对象，以及如何调用类的方法。
### 4.2.1 对象与对象变量
- 要想使用对象，就必须首先构造对象，并指定其初始状态。然后，对对象应用方法。
- 在Java程序设计语言中，使用**构造器（constructor）**构造新实例。构造器是一种特殊的方法，用来构造并初始化对象。
- 构造器的名字应该与类名相同。要想构造一个Date对象，需要在构造器前面加上 new操作符，如下
```
  new Date()
```
- 这个表达式构造了一个新对象，这个对象被初始化为当前的日期和时间。
- 如果需要，也可以将这个对象传递给一个方法
```
  System.out.pringln(new Date());
```
- 相反，也可以将一个方法应用于刚刚创建的对象上。Date 类有一个toString 方法。
```
  String s = new Date().toString();
```
- 在这两个例子中，构造的对象仅使用了一次。通常，希望构造的对象可以多次使用，因此，需要将一个对象存放在一个变量中：
```
  Date birthday = new Date();
```
- ![4](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/pic/4.png)
- 在对象与对象变量之间存在着一个重要的区别。例如：
```
  Date deadline; // deadline doesn't refer to any object
```
- 定义了一个对象变量deadline，它可以引用Date 类型的对象。但是，一定要认识到：变量deadline 不是一个对象，实际上也没有引用对象。此时，不能讲任何Date方法应用于这个变量上。语句
```
  s = deadline.toString(); // not yet
```
- 将产生编译错误。
- 必须首先初始化变量deadline，这里有两个选择。当然，可以用新构造的对象初始化这个变量：
```
  deadline = new Date();
```
- 也可以让这个变量引用一个已存在的对象：
```
  deadline = birthday;
```
- 现在，这两个变量引用同一个对象
- ![5](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/pic/5.png)
- 一定要认识到：一个对象变量并没有实际包含一个对象，而仅仅引用一个对象。
- 在Java中，任何对象变量的值都是对存储在另外一个地方的一个对象的引用。new 操作符的返回值也是一个引用。
- 可以显示地将对象变量设置为null ，表面这个对象变量目前没有引用任何对象。如果将一个方法应用于一个值为null的对象上，那么就会产生运行错误。
### 4.2.2 Java类库中的 GregorianCalendar类
- 类库设计者决定将保存时间与给时间点命名分开。所以标准Java类库分别包含了两个类：一个是用来表示时间点的Date 类；另一个是表示大家熟悉的日历表示法的GregorianCalendar 类，事实上，GregorianCalendar 类扩展了一个更加通用的 Calendar 类，这个类描述了日历的一般属性。
- 将时间与日历分开是一种很好的面向对象设计。通常，最好使用不同的类表示不同的概念。
- Date 类只提供了少量的方法用来比较两个时间点。例如 befor 和 after 方法分别表示一个时间点是否早于另一个时间点，或者晚于另一个时间点。
```
  if(today.before(birthday))
    System.out.println("Still time to shop for a gift.");
```
- GregorianCalendar 类所包含的方法要比 Date 类多得多。特别是有几个很有用的构造器。
### 4.2.3 更改器方法与访问器方法
- 日历的作用是提供某个时间点的年、月、日等信息。要想查询这些设置信息，应该使用GregorianCalendar 类的get 方法。为了表达希望得到的项，需要借助于Calendar类中定义的一些常量，如 Calendar.MONTH 或 Calendar.DAY_OF_WEEK
```
  GregorianCalendar now = new GregorianCalendar();
  int month = now.get(Calendar.MONTH);
  int weekday = now.get(Calendar.DAY_OF_WEEK);
```
- API 注释列出了可以使用的全部常量。
- 调用set 方法，可以改变对象的状态：
```
  deadline.set(Calendar.YEAR, 2001);
  deadline.set(Calendar.MONTH, Calendar.APRIL);
  deadline.set(Calendar.DAY_OF_MONTH, 15);
```
- 另外，还有一个便于设置年、月、日的方法，调用方法如下：
```
  deadline.set(2001, Calendar.APRIL, 15);
```
- 最后，还可以为给定的日期对象增加天数、星期数、月份等：
```
  deadline.add(Calendar.MONTH, 3);  // move deadline by 3 months
```
- 如果传递的数值是一个负数，日期就向前移。
- get 方法与 set 和 add 方法在概念上是有区别的。get 方法仅仅查看并返回对象的状态，而set 和 add 方法却对对象的状态进行修改。对实例域做出修改的方法称为**更改器方法（mutator method）**，仅访问实例域而不进行修改的方法称为**访问器方法（accessor method）**。
- 通常的习惯是在访问器方法名前面加上前缀 get，在更改器方法面前加上前缀 set。例如，在 GregorianCalendar 类有 getTime 方法和 setTime 方法，它们分别用来获得和设置日历对象所表示的时间点。
```
  Date time = calendar.getTime();
  calendar.setTime(time);
```
- 这两个方法在进行 GregorianCalendar 和 Date 类之间转换时非常有用。这里有一个例子。假定已知年、月、日，并且希望创建一个包含这个时间值的Date对象。由于Date 类不知道如何操作日历，所以首先需要构造一个 GregorianCalendar 对象，然后再调用 getTime 方法获得一个日期：
```
  GregorianCalendar calendar = new GregorianCalendar(year, month, day);
  Date hireDay = calendar.getTime();
```
- 与之相反，如果希望获得 Date 对象中的年、月、日信息，就需要构造一个 GregorianCalendar 对象、设置时间，然后再调用 get 方法：
```
  GregorianCalendar calendar = new GregorianCalendar();
  calendar.setTime(hireDay);
  int year = calendar.get(Calendar.YEAR);
```
- 显示当前月的日历
- [CalendarTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/CalendarTest/CalendarTest.java)
- 正如前面所看到的，日历程序包含了一些复杂问题，例如：某一天是星期几，每个月有多少天等。有了 GregorianCalendar 类一切就变得简单了。我们并不知道 GregorianCalendar 类是如何计算星期数和每个月的天数，而只需要使用类提供的接口：get 方法、set 方法以及 add 方法就可以了。
- 这个示例程序的关键是：可以使用**类的接口**解决复杂任务，而不必知道**其中的实现细节**。
### API java.util.GregorianCalendar 1.1
### API java.text.DateFormatSymbols 1.1
> 
### 4.3 用户自定义类
> 上一章中，已经开始编写了一些简单的类。但是，那些类都只包含一个简单的 main 方法。现在开始学习如何设计复杂应用程序所需要的各种**主力类（workhorse class）**。通常，这些类没有main 方法，却有自己的实例域和实例方法。要想创建一个完整的程序，应该将若干类组合在一起，其中只有一个类有 main 方法。
### 4.3.1 Employee 类
- 在Java中，最简单的类定义形式为：
```
  class ClassName{
    field1
    field2
    ...
    constructor1
    constructor2
    ...
    method1
    method2
    ...
  }
```
- 下面是一个非常简单的 Employee 类
- [EmployeeTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/EmployeeTest/EmployeeTest.java)
- 在这个程序中包含两个类：Employee 类 和带有 public 访问修饰符的 EmployeeTest 类。EmployeeTest类包含了 main方法。
- 源文件名是 EmployeeTest.java，这是因为文件名必须与 public 类的名字相匹配。在一个源文件中，只能有一个公有类，但可以有任意数目的非公有类。
- 接下来，当编译这段源代码的时候，编译器将在目录下创建两个类文件：EmployeeTest.class 和 Employee.class
- 将程序中包含 main 方法的类名提供给字节码解释器，以便启动这个程序：
` java EmployeeTest `
- 字节码解释器开始运行EmployeeTest 类的main 方法中的代码。
### 4.3.2 多个源文件的使用
### 4.3.3 剖析 Employee 类
- 首先从这个类的方法开始。通过查看源代码会发现，这个类包含一个构造器和 4个方法
- 这个类的所有方法都被标记为 public。关键字public 意味着任何类的任何方法都可以调用这些方法（共有4 种访问级别）
- 在Employee 类的实例中有三个实例域用来存放将要操作的数据。关键字 private 确保只有Employee 类自身的方法能够访问这些实例域，而其他类的方法不能够读写这些域。
- 最后，请注意，有两个实例域本身就是对象：name 域是 String类对象， hireDay 域是 Date类对象。这种情形十分常见：类通常包括类型属于某个类类型的实例域。
### 4.3.4 从构造器开始
- 构造器与类同名。在构造 Employee 类的对象时，构造器会运行，以便将实例域初始化为所希望的状态。
- 构造器与其他的方法有一个重要的不同。构造器总是伴随着new 操作符的执行被调用，而不能对一个已经存在的对象调用构造器来达到重新设置实例域的目的。
- 1 构造器与类同名
- 2 每个类可以有一个以上的构造器
- 3 构造器可以有0个、1个或多个参数
- 4 构造器没有返回值
- 5 构造器总是伴随着 new 操作一起调用
- 所有的Java对象都是在堆中构造的，不要在构造器中定义与实例域重名的局部变量。
### 4.3.5 隐式参数与显示参数
- 方法用于操作对象以及存取它们的实例域。
```
  public void raiseSalary(double byPercent){
    double raise = salary * byPercent / 100;
    salary += raise;
  }
```
- raiseSalary 方法有两个参数。第一个参数称为**隐式（implicit）**参数，是出现在方法名前的Employee类对象。第二个参数位于方法名后面括号中的数值，这是一个**显示（explicit）**参数。
- 显示参数是明显的列在方法声明中的，隐式参数没有出现在方法声明中。
- 在每一个方法中，关键字 this 表示隐式参数。
### 4.3.6 封装的优点
- 在有些时候，需要获得或设置实例域的值。应该提供下面三项内容：
- 一个私有的数据域；
- 一个公有的域访问器方法；
- 一个公有的域更改器方法。
> 这样做要比提供一个简单的公有数据复杂些，但是却有着下列明显的好处
- 首先，可以改变内部实现，除了该类的方法之外，不会影响其他代码。
- 更改器方法可以执行错误检查，然而直接对域进行赋值将不会进行这些处理。例如，setSalary 方法可以检查薪金是否小于0.
> 注意不要编写返回引用可变对象的访问器方法。在Employee类中就违反了这个设计原则。其中的 getHireDay 方法返回了一个Date类对象；如果需要返回一个可变对象的引用，应该首先对她进行克隆（clone）
### 4.3.7 基于类的访问权限
- 一个方法可以访问**所属类的所有对象**的私有数据。
### 4.3.8 私有方法
### 4.3.9 final 实例域
> 可以将实例域定义为 final。构建对象时必须初始化这样的域。也就是说，必须确保在每一个构造器执行之后，这个域的值被设置，并且在后续的操作中，不能够再对它进行修改。
- final 修饰符大都应用于**基本（primitive）**类型域，或**不可变（immutable）**类的域（如果类中的每个方法都不会改变其对象，这种类就是不可变的类）。例如，String 类就是一个不可变的类。对于可变的类，使用 final 修饰符可能会对读者造成混乱。
### 4.4 静态域与静态方法
### 4.4.1 静态域
- 如果将域定义为 static，每个类中只有一个这样的域。而每一个对象对于所有的实例域却都有自己的一份拷贝。例如，假定需要给每一个雇员赋予唯一的标识码。这里给Employee 类添加一个实例域 id和 一个静态域 nextId：
```
  class Employee{
    private static int nextId = 1;
    
    private int id;
    ...
  }
```
- 现在，每一个雇员对象都有一个自己的id域，但这个类的所有实例将共享一个 nextId域。换句话说，如果有1000个Employee 类的对象，则有1000 个实例域id。但是，只有一个静态域 nextId。即使没有一个雇员对象，静态域 nextId也存在。它属于类，而不属于任何独立的对象。
### 4.4.2 静态常量
- 静态变量使用得比较少，但静态常量却使用得比较多。例如，在Math 类中定义了一个静态常量
```
  public class Math{
    ...
    public static final double PI = 3.14159265358979323846;
    ...
  }
```
- 在程序中，可以采用 Math.PI 的形式获得这个常量。
- 如果关键字 static 被省略， PI就变成了Math类的一个实例域。需要通过Math 类的对象访问PI ，并且每一个Math 对象都有它自己的一份 PI 拷贝。
- 另一个多次使用的静态常量是System.out。 它在System 类中的声明：
```
  public class System{
    ...
    public static final PrintStream out = ... ;
    ...
  }
```
- 由于每个类对象都可以对公有域进行修改，所以，最好不要讲域设计为public。然而，公有常量（即 final 域）却没问题。因为 out 被声明为final，所以，不允许再将其它打印流赋给它：
`  System.out = new PrintStream(...);  // ERROR -- out is final `
### 4.4.3 静态方法
- 静态方法是一种不能向对象实施操作的方法。例如，Math 类的 pow 方法就是一个静态方法。表达式 Math.pow(x, a) 计算幂 x^a.在运算时，不适用任何Math 对象。换句话说，没有隐式的参数。可以认为静态方法是没有this 参数的方法。
- Employee 类的静态方法**不能访问 Id实例域**，因为它不能操作对象。但是，静态方法可以访问自身类的静态域。
```
  public static int getNextId(){
    return nextId; // returns static field 
  }
```
- 可以通过类名调用这个方法：
` int n = Employee.getNextId(); `
- 这个方法可以省略关键字 static 吗？答案是肯定的。但是，需要通过Employee 类对象的引用调用这个方法。
- 在下面两种情况下使用静态方法：
- 1. 一个方法不需要访问对象状态，其所需参数都是通过显示参数提供（例如：Math.pow）
- 2. 一个方法只需要访问类的静态域（例如： Employee.getNextId）。
### 4.4.4 工厂方法
- 静态方法还有一种常见的用途。 NumberFormat 类使用工厂方法产生不同风格的格式对象。
```
  NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance();
  NumberFormat percentFormatter = NumberFormat.getPercentInstance();
  double x = 0.1;
  System.out.println(currencyFormatter(x));  //  prints $0.10
  System.out.println(percentFormatter(x));   //  prints 10%
```
- 为什么 NumberFormat 类不利用构造器完成这些操作呢？这主要有两个原因：
- 1. 无法命名构造器。构造器的名字必须与类名相同。但是，这里希望将得到的货币实例和百分比实例采用不同的名字。
- 2. 当使用构造器时，无法改变所构造的对象类型。而 Factory 方法将返回一个 DecimalFormat 类对象，这是 NumberFormat 的子类。
### 4.4.5 main方法
- 注意，不需要使用对象调用静态方法。例如，不需要构造Math 类对象就可以调用 Math.pow.
- 同理，main 方法也是一个静态方法。
- main方法不对任何对象进行操作。事实上，在启动程序时还没有任何一个对象。静态的main方法将执行并创建程序所需要的对象。
- [StaticTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/StaticTest/StaticTest.java)
- 这个程序包含了Employee 类的一个简单版本，其中有一个静态域 nextId 和一个静态方法 getNextId。
- Employee 类已有一个静态的main 方法用于单元测试。 
  `java Employee `
  `java StaticTest`
- 执行两个main 方法。
> 
### 方法参数
- 在程序设计语言中有关将参数传递给方法（或函数）的一些专业术语：**按值调用（call by value）**表示方法接收的是调用者提供的值。而**按引用调用（call by reference）**表示方法接收的是调用者提供的变量**地址**。一个方法可以**修改**传递引用所对应的变量值，而不能修改传递值调用所对应的变量值。“按...嗲用（call by）”是一个标准的计算机科学术语，它用来描述各种程序设计语言（不只是Java）中方法参数的传递方式。
- Java程序设计语言**总是**采用按值调用。也就是说，方法得到的是所有参数值的一个拷贝，特别是，方法不能修改传递给它的任何参数变量的内容。
- [CallTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/ParamTest/CallTest.java)
- 方法参数共有两种类型：
- 1. 基本数据类型（数字、布尔值）
- 2. 对象引用
- 一个方法不可能修改一个基本数据类型的参数。而对象引用作为参数就不同了。
- [ParamTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch04/ParamTest/ParamTest.java)
- 上面的程序说明：Java程序设计语言对对象采用的不是引用调用，实际上，**对象引用进行的是值传递**。
- 1 一个方法不能修改一个基本数据类型的参数（即数值型和布尔型），也不能修改不可变对象的状态。
- 2 一个方法可以改变一个对象参数的状态
- 3 一个方法不能让对象参数引用一个新的对象
> 
### 4.6 对象构造
> 前面已经可以编写简单的构造器，便于对定义的对象进行初始化。但是，由于对象构造非常重要，所以Java 提供了多种编写构造器的方式。
### 4.6.1 重载
- 前面的 GregorianCalendar 类有多个构造器。可以使用：
` GregorianCalendar today = new GregorianCalendar();`
- 或
` GregorianCalendar deadline = new GregorianCalendar(2099, Calendar.DECEMBER, 31);`
- 这种特征叫做**重载（overloading）**。如果多个方法（比如，GregorianCalendar 构造器方法）有相同的名字、不同的参数，便产生了重载。编译器必须挑选出具体执行哪个方法，它通过用各个方法给出的参数类型与特定方法所调用的值类型进行匹配来挑选出相应的方法。如果编译器找不到匹配的参数，就会产生编译时错误，因为根本不存在匹配，或者没有一个比其他的更好。（这个过程被称为**重载解析（overloading resolution）**。）
- Java 允许重载任何方法，而不只是构造器方法。因此，要完整地描述一个方法，需要指出**方法名以及参数类型**。这叫做**方法的签名（signature）**。例如，String 类有4个称为indexOf 的公有方法。它们的签名是
```
  indexOf(int)
  indexOf(int, int)
  indexOf(String)
  indexOf(String, int)
```
- 返回类型不是方法签名的一部分。也就是说，不能有两个名字相同、参数类型也相同却返回不同类型值的方法。
### 4.6.2 默认域初始化
- 如果在构造器中没有显式地给域赋予初值，那么就会被自动地赋为默认值：数值为 0、布尔值为 false、对象引用为 null。然而，只有缺少程序设计经验的人才会这样做。确实，如果不明确地对域进行初始化，就会影响程序代码的可读性。
- **注：**这是域与局部变量的主要不同点。必须明确地初始化方法中的局部变量。但是，如果没有初始化类中的域，将会被初始化为默认值（0、false 或 null）。
- 例如，Employee类，假定没有在构造器中对某些域进行初始化，就会默认地将 salary 域初始化为0，将 name、hireDay 域初始化为 null。
- 但是，这并不是一种良好的编程习惯。如果此时调用 getName方法或 getHireDay方法，将会得到一个 null 引用，这应该不是我们所希望的结果：
```
  Date h = harry.getHireDay();
  calendar.setTime(h);  // throws exception if h is null
```
### 4.6.3 无参数的构造器
- 很多类都包含了一个无参数的构造器，对象由无参数构造函数创建时，其状态会设置为适当的默认值。例如，以下是Employee 类的无参数构造函数：
```
  public Employee(){
    name = "";
    salary = 0;
    hireDay = new Date();
  }
```
- 如果在编写一个类时没有编写构造器，那么系统就会提供一个无参数构造器。这个构造器将所有的实例域设置为默认值。于是，实例域中的数值型数据设置为0、布尔型数据设置为 false、所有对象变量将设置为 null。
- 如果类中提供了至少一个构造器，但是没有提供无参数的构造器，则在构造对象时如果没有提供参数就会被视为**不合法**。例如，在Employee 类提供了一个简单的构造器：
` Employee(String name, double salary, int y, int m, int d)`
- 对于这个类，构造默认的雇员属于不合法。也就是说，调用
` e = new Employee();`
- 将产生错误。
#### 警告！
- 仅当类没有提供任何构造器的时候，系统才会提供一个默认的构造器。如果在编写类的时候，给出了一个构造器，哪怕是很简单的，要想让这个类的用户能够采用下列方式构造实例：
` new ClassName()`
- 就必须提供一个默认的构造器（即不带参数的构造器）。当然，如果希望所有域被赋予默认值，可以采用下列各式：
```
  public ClassName(){
    
  }
```
### 4.6.4 显式域初始化
- 由于类的构造器方法可以重载，所以可以采用多种形式设置类的实例域的初始状态。确保不管怎样调用构造器，每个实例域都可以被设置为一个有意义的初值。这是一种很好的设计习惯。
- 可以在类定义中，直接将一个值赋给任何域。例如：
```
  class Employee{
    private String name = "";
    ...
  }
```
- 在执行构造器之前，先执行赋值操作。当一个类的所有构造器都希望把相同的值赋予某个特定的实例域时，这种方式特别有用。
- 初始值不一定是常量。在下面的例子中，可以调用方法对域进行初始化。仔细看一下 Employee类，其中每个雇员有一个 id域。可以使用下列方式进行初始化：
```
  class Employee{
    private static int nextId;
    private int id = assignId();
    ... 
    private static int assignId(){
      int r = nextId;
      nextId++;
      return r;
    }
    ...
  }
```



### 初始化块（initialization block）
> 在一个类的声明中，可以包含多个代码块。只要构造类的对象，这些块就会被执行。首先运行初始化块，然后才运行构造器的主体部分。

### 类设计技巧
1. 一定要保证数据私有。
2. 一定要对数据初始化。
3. 不用再类中使用过多的基本类型。
4. 不是所有的域都需要独立的域访问器和域更改器
5. 将职责过多的类进行分解
6. 类名和方法名要能够体现她们的职责。
