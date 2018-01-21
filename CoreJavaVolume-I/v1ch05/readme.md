## 继承
- 面向对象程序设计的一个基本概念：**继承（inheritance）**。利用继承，人们可以基于已存在的类构造一个新类。继承已存在的类就是复用（继承）这些类的方法和域，在此基础上，还可以添加一些新的方法和域，以满足新的需求。这是Java程序设计中的一项核心技术。
- **反射（reflection）的概念：**反射是指在程序运行期间发现更多的类及其属性的能力。这是一个功能强大的特性，使用起来比较复杂。主要是开发软件工具，而不是编写应用程序。
### 5.1 类、超类和子类
> 假设你在某个公司工作，这个公司中经理的待遇和普通雇员的待遇存在着一些差异。不过，他们之间也存在着很多相同的地方，例如，他们都领取薪水。只是普通雇员在完成本职任务之后仅领取薪水，而经理在完成了预期的业绩之后还能得到奖金。这种情形就需要使用继承。这是因为需要为经理定义一个新类Manager，以便于增加一些新功能。但可以重用Employee 类中已经编写的**部分**代码，并将其中的**所有域**保留下来。从理论上讲，在Manager 与 Employee 之间存在着明显的“ is-a”（是）关系，每个经理都是一名雇员：“is-a” 关系是继承的一个明显特征。
- 下面是由继承 Employee 类来定义 Manager 类的格式，关键字extends 表示继承。
```
  class Manager extends Employee{
    添加方法和域
  }
```
- 关键字 extends 表明正在构造的新类派生于一个已存在的类。已存在的类称为**超类（superclass）、基类（base class）**或**父类（parent class）**；新类被称为**子类（subclass）、派生类（derived class）**或**孩子类（child class）**。
- 尽管Employee 类是一个超类，但并不是因为它位于子类之上或者拥有比子类更多的功能。实际上**恰恰相反**，子类比超类拥有的功能**更加丰富**。
- 在Manager 类中，增加一个用于存储奖金信息的域，以及一个用于设置这个域的方法：
```
  class Manager extends Employee{
    private double bonus;
    ...
    public void setBonus(double b){
      bonus = b;
    }
  }
```
- 尽管在Manager 类中没有显式地定义getName 和 getHireDay 等方法，但属于 Manager 类的对象却可以使用它们，这是因为 Manager 类自动地继承了超类Employee 中的这些方法。
- 同样，从超类中还继承了 name、salary 和 hireDay 这3个域。这样一来，每个Manager 类对象就包含了 4 个域：name、salary、hireDay和 bonus。
- 在通过扩展超类定义子类的时候，仅需要指出子类与超类的**不同之处**。因此在设计类的时候，应该将通用的方法放在超类中，而将具有特殊用途的方法放在子类中，这种将通用的功能放到超类的做法，在面向对象程序设计中十分普遍。
- 然而，超类中的有些方法对子类 Manager 并不一定适用。具体来说， Manager 类中的getSalary 方法应该返回薪水和奖金的总和。为此，需要提供一个新的方法来**覆盖（override）**超类中的这个方法：
```
  class Manager extends Employee{
    ...
    public double getSalary(){
      ...
    }
    ...
  }
```
- 如何实现这个方法？乍看起来似乎很简单，只要返回 salary 和 bonus 域的总和就可以了：
```
  public double getSalary(){
    return salary + bonus; // won't work
  }
```
- 然而，这个方法并不能运行。这是因为 Manager 类的getSalary 方法不能够**直接地访问超类的私有域**。也就是说，尽管每个Manager 对象都拥有一个名为 salary 的域，但在Manager 类的getSalary 方法并不能够直接地访问salary 域。只有 Employee 类的方法才能够访问私有部分。如果Manager 类的方法一定要访问私有域，就必须借助于公有的接口，Employee 类中的公有方法 getSalary 正是这样一个接口。
- 现在，将对salary 域的访问替换成调用 getSalary 方法。
```
  public double getSalary(){
    double baseSalary = getSalary();   // still won't work
    return baseSalary + bonus;
  }
```
- 上面这段代码仍然不能运行。问题出现在调用 getSalary 的语句上，这是因为Manager 类也有一个 getSalary 方法（就是正在实现的这个方法），所以这条语句将会无限次地调用**自己**，直到整个程序崩溃位置。
- 注意：我们希望调用超类 Employee 中的 getSalary 方法，而不是当前类的这个方法。为此，可以使用特定的关键字 super 解决这个问题。
- ` super.getSalary() `
- 上述语句调用的是 Employee 类中的getSalary 方法。下面是Manager 类中 getSalary 方法的正确书写格式：
```
  public double getSalary(){
    double baseSalary = super.getSalary();
    return baseSalary + bonus;
  }
```
- 在子类中可以**增加域、增加方法**或**覆盖超类**的方法，然而绝对不能删除继承的任何域和方法。
- super 在构造器中应用
```
  public Manager(String n, double s, int year, int month, int day){
    super(n, s, year, month, day);
    bonus = 0;
  }
```
- 由于Manager 类的构造器不能访问Employee 类的私有域，所以必须利用Employee 类的构造器对这部分私有域进行初始化，我们可以通过super 实现对超类构造器的调用。使用 super 调用构造器的语句必须是子类构造器的第一条语句。
- 如果子类的构造器没有显式地调用超类的构造器，则将自动地调用超类默认（没有参数）的构造器。如果超类没有不带参数的构造器，并且在子类的构造器中又没有显式地调用超类的其他构造器，则Java 编译器将报告错误。
1. 关键字 this  有两个用途：一是引用隐式参数，二是调用该类其他的构造器。
2. 关键字super也有两个用途：一是调用超类的方法，二是调用超类的构造器。
- 程序[ManagerTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/inheritance/ManagerTest.java) 展示了 Employee 对象[Employee.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/inheritance/Employee.java) 与 Manager 对象[Manager.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/inheritance/Manager.java) 在薪水计算上的区别。
- 一个对象变量可以指示多种实际类型的现象被称为**多态（polymorphism）**。
- 在运行期能够自动地选择调用哪个方法的现象被称为**动态绑定（dynamic binding）**。
### 5.1.1 继承层次
- 继承并不仅限于一个层次。例如，可以由 Manager 类派生 Executive 类。由一个公共超类派生出来的所有类的集合被称为**继承层次（inheritance hierarchy）**。在继承层次中，从某个特定的类到其祖先的路径被称为该类的**继承链（inheritance chain）**。
- 通常，一个祖先类可以拥有多个子孙继承链。例如，可以由 Employee 类派生出子类 Programmer 或 Secretary，它们与Manager 类没有任何关系（有可能它们彼此之间也没有任何关系）。必要的话，可以将这个过程一直延续下去。
- Java 不支持多继承。Java中的多继承功能通过接口实现。
### 5.1.2 多态
- 有一个用来判断是否应该设计为继承关系的简单规则，这就是 “is-a” 规则，它表明子类的每个对象也是超类的对象。例如，每个经理都是雇员，因此，将 Manager类设计为 Employee 类的子类是显而易见的，反之不然，并不是每一名雇员都是经理。
- “is-a” 规则的另一种表述法是**置换法则**。它表明程序中出现超类对象的任何地方都可以用子类对象置换。
- 例如，可以将一个子类的对象赋给超类对象。
```
  Employee e;
  e = new Employee(...);   // Employee object expected
  e = new Manager(...);    // OK, Manager can be used as well
```
- 在Java 程序设计语言中，对象变量是**多态的**。一个Employee 变量既可以引用一个Employee 类对象，也可以引用一个Employee 类的任何一个子类对象（例如，Manager、Executive、Secretary等）
- 从[ManagerTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/inheritance/ManagerTest.java)中，可以看到置换法则的优点：
```
  Manager boss = new Manager(...);
  Employee[] staff = new Employee[3];
  staff[0] = boss;
```
- 在这个例子中，变量 `staff[0]`与 `boss`引用同一个对象。但编译器将`staff[0]`看成Employee对象。这意味着
- ` boss.setBonus(5000); // OK `
- 但不能这样调用
- ` staff[0].setBonus(5000); // ERROR`
- 因为`staff[0]`声明的类型是Employee，而 setBonus不是 Employee类的方法。
- 然而，不能将一个超类的引用赋予子类变量。例如，
- ` Manager m = staff[i];   // ERROR `
- 原因很明显：并不是所有的雇员都是经理。如果赋值成功，m 有可能引用了一个不是经理的 Employee 对象，当在后面调用 m.setBonus(...) 时就有可能发生运行时错误。
### 5.1.3 动态绑定
- 弄清调用对象方法的执行过程十分重要。下面是调用过程的详细描述：
- 1）编译器查看对象的什么类型和方法名。假设调用 x.f(param)，且隐式参数 x 声明为 C 类的对象。需要注意的是：有可能存在多个名字为 f ，但参数类型不一样的方法。例如，可能存在方法 f（int） 和方法 f（String）。编译器将会一一列举所有 C 类中名为 f 的方法和其超类中访问属性为 public 且名为 f 的方法（超类的私有方法不可访问）。
- 至此，编译器已获得所有可能被调用的候选方法。
- 2）接下来，编译器将查看调用方法时提供的参数类型。如果在所有名为 f 的方法中存在一个与提供的参数类型完全匹配，就选择这个方法。这个过程被称为**重载解析（overloading resolution）**。例如，对于调用 x.f( "Hello" ) 来说，编译器将会挑选 f（String），而不是 f（int）。由于允许类型转换（int 可以转换成 double，Manager 可以转换成 Employee，等等），所以这个过程可能很复杂。如果编译器没有找到与参数类型匹配的方法，或者发现经过类型转换后有多个方法与之匹配，就会报告一个错误。
- 至此，编译器已获得需要调用的方法名字和参数类型。
- 方法的名字和参数列表称为方法的签名。例如，f(int) 和 f(String) 是两个具有相同名字，不同签名的方法。如果在子类中定义了一个与超类签名相同的方法，那么子类中的这个方法就覆盖了超类中的这个相同签名的方法。
- 不过，返回类型不是签名的一部分，因此，在覆盖方法时，一定要保证返回类型的兼容性。**允许子类将覆盖方法的返回类型定义为原返回类型的子类型（基本类型必须相同），访问权限子类不能小于父类。**。例如，假设 Employee 类有
- ` public Employee getBuddy(){...} `
- 管理人员不会想找这种地位低下的员工。为了反映这一点，在后面的子类 Manager 中，可以按照如下方式覆盖这个方法
- ` public Manager getBuddy(){...}  // OK to change return type `
- 我们说，这两个 getBuddy 方法具有可协变的返回类型。
- 3）如果是private 方法、static 方法、final 方法 或者构造器，那么编译器将可以准确地知道应该调用哪个方法，我们将这个调用方式称为**静态绑定（static binding）**。
- 4）当程序运行，并且采用动态绑定调用方法时，虚拟机一定调用与 x 所引用对象的**实际**类型最合适的那个类的方法。假设 x 的实际类型是 D，它是C 类的子类。如果D 类定义了方法 f（String），就直接调用它；否则，将在 D类的超类中寻找 f（String），以此类推。
- 每次调用方法都要进行搜索，时间开销相当大。因此，虚拟机预先为每个类创建了一个**方法表（method table）**，其中就列出了所有方法的签名和实际调用的方法。这样一来，虚拟机搜索D 类的方法表，以便寻找与调用 f（String）相匹配的方法。这个方法既可能是 D.f(String)，也有可能是 X.f（String），这里的X 是 D的超类。注意：如果调用 super.f(param)，编译器将对隐式参数超类的方法表进行搜索。
- 分析[ManagerTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/inheritance/ManagerTest.java)中调用e.getSalary() 的详细过程。 e 声明为 Employee 类型。Employee 类只有一个名叫 getSalary 方法，这个方法没有参数。因此，在这里不必担心重载解析的问题。
- 由于 getSalary 不是 private方法、static方法或final 方法，所以将采用动态绑定。虚拟机为 Employee 和Manager 两个类生成方法表。在 Employee 的方法表中，列出了这个类定义的所有方法：
```
  Employee:
      getName() -> Employee.getName()
      getSalary() -> Employee.getSalary()
      getHireDay() -> Employee.getHireDay()
      raiseSalary(double) -> Employee.raiseSalary(double)
```
- 实际上，上面列出的方法并不完整，稍后会看到 Employee 类有一个超类 Object， Employee 类从这个超类中还继承了许多方法，在此，省略这些方法。
- Manager 方法表稍微有些不同。其中有三个方法是继承而来的，一个方法是重新定义的，还有一个方法是新增加的。
```
  Manager:
      getName() -> Employee.getName()
      getSalary() -> Manager.getSalary()
      getHireDay() -> Employee.getHireDay()
      raiseSalary(double) -> Employee.raiseSalary(double)
      setBonus(double) -> Manager.setBonus(double)
```
- 在运行的时候，调用 e.getSalary() 的解析过程为：
- 1）首先，虚拟机提取 e 的实际类型的方法表。既可能是 Employee、Manager 的方法表，也可能是 Employee类的其他子类的方法表。
- 2）接下来，虚拟机搜索定义 getSalary 签名的类。此时，虚拟机已经知道应该调用哪个方法。
- 3）最后，虚拟机调用方法。
- 动态绑定有一个非常重要的特性：无需对现存的代码进行修改，就可以对程序进行扩展。假设增加一个新类 Executive，并且变量 e 有可能引用这个类的对象，我们不需要对包含调用 e.getSalary() 的代码进行重新编译。如果 e 恰好引用一个 Executive 类对象，就会自动地调用 Executive.getSalary() 方法。
- 注意：在覆盖一个方法的时候，子类方法不能低于超类方法的可见性。特别是，如果超类方法是 public，子类方法一定要声明为 public。
>
### 5.1.4 阻止继承：final 类和方法
- 有时候，可能希望阻止人们利用某个类定义子类。不允许扩展的类被称为 final 类。如果在定义类的时候使用了final 修饰符就表明这个类是final 类。例如，假设阻止人们定义 Executive 类的子类，就可以在定义这个类的时候，使用final 修饰符声明。格式如下：
```
  final class Executive extends Manager{
    ...
  }
```
- 类中的特定方法也可以被声明为 final。如果这样做，子类就不能覆盖这个方法（final 类中的所有方法自动地成为 final 方法）。例如
```
  class Employee{
    ...
    public final String getName(){
      return name;
    }
    ...
  }
```
- 将方法或类声明为 final 主要目的是：确保它们不会在子类中改变语义。例如，Calendar 类中的 getTime 和 setTime方法都声明为 final。这表明 Calendar 类的设计者负责实现 Date类与日历状态之间的转换，而不允许子类处理这些问题。同样地，String 类也是 final 类，这意味着不允许任何人定义 String 的子类。换言之，如果有一个 String 的引用，它引用的一定是一个 String 对象，而不可能是其他类的对象。
> 
### 5.1.5 强制类型转换
- 将一个类型强制转换成另外一个类型的过程被称为类型转换。Java 程序设计语言提供了一种专门用于进行类型转换的表示法。例如：
- ` double x = 3.405;`
- ` int nx = (int) x;`
- 将表达式 x 的值转换成整数类型，舍弃了小数部分。
- 正像有时候需要将浮点数值转换成整型数值一样，有时候也可能需要将某个类的对象引用转换成另外一个类的对象引用。对象引用的转换语法与数值表达式的类型转换类似，仅需要用一对圆括号将目标类名括起来，并放置在需要转换的对象引用之前就可以了。
- ` Manager = (Manager) staff[0];`
- 好的设计习惯，在进行类型转换之前，先查看一下是否能够成功转换。可以用 instanceof 运算符实现
```
  if(staff[1] instanceof Manager){
    boss = (Manager) staff[1];
  }
```
- 只能在继承层次内进行类型转换。
- 在将超类转换为子类之前，应该使用 instanceof 进行检查。
- 在一般情况下，应该尽量少用类型转换和 instanceof 运算符。
> 
### 5.1.6 抽象类 
- 如果自下而上在类的继承层次结构中上移，位于上层的类更具有通用性，甚至可能更加抽象。从某种角度看，祖先类**更加**通用，人们只将它作为派生其他类的基类，而不作为想使用的特定的实例类。例如，考虑一下对 Employee 类层次的扩展。一名雇员是一个人，一名学生也是一个人。将类 Person  和 类 Student 添加到类的层次结构中。
- 为什么要花费精力进行这样高层次的抽象？每个人都有一些诸如姓名的属性。因此可以将 getName 方法放置位于继承关系较高层次的通用超类中。
- 现在，再增加一个getDescription 方法，可以返回对一个人的简单描述。
- 在 Employee 类和 Student 类中实现这个方法很容易。但是在Person 类中应该提供什么内容？除了姓名之外，Person 类一无所知。当然，可以让 Person.getDescription() 返回一个空字符串。然而，还有一个更好的方法，就是使用 abstract 关键字，这样就完全不需要实现这个方法了。
```
  public abstract String getDescription();
  //  no implementation required
```
- 为了提高程序的清晰度，包含了一个或多个抽象方法的类本身必须被声明为抽象的。
```
  abstract class Person{
    ...
    public abstract String getDescription();
    ...
  }
```
- 除了抽象方法之外，抽象类还可以包含具体数据和具体方法。例如，Person 类还保存着姓名 和一个返回姓名的具体方法。
```
  abstract class Person{
    private String name;
    
    pbulic Person(String n){
      name = n;
    }
    
    public abstract String getDescription();
    
    public String getName(){
      return name;
    }
  }
```
- 抽象方法充当着占位的角色，它们的具体实现在子类中。扩展抽象类可以有两种选择。一种是在抽象类中定义部分抽象类方法或不定义抽象类方法，这样就必须将子类也标记为抽象类；另一种是定义全部的抽象方法，这样一来，子类就不是抽象的了。
- 类即使不含有抽象方法，也可以将类声明为抽象类。
- **抽象类不能实例化**。如果将一个类声明为 abstract，就不能创建这个类的对象。例如，表达式
- ` new Person("Vince Vu")`
- 是错误的，但可以创建一个具体子类的对象。
- 需要注意，可以定义一个抽象类的**对象变量**，但是它只能引用非抽象子类的对象。
- [Person.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/abstractClasses/Person.java) 抽象超类 Person 和两个具体的子类 [Employee.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/abstractClasses/Employee.java) 和 [Student.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/abstractClasses/Student.java) 。[PersonTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/abstractClasses/PersonTest.java) 中 p.getDescription() 这不是调用了一个没有定义的方法吗？ 由于不能构造抽象类 Person 的对象，所以变量p 永远不会引用 Person 对象，而是引用诸如 Employee 或 Student 这样的具体子类对象，而这些对象中都定义了 getDescription 方法。
- 不能忽略Person 超类中的抽象方法，这样就不能通过变量 p 调用 getDescription 方法了。**编译器只允许调用在类中声明的方法。**
> 
### 5.1.7 受保护访问
- 1） 仅对本类可见——private
- 2） 对所有类可见——public
- 3） 对本包和所有子类可见——protected
- 4） 对本包可见——默认
> 
### 5.2 Object：所有类的超类
- Object 类是Java 中所有类的始祖，在Java 中每个类都是由它扩展而来的。
- 可以使用Object 类型的变量引用任何类型的对象：
- ` Object obj = new Employee("Harry Hacker",35000);`
- Object 类型的变量只能用于作为各种值的通用持有者。要想对其中的内容进行具体的操作，还需要清楚对象的原始类型，并进行相应的类型转换：
- ` Employee e = (Employee) obj;`
- 在Java 中，只有**基本类型（primitive types）**不是对象，例如，数值、字符和布尔类型的值都不是对象。所有的数组类型，不管是对象数组还是基本类型的数组都扩展于Object 类。
```
  Employee[] staff = new Employee[10];
  obj = staff; // ok
  obj = new int[10];  // ok
```
### 5.2.1 equals 方法
- Object 类中的equals 方法用于检测一个对象是否等于另外一个对象。在 Object 类中，这个方法将判断两个对象是否具有相同的引用。如果两个对象具有相同的引用，它们一定是相等的。从这点上看，将其作为默认操作也是合乎情理的。然而，对于多数类来说，这种判断并没有什么意义。例如，采用这种方式比较两个 PrintStream 对象是否相等就完全没有意义。然而，经常需要检测两个对象状态的相等性，如果两个对象的状态相等，就认为这两个对象是相等的。
- 例如，如果两个雇员对象的姓名、薪水和雇佣日期都一样，就认为它们是相等的（在实际的雇员数据库中，比较 ID 更有意义。利用下面这个示例演示 equals 方法的实现机制）。
```
  class Employee{
    ...
    public boolean equals(Object otherObject){
      // a quick test to see if the objects are identical
      if (this == otherObject) return true;
      
      // must return false if the explicit parameter is null
      if (otherObject == null) return false;
      
      // if the classes don't match, they can't be equal
      if (getClass() != otherObject.getClass()) return false;
      
      // now we know otherObject is a non-null Employee
      Employee other = (Employee) otherObject;
      
      // test whether the fields have identical values
      return name.equals(other.name) && salary == other.salary && hireDay.equals(other.hireDay);
    }
  }
```
- 为了防备 name 或 hireDay 可能为null 的情况，需要使用 Objects.equals 方法。如果两个参数都为null ，Objects.equals(a, b) 调用将返回 true； 如果其中一个参数为null ，则返回 false；否则，如果两个参数都不为null ，则调用 a.equals(b)。利用这个方法， Employee.equals方法的最后一条语句要改写为：
- ` return Objects.equals(name, other.name) && salary == other.salary && Objects.equals(hireDay, other.hireDay)`
- 在子类中定义equals 方法时，首先调用超类的equals。如果检测失败，对象就不可能相等。如果超类中的域都相等，就需要比较子类中的实例域。
```
  class Manager extends Employee{
    ...
    public boolean equals(Object otherObject){
      if (!super.equals(otherObject)) return false;
      // super.equals checked that this and otherObject belong to the same class
      Manager other = (Manager) otherObject;
      return bonus == other.bonus;
    }
  }
```
> 
### 5.2.2 相等测试与继承
- 如果隐式和显示的参数不属于同一个类，equals 方法将如何处理？这是一个很有争议的问题。在前面的例子中，如果发现类不匹配，equals 方法就返回 false。但是，许多程序员喜欢使用 instanceof 进行检测
- ` if (!(otherObject instanceof Employee)) return false;`
- 这样做不但没有解决 otherObject 是子类的情况，并且还有可能招致一些麻烦。建议不要使用这种处理方式。
- Java语言规范要求equals方法具有下面的特性：
- 1. 自反性：对于任何非空引用x，x.equals(x)应该返回true。
- 2. 对称性：对于任何引用x和y，y.equals(x)返回true<=>x.equals(y)返回true。
- 3. 传递性：
- 4. 一致性：如果x和y引用的对象没有发生变化，反复调用x.equals(y)应该返回同样的结果。
- 5. 对于任意非空引用x，x.equals(null)应该返回false。
- 然而，就对称性来说，当参数不属于同一个类的时候需要仔细考虑！如
- ` e.equals(m)`
- e 是一个Employee 对象，m 是一个Manager 对象，并且两个对象具有相同的姓名、薪水和雇佣日期。如果在 Employee.equals 中用 instanceof 进行检测，则返回 true。然而这意味着反过来调用
- ` m.equals(e)`
- 也需要返回true。对称性不允许这个方法调用返回false，或者抛出异常。
- 这就使得 Manager 类受到了束缚。这个类的 equals 方法必须能够用自己与任何一个 Employee 对象进行比较，而不考虑经理拥有的那部分特有信息！instanceof 测试并不是完美无瑕。
- 从两个截然不同的情况看一下这个问题：
- 如果子类能够拥有自己的相等概念，则对称性需求将强制采用 getClass 进行检测。
- 如果由超类决定相等的概念，那么就可以使用 instanceof 进行检测，这样可以在不同子类的对象之间进行相等的比较。
- 在雇员和经理的例子中，只要对应的域相等，就认为两个对象相等。如果两个Manager 对象所对应的姓名、薪水和雇佣日期均相等，而奖金不相等，就认为它们是不相同的，因此，可以使用 getClass 检测。
- 但是，假设使用雇员的 ID 作为相等的检测标准，并且这个相等的概念适用于所有的子类，就可以使用 instanceof 进行检测，并应该将 Employee.equals 声明为final。
### 编写equals 方法的建议：
- 1）显式参数命名为 otherObject，稍后需要将它转换成另一个叫做other 的变量。
- 2）检测this 与 otherObject 是否引用同一个对象：
- ` if (this == otherObject) return true;`
- 这条语句只是一个优化。实际上，这是一种经常采用的形式。因为计算这个等式要比一个一个地比较类中的域所付出的代价小得多。
- 3）检测otherObject 是否为 null，如果为 null，返回 false。这项检测是很有必要的。
- ` if (otherObject == null) return false;`
- 4）比较this 与 otherObject 是否属于同一个类。如果equals 的语义在每个子类中有所改变，就使用 getClass 检测：
- ` if (getClass() != otherObject.getClass()) return false;`
- 如果所有的子类都拥有统一的语义，就使用instanceof 检测：
- ` if (!(otherObject instanceof ClassName)) return false;`
- 5）将otherObject 转换为相应的类类型变量：
- ` ClassName other = (ClassName) otherObject;`
- 6）现在开始对所有需要比较的域进行比较了。使用 == 比较基本类型域，使用equals 比较对象域。如果所有的域都匹配，就返回 true；否则返回 false。
- ` return field1 == other.field1 && Objects.equals(field2, other.field2) && ...`
- 如果在子类中重新定义 equals，就要在其中包含调用 super.equals(other)。
- 对于数组类型的域，可以使用静态的 Arrays.equals 方法检测相应的数组元素是否相等。
- 下面是实现 equals 方法的一种常见错误。可以找到其中的问题吗？
```
  public class Employee{
    public boolean equals(Employee other){
      return Objects.equals(name, other.name)
        && salary == other.salary
        && Objects.equals(hireDay, other.hireDay);
    }
    ...
  }
```
- 这个方法声明的显式参数类型是 Employee。其结果并没有覆盖 Object类的equals 方法，而是定义了一个完全无关的方法。
- 为了避免发生类型错误，可以使用 @Override 对覆盖超类方法进行标记。
- API: java.util.Arrays 1.2
- ` static Boolean equanls(type[] a, type[] b)`
- 如果两个数组长度相同，并且在对应的位置上数据元素也均相同，将返回true。数组的元素类型可以是 Object、int、long、short、char、byte、boolean、float 或 double。
- API: java.util.Objects 7
- ` static boolean equals(Object a, Object b)`
- 如果a 和 b 都为null，返回 true；如果只是其中之一为 null，则返回 false；否则返回 a.equals(b)
> 
### 5.2.3 hashCode方法
- **散列码（hash code）**是由对象导出的一个整型值。散列码是没有规律的。如果x 和 y是两个不同的对象，x.hashCode() 与 y.hashCode() 基本上不会相同。
- String 类使用下列算法计算散列码：
```
  public int hashCode(){
    int hash = 0;
    for (int i = 0; i < length(); i++)
      hash = 31 * hash + charAt(i);
  }
```
- 由于 hashCode 方法定义在 Object类中，因此每个对象都有一个默认的散列码，其值为对象的存储地址。
```
  String s = "OK";
  StringBuilder sb = new StringBuilder(s);
  out.println(s.hashCode() + " " + sb.hashCode());   // 2556   20526976
  String t = new String("OK");
  StringBuilder tb = new StringBuilder(t);
  out.println(t.hashCode() + " " + tb.hashCode());   // 2556   20527144
```
- 注意，字符串 s 与 t 拥有相同的散列码，这是因为字符串的散列码是由内容导出的。而字符串缓冲 sb 与 tb 却有着不同的散列码，这是因为在 StringBuilder 类中没有定义 hashCode 方法，它的散列码是由 Object 类默认 hashCode 方法导出的对象的存储地址。
- 如果重新定义 equals 方法，就必须重新定义 hashCode 方法，以便用户可以将对象插入到散列表中。
- hashCode 方法应该返回一个整型数值（也可以是负数），并合理地组合实例域的散列码，以便能够让各个不同的对象产生的散列码更加均匀。
- 下面是 Employee 类的hashCode 方法  为什么是 7,11,13 ？
```
  class Employee{
    public int hashCode(){
      return 7 * name.hashCode()
          + 11 * new Double(salary).hashCode()
          + 13 * hireDay.hashCode();
    }
    ...
  }
```
- 不过，在Java 7 中还可以做两个改进。
- 首先，最好使用null 安全的方法 Objects.hashCode。如果其参数为null，这个方法会返回 0，否则返回对参数调用 hashCode 的结果。
```
  public int hashCode(){
    return 7 * Objects.hashCode(name)
        + 11 * new Double(salary).hashCode()
        + 13 * Objects.hashCode(hireDay);
  }
```
- 还有更好的做法，需要组合多个散列值时，可以调用 Objects.hash 并提供多个参数。这个方法会对各个参数调用 Objects.hashCode，并组合这些散列值。这样 Employee.hashCode 方法可以简单写为：
```
  public int hashCode(){
    return Objects.hash(name, salary, hireDay);
  }
```
- equals 与 hashCode 的定义必须一致：如果 x.equals(y) 返回 true，那么 x.hashCode() 就必须与 y.hashCode() 具有相同的值。例如，如果定义的 Employee.equals 比较雇员的 ID，那么 hashCode 方法就需要散列 ID，而不是雇员的姓名或存储地址。
- 如果存在数组类型的域，那么可以使用静态的 Arrays.hashCode 方法计算一个散列码，这个散列码由数组元素的散列码组成。
- API: java.util.Object  1.2
- ` int hashCode()`
> 返回对象的散列码。散列码可以是任意的整数，包括正数或负数。两个对象相等要求返回相等的散列码。
- API: java.util.Objects 7
- ` static int hash(Object ... objects)`
> 返回一个散列码，由提供的所有对象的散列码组合而得到。
- ` static int hashCode(Object a)`
> 如果a 为 null 返回 0，否则返回 a.hashCode()
- API: java.util.Arrays  1.2
- ` static int hashCode(type[] a)`
> 计算数组a 的散列码。组成这个数组的元素类型可以是 object，int，long，short，char，byte，boolean，float 或 double。
> 
### 5.2.4 toString方法
- 在Object 中还有一个重要的方法，就是 toString 方法，它用于返回表示对象值的字符串。下面是一个典型的例子。 Point 类的 toString 方法将返回下面这样的字符串：
- ` java.awt.Point[x=10,y=20]`
- 绝大多数（但不是全部）的toString 方法都遵循这样的格式：类的名字，随后是一对方括号括起来的域值。下面是Employee 类中的 toString 方法的实现：
```
  public String toString(){
    return "Employee[name=" + name
        + ",salary=" + salary 
        + ",hireDay=" + hireDay
        + "]";
  }
```
- 实际上，还可以设计得更好一些。最好通过 getClass().getName() 获得类名的字符串，而不要将类名硬加到 toString 方法中。
```
  public String toString(){
    return getClass.getName 
        +"[name=" + name
        + ",salary=" + salary 
        + ",hireDay=" + hireDay
        + "]";
  }  
```
- toString 方法也可以供子类调用。
- 当然，设计子类的程序员也应该定义自己的 toString 方法，并将子类域的描述添加进去。如果超类使用了 getClass().getName()，那么 子类只要调用 super.toString() 就可以了，例如
```
  class Manager extends Employee{
    return super.toString
        + "[bonus=" + bonus
        + "]";
  }
```
- 现在，Manager 对象将打印输出如下所示的内容
- ` Manager[name=...,salary=...,hireDay=...][bonus=...]`
- 随处可见 toString 方法的主要原因是：只要对象与一个字符串通过操作符 “+” 连接起来，Java编译就会自动调用 toString 方法，以便获得这个对象的字符串描述。
- 如果x是任意一个对象，并调用 out.println(x);
- println 方法就会直接地调用 x.toString()，并打印输出得到的字符串。
- Object 类定义了 toString 方法，用来打印输出对象所属的类名和散列码。例如调用 out.println(System.out) 
- 输出 java.io.PrintStream@2f6684
- 之所以得到这样的结果是因为 PrintStream 类的设计者没有覆盖 toString 方法
- 打印数组 Arrays.toString(arr) ，打印多维数组 Arrays.deepToString
- toString 方法是一种非常有用的调试工具。在标准库中，许多类都定义了 toString 方法，以便用户能够获得一些有关对象状态的必要信息。像下面这样显示调试信息非常有益
- ` out.println("Current position = " + position);`
- 更好的解决方法是 
- ` Logger.global.info("Current position = " + position);`
- [EqualsTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/equals/EqualsTest.java) 
- [Employee.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/equals/Employee.java)
- [Manager.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/equals/Manager.java)
- 实现了 equals、hashCode 和 toString 方法。
- API: java.lang.Object 
- ` Class getClass()`
> 返回包含对象信息的类对象。封装了类运行时的描述
- ` boolean equals(Object otherObject)`
> 比较两个对象是否相等，如果两个对象指向同一块存储区域，方法返回true；否则方法返回 false。在自定义的类中，应该覆盖这个方法。
- ` String toString()`
> 返回描述该对象的字符串。在自定义的类中，应该覆盖这个方法。
- API: java.lang.Class
- ` String getName()`
> 返回这个类的名字
- ` Class getSuperclass()`
> 以 Class 对象的形式返回这个类的超类信息。
> 
### 5.3 泛型数组列表
- 在许多程序设计语言中，特别是在 C++ 语言中，必须在编译时就确定整个数组的大小。程序员对此十分反感。
- 在Java 中，情况就好多了。她允许在运行时确定数组的大小。
```
  int actualSize = ...;
  Employee[] staff = new Employee[actualSize];
```
- 当然，这段代码并没有完全解决运行时动态更改数组的问题。一旦确定了数组的大小，改变它就不太容易了。在Java 中，解决这个问题最简单的方法是使用 Java中另外一个被称为 ArrayList 的类。它使用起来有点像数组，但在添加或删除元素时，具有自动调节数组容量的功能，而不需要为此编写任何代码。
- ArrayList 是一个采用**类型参数（type parameter）**的**泛型类（generic class）**。下面声明和构造一个保存Employee 对象的数组列表：
- ` ArrayList<Employee> staff = new ArrayList<Employee>();`
- 两边都使用类型参数 Employee，这有些繁琐。Java7 中，可以省去右边的类型参数：
- ` ArrayList<Employee> staff = new ArrayList<>();`
- Java SE 5.0 以前的版本没有提供泛型类，而是有一个ArrayList 类，其中保存类型为 Object 的元素，它是“自适应大小”的集合。
- 使用 add 方法可以将元素添加到数组列表中。例如：
```
  staff.add(new Employee("Harry Hacker",...));
  staff.add(new Employee("Tony Tester",...));
```
- 数组列表管理着对象引用的一个内部数组。最终，数组的全部空间有可能被用尽。这就显示出数组列表的操作魅力了：如果调用add 且内部数组已经满了，数组列表就将自动地创建一个更大的数组，并将所有的对象从较小的数组中拷贝到较大的数组中。
- 如果已经清楚或能够估计出数组可能存储的元素数量，就可以在填充数组之前调用 ensureCapacity 方法：
- ` staff.ensureCapacity(100);`
- 这个方法调用将分派一个包含 100 个对象的内部数组。然后调用100次add，而不用重新分派空间。
- 另外，还可以把初始容量传递给 ArrayList 构造器：
- ` ArrayList<Employee> staff = new ArrayList<>(100);`
- 注意：分配数组列表，如下：
```
  new ArrayList<>(100);  // capacity is 100
  new Employee[100];     // size is 100
```
- 数组列表的容量与数组的大小有一个非常重要的区别。如果为数组分配100 个元素的存储空间，数组就有了100 个空位置可以使用。而容量为 100个元素的数组列表只是拥有保存 100 个元素的潜力（实际上，重新分配空间的话，将会超过100 ），但是在最初，甚至完成初始化构造之后，数组列表根本就不含有任何元素。
- size 方法将返回数组列表中包含的实际元素数目。例如： 
- staff.size()
- 将返回staff 数组列表的当前元素数量，它等价于数组a 的 a.length。
- 一旦能够确认数组列表的大小不再发生变化，就可以调用 trimToSize 方法。这个方法将存储区域的大小调整为当前元素数量所需要的存储空间数目。垃圾回收器将回收多余的存储空间。
- 一旦整理了数组列表的大小，添加新元素就需要花时间再次移动存储块，所以应该在确认不会添加任何元素时，再调用 trimToSize。
- API: java.util.ArrayList<T>
- ` ArrayList<T>()`
- ` ArrayList<T>(int initialCapacity)`
- ` boolean add(T obj)`
> 在 数组列表的尾端添加一个元素。永远返回true 
- ` int size()`
> 返回 存储在数组列表中的当前元素数量。（这个值将小于或等于数组列表的容量。） 
- ` void ensureCapacity(int capacity)`
> 确保 数组列表在不重新分配存储空间的情况下就能够保存给定数量的元素。 
- ` void trimToSize()`  
> 将数组列表的存储容量削减到当前尺寸。
>   
### 5.3.1 访问数组列表元素
- 很遗憾，天下没有免费的午餐。数组列表自动扩展容量的便利性增加了访问元素语法的复杂程度。其原因是 ArrayList 类并不是 Java程序设计语言的一部分；它只是一个由某些人编写且被放在标准库中的一个实用类。
- 使用 get 和 set 方法实现访问或改变数组元素的操作，而不使用人们喜爱的 [ ] 语法格式。
- 例如，要设置第 i 个元素，可以使用：
- ` staff.set(i, harry);`
- 它等价于对数组 a 的元素赋值（数组的下标从 0 开始）
- ` a[i] = harry;` 
- 注意：只有 i 小于或等于数组列表的大小时，才能够调用 list.set(i, x)。例如，下面这段代码是错误的：

```
  ArrayList<Employee> list = new ArrayList<>(100); // capacity 100, size 0
  list.set(0, x);                                  // no element 0 yet
```
- 使用 add 方法为数组添加新元素，而不要使用 set 方法，它只能替换数组中已经存在的元素内容。
- 使用 下列格式获得数组列表的元素：
- ` Employee e = staff.get(i);`
- 等价于
- ` Employee e = a[i]`;
- 注意：没有泛型类时，原始的 ArrayList 类提供的get 方法别无选择只能返回 Object，因此，get 方法的调用者必须对返回值进行类型转换：
- ` Employee e = (Employee) staff.get(i);`
- 原始的 ArrayList 存在一定的危险性。它的add 方法和 set 方法允许接受任意类型的对象。对于下面这个调用
- ` staff.set(i, new Date());`
- 编译不会给出任何警告，只有在检索对象并试图对它进行类型转换时，才会发现有问题。如果使用 ArrayList<Employee> ，编译器就会检测到这个错误。
- 下面这个技巧可以一举两得，既可以灵活地扩展数组，又可以方便地访问数组元素。首先，创建一个数组列表，并添加所有的元素。

```
  ArrayList<X> list = new ArrayList<>();
  while(...){
    x = ...;
    list.add(x);
  }
```
- 执行完上述操作后，使用 toArray 方法将数组列表元素拷贝到一个数组中。
```
  x[] a = new X[list.size()];
  list.toArray(a);
```
- 除了在数组列表的尾部追加元素之外，还可以在数组列表的中间插入元素，使用带索引参数的 add 方法。
```
  int n = staff.size()/2;
  staff.add(n, e);
```
- 为了插入一个新元素，位于 n 之后的所有元素都要向后移动一个位置。如果插入新元素后，数组列表的大小超过了容量，数组列表就会重新分派存储空间。
- 同样地，可以从数组列表中间删除一个元素。
- ` Employee e = staff.remove(n);`
- 位于这个位置之后的所有元素都向前移动一个位置，并且数组的大小减 1.
- 对数组实施插入和删除元素的操作效率比较低。对于小型数组来说，这一点不必担心。但如果数组存储的元素数比较多，又经常需要在中间位置插入、删除元素，就应该考虑使用链表了。
- 可以使用 “for each” 循环遍历数组列表：
```
  for (Employee e : staff)
    do something with e
```
- 这个循环和下列代码有相同的效果
```
  for (int i = 0; i < staff.size(); i++){
    Employee e = staff.get(i);
    do something with e
  }
```
- [ArrayListTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/arrayList/ArrayListTest.java) 将 Employee [] 数组替换成了 ArrayList<Employee>。请注意下面的变化：
- 不必指出数组的大小。
- 使用 add 将任意多的元素添加到数组中。
- 使用 size() 替换 length 计算元素的数目。
- 使用 a.get(i) 替代 a[i] 访问元素。
- API: java.util.ArrayList<T>    index 位置（必须介于 0 ~ size()-1 之间）
- void set (int index, T obj)   
> 设置数组列表指定位置的元素值，这个操作将覆盖这个位置的原有内容。       
- T get (int index)
> 获取指定位置的元素值
- void add (int index, T obj)
> 向后移动元素，以便插入元素
- T remove (int index )  
> 删除一个元素，并将后面的元素向前移动。被删除的元素由返回值返回。
> 
### 5.3.2 类型化 与 原始数组列表的兼容性
- 鉴于兼容性的考虑，编译器在对类型转换进行检查之后，如果没有发现违反规则的现象，就将所有的类型化数组列表转换成原始 ArrayList 对象。在程序运行时，所有的数组列表都是一样的，即没有虚拟机中的类型参数。
> 
### 5.4 对象包装器与自动装箱
- 有时，需要将int这样的基本类型转换为对象。所有的基本类型都有一个与之对应的类。例如，Integer 类对应基本类型int。通常，这些类称为**包装器（wrapper）**。这些包装器类拥有很鲜明的名字：Integer、Long、Float、Double、Short、Byte、Character、Void 和 Boolean （前6个类派生于公共的超类 Number）。对象包装器类是不可变的，即一旦构造了包装器，就不允许更改包装在其中的值。同时，对象包装器类还是final，因此不能定义它们的子类。
- 假设想定义一个整型数组列表。而尖括号中的类型参数不允许是基本类型，也就是说，不允许写成 ArrayList<int>。这里就用到了 Integer 对象包装类。我们可以声明一个 Integer 对象的数组列表。
- ` ArrayList<Integer> list = new ArrayList<>();`
- 警告：由于每个值分别包装在对象中，所以 ArrayList<Integer> 的效率远远低于 int[] 数组。因此，应该用它构造小型集合，其原因是此时程序员操作的方便性要远比执行效率更加重要。
-  Java SE 5.0 的另一个改进之处是更加便于添加或获得数组元素。下面这个调用
- ` list.add(3);`
- 将自动地变换成
- ` list.add(Integer.valueOf(3));`
- 这种变换被称为自动装箱（autoboxing）。
- 相反地，当将一个 Integer 对象赋给一个int 值时，将会自动地拆箱。也就是说，编译器将下列语句：
- ` int n = list.get(i);`
- 翻译成  
- ` int n = list.get(i).intValue;`  
- 甚至在算术表达式中也能够自动地装箱和拆箱。例如，可以将自增操作符应用于一个包装器引用：
```
   Integer n = 3;
   n++;
``` 
- 编译器将自动地插入一条对象拆箱的指令，然后进行自增运算，最后再将结果装箱。
- 在很多情况下，容易有一种假象，即基本类型与他们的对象包装器是一样的，只是他们的相等性不同。== 运算符也可以应用于对象包装器对象，只不过检测的是对象是否指向同一个存储区域，因此，下面的比较**通常**不会成立：
```
  Integer a = 1000;
  Integer b = 1000;
  if (a == b) ...
```
- 然而，Java实现却有**可能（may）**让它成立。如果将经常出现的值包装到同一个对象中，这种比较就有可能成立。这种不确定的结果并不是我们所希望的。解决这个问题的办法是在两个包装器比较对象时调用 equals 方法。
- 自动装箱规范要求 boolean、byte、char<=127，介于 -128 ~ 127之间的short 和 int 被包装到固定的对象中。例如，前面的例子中将 a 和 b 初始化为 100，对它们进行比较的结果一定成立。
> 
- 强调 ：装箱和拆箱是**编译器**认可的，而不是虚拟机。编译器在生成类的字节码时，插入必要的方法调用。虚拟机只是执行这些字节码。 
- 使用数值对象包装器还有另外一个好处。可以将某些基本方法放置在包装器中，例如，将一个数字字符串转换成数值。
- 要想将字符串转换成整型，可以使用
- ` int x = Integer.parseInt(s);`  
- 这里与Integer 对象没有任何关系，parseInt 是一个静态方法。但 Integer类是放置这个方法的一个好地方。
- API: java.lang.Integer 1.0
- ` int intValue()`
> 以 int 的形式返回Integer 对象的值
- ` static String toString(int i)`
> 以 一个新String 对象的形式返回给定数值i 的十进制表示
- ` static String toString(int i, int radix)`
> 返回 数值i 的基于给定 radix 参数进制的表示
- ` static int parseInt(String s)`
> 返回 字符串s 表示的整型数值，给定字符串表示的是十进制的整数
- ` static int parseInt(String s, int radix)`
> 返回 字符串s 表示的整型数值，给定字符串是radix 参数进制的整数
- ` static Integer valueOf(String s)`
> 返回 用s表示的整型数值进行初始化的一个新 Integer对象，给定字符串表示的是十进制的整数 
- ` static Integer valueOf(String s, int radix)` 
> 返回 用s表示的整型数值进行初始化的一个新 Integer对象，给定字符串表示的是 radix参数 进制的整数   
- API: java.text.NumberFormat 1.1
- ` Number parse(String s)`  
> 返回 数字值，假设给定的 String 表示了一个数值。
>   
### 5.5 参数数量可变的方法 
- 在 JavaSE 5.0 以前的版本中，每个Java方法都有固定数量的参数。然而，现在的版本提供了可以用可变的参数数量调用的方法。
- 例如：  printf。
- ` System.out.printf("%d", n);`
- 和 
- ` System.out.printf("%d %s", n, "widgets");`
- 在上面两条语句中，尽管一个调用包含两个参数，另一个调用包含三个参数，但它们调用的都是同一个方法。printf 方法是这样定义的：
```
  public class PrintStream{
    public PrintStream printf(String fmt, Object... args){
      return format(fmt, args);
    };
  }
```  
- 这里的省略号 ... 是Java代码的一部分，它表明这个方法可以接收任意数量的对象（除 fmt 参数之外）。
- 实际上，printf 方法接收两个参数，一个是格式字符串，另一个是 Object[] 数组，其中保存着所有的参数（如果调用者提供的是整型数组或者其他基本类型的数组，自动装箱功能将把它们转换成对象）。现在将扫描 fmt 字符串，并将第 i 个格式说明符与args[i]的值匹配起来。
- 用户自己也可以定义可变参数的方法，并将参数指定为任意类型，甚至是基本类型。下面是一个简单的实例：其功能为计算若干个数值的最大值。
```
  public static double max(double... values){
    double largest = Double.MIN_VALUE;
    for (double v : values) if (v > largest) largest = v;
    return largest;
  }
```
- 可以像下面这样调用这个方法：
- ` double m = max(3.1, 40.4, -5);`
- 编译器将 new double[]{3.1, 40.4, -5} 传递给 max 方法。

### 5.6 枚举类
- 定义枚举类型。下面是一个典型的例子：
- ` public enum Size { SMALL, MEDIUM, LARGE, EXTRA_LARGE}; `
- 实际上，这个声明定义的类型是一个类，它刚好有四个实例。
- 在比较两个枚举类型的值时，永远不需要调用equals ，而直接使用 “==” 就可以了。
- 如果需要的话，可以在枚举类型中添加一些构造器、方法和域。当然，构造器只是在构造枚举常量的时候被调用。下面是一个示例：
```
  public enum Size{
    SMALL("S"), MEDIUM("M"), LARGE("L"), EXTRA_LARGE("XL");
    
    private String abbreviation;
    
    private Size(String abbreviation){ this.abbreviation = abbreviation; }
    public String getAbbreviation(){ return abbreviation;}
  }
```
- 所有的枚举类型都是Enum 类的子类。它们继承了这个类的许多方法。其中最有用的一个是 toString，这个方法能够返回枚举类的常量名。例如，Size.SMALL.toString() 将返回字符串 “SMALL”。
- toString 的逆方法是静态方法 valueOf。例如：语句
- ` Size s = Enum.valueOf(Size.class, "SMALL");`
- 将 s 设置成 Size.SMALL。
- 每个枚举类型都有一个静态的 values 方法，它将返回一个包含全部枚举值的数组。例如，如下调用
- ` Size[] values = Size.values();`
- 返回包含元素 Size.SMALL, Size,MEDIUM, Size.LARGE 和 Size.EXTRA_LARGE 的数组。
- ordinal 方法返回 enum 声明中枚举常量的位置，位置从 0 开始计数。例如：Size.MEDIUM.ordinal() 返回 1。
- [EnumTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/enums/EnumTest.java) 演示枚举类型的工作方式。
- API: java.lang.Enum<E> 5.0
- static Enum valueOf(Class enumClass , String name)
> 返回 指定名字、给定类的枚举常量
- String toString()
> 返回 枚举常量名 
- int ordinal()
> 返回 枚举常量在 enum 声明中的位置，位置从 0 开始计数
- int compareTo(E other)  
> 如果 枚举常量出现在 other 之前，则返回一个负数；如果 this==other，则返回 0；否则，返回正值。
> 
  
## 5.7 反射（reflect）
- **反射库（reflection library）**提供了一个非常丰富且精心设计的工具集，以便编写能够动态操纵Java代码的程序。这项功能被大量应用于JavaBeans中，她是Java组件的体系结构（有关 JavaBeans 的详细内容在卷 2 中）。使用反射，Java 可以支持 Visual Basic 用户习惯使用的工具。特别是在设计或运行中添加新类时，能够快速地应用开发工具动态地查询新添加类的能力。
- 能够分析类能力的程序称为**反射（reflective）**。反射机制的功能及其强大，在下面可以看到，反射机制可以用来：
1. 在运行中分析类的能力。
2. 在运行中查看对象，例如，编写一个toString方法供所有类使用。
3. 实现通用的数组操作代码。
4. 利用Method 对象，这个对象很像C++ 中的函数指针。
- 反射是一种功能强大且复杂的机制。使用它的主要人员是工具构造者，而不是应用程序员。
### 5.7.1 Class 类
- 在程序运行期间，Java 运行时系统始终为所有的对象维护一个被称为运行时的类型标识。这个信息跟踪每个对象所属的类。虚拟机利用运行时类型信息选择相应的方法执行。
- 然而，可以通过专门的 Java 类访问这些信息。保存这些信息的类被称为 Class，这个名字很容易让人混淆。Object 类中的 getClass() 方法返回一个Class 类型的实例。
```
  Employee e;
  ...
  Class cl = e.getClass();
```
- 如同用一个 Employee 对象表示一个特定的雇员属性一样，一个Class 对象将表示一个特定类的属性。最常用的Class 方法是 getName。这个方法将返回类的名字。例如，下面这条语句：
- ` System.out.println(e.getClass().getName() + " " + e.getName());`
- 如果 e 是一个雇员，则打印 Employee Harry Hacker
- 如果 e 是一个经理，则打印 Manager Harry Hacker
- 如果类在一个包里，包的名字也作为类名的一部分：
```
  Date d = new Date();
  Class cl = d.getClass();
  String name = cl.getName();  // name is set to "java.util.Date"
```
- 还可以调用静态方法 forName 获得类名对应的 Class 对象。
```
  String name = "java.util.Date";
  Class cl = Class.forName(className);
```
- 如果类名保存在字符串中，并可在运行中改变，就可以使用这个方法。当然，这个方法只有在 className 是类名或接口名时才能执行。否则，forName 方法将抛出一个 checked exception（已检查异常）。无论何时使用这个方法，都应该提供一个 **异常处理器（exception handler）。**
- 在启动时，包含main 方法的类被加载。它会加载所有需要的类。这些被加载的类又要加载它们需要的类，以此类推。对于一个大型的应用程序来说，这将会消耗很多时间，用户因此会感到不耐烦。可以使用下面这个技巧给用户一种启动速度比较快的幻觉。不过，要确保包含 main 方法的类没有显式地引用其他的类。首先，显式一个启动画面；然后，通过调用 Class.forName 手工地加载其他的类。
- 获得 Class 类对象的第三种方法非常简单。如果 T 是任意的Java类型，T.class 将代表匹配的类对象。例如：
```
  Class cl1 = Date.class;   // if you import java.util.*;
  Class cl2 = int.class;
  Class cl3 = Double[].class;
```
- 注意，一个Class 对象实际上表示的是一个类型，而这个类型未必一定是一种类。例如，int 不是类，但 int.class 是一个Class 类型的对象。
- 虚拟机为每个类型管理一个 Class 对象。因此，可以利用 == 运算符实现两个类对象比较的操作。例如
- ` if (e.getClass() == Employee.class)...`
- 还有一个很有用的方法 newInstance()，可以快速用来创建一个类的实例。例如，
- ` e.getClass().newInstance();`
- 创建了一个与 e 相同类类型的实例。newInstance 方法调用默认的构造器（没有参数的构造器）初始化新创建的对象。如果这个类没有默认的构造器，就会抛出一个异常。
- 将 forName 与 newInstance 配合使用，可以根据存储在字符串中的类名创建一个对象。
```
  String s = "java.util.Data";
  Object m = Class.forName(s).newInstance();
```
> 
### 5.7.2 捕获异常
- 当程序运行过程中发生错误时，就会“抛出异常”。抛出异常比终止程序要灵活得多，这是因为可以提供一个“捕获”异常的**处理器（handler）**对异常情况进行处理。
- 如果没有提供处理器，程序就会终止，并在控制台上打印出一条信息，其中给出了异常的类型。
- 异常有两种类型：**未检查**异常和**已检查**异常。对于已检查异常，编译器将会检查是否提供了处理器。然而，有很多常见的异常，例如，访问null 引用，都属于未检查异常。编译器不会查看是否为这些错误提供了处理器。毕竟，应该精心编写代码来避免这些错误的发生，而不要将精力花在编写异常处理器上。
- 并不是所有的错误都是可以避免的。如果竭尽全力还是发生了异常，编译器就要求提供一个处理器。 Class.forName 方法就是一个抛出已检查异常的例子。后面有几种异常处理的策略。现在，只介绍一下如何实现最简单的处理器。
- 将可能抛出已检查异常的一个或多个方法调用代码放在 try 块中，然后在 catch 字句中提供处理器代码。
```
  try{
    statements that might throw exceptions
  } catch (Exception e){
    handler action
  }
```
- 下面是一个示例：
```
  try{
    String name = ...;  // get class name
    Class cl = Class.forName(name);  // might throw exception
    do something with cl
  } catch ( Exception e){
    e.printStackTrace();
  }
```
- 如果类名不存在，则将跳过 try 块中的剩余代码，程序直接进入 catch 子句（这里，利用 Throwable 类的 printStackTrace 方法打印栈的轨迹。 Throwable 是 Exception 类的超类）。如果 try 块中没有抛出任何异常，那么会跳过 catch 子句的处理器代码。
- 对于已检查异常，只需要提供一个异常处理器。可以很容易地发现会抛出已检查异常的方法。如果调用了一个抛出已检查异常的方法，而又没有提供处理器，编译器就会给出错误报告。
- API: java.lang.Class 1.0
- static Class forName(String className)
> 返回描述类名为 className 的 Class 对象
- Object newInstance()
> 返回这个类的一个新实例
- API: java.lang.reflect.Constructor 1.1
- Object newInstance(Object[] args)
> 构造一个这个构造器所属类的新实例
- API: java.lang.Throwable 1.0
- void printStackTrace()
> 将 Throwable 对象和栈的轨迹输出到标准错误流。
> 

### 5.7.3 利用反射分析类的能力
#### 反射机制最重要的内容——检查类的结构
- 在 java.lang.reflect 包中有三个类 Field、 Method 和 Constructor 分别用于描述类的 域、方法 和 构造器。这三个类都有一个叫做 getName 的方法，用来返回项目的名称。 Field 类有一个getType 方法，用来返回描述域所属类型的 Class 对象。Method 和 Constructor 类有能够报告参数类型的方法，Method 类还有一个可以报告返回类型的方法。这三个类还有一个叫做 getModifiers 的方法，它将返回一个整型数值，用不同的位开关描述public 和 static 这样的修饰符使用状况。另外，还可以利用 java.lang.reflect 包中的 Modifier 类的静态方法分析 getModifiers 返回的整型数值。例如，可以使用 Modifier 类中的 isPublic、isPrivate 或 isFinal 判断方法或构造器是否是 public、private 或 final 。我们需要做的全部工作就是调用 Modifier 类的响应方法，并对返回的整型数值进行分析，另外，还可以利用 Modifier.toString 方法将 修饰符打印出来。
- Class 类中的 getFields    、getMethods    和 getConstructors 方法将分别返回类提供的 public域、方法 和 构造器数组，其中包括超类的公有成员。
- Class 类中的 getDeclareFields、getDeclareMethods 和 getDeclareConstructors 方法将分别返回类中声明的全部域、方法和构造器，其中包括私有和受保护成员，但不包括超类的成员。
- [ReflectionText.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/reflection/ReflectionTest.java) 显示了如何打印一个类的全部信息方法。这个程序将提醒用户输入类名，然后输出类中所有的方法和构造器的签名，以及全部域名。
- 值得注意的是：这个程序可以分析Java 解释器能够加载的任何类，而不仅仅是编译程序时可以使用的类。
- API: java.lang.Class 1.0
- Field[] getFields()
- Field[] getDeclaredFields()
> getFields 方法将返回一个包含 Field 对象的数组，这些对象记录了这个类或其超类的公有域。getDeclaredFiedld 方法也将返回包含 Field 对象的数组，这些对象记录了这个类的全部域。如果类中没有域，或者 Class 对象描述的类型是基本类型或数组类型，这些方法将返回一个长度为0的数组。
- Method[] getMethods()
- Method[] getDeclaredFields()
> 返回包含 Method 对象的数组：getMethods 将返回所有的公有方法，包括从超类继承来的公有方法；getDeclaredMethods 返回这个类或接口的全部方法，但不包括由超类继承了的方法。
- Constructor[] getConstructors()
- Constructor[] getDeclaredConstructors()
> 返回包含Constructor 对象的数组，其中包含了Class 对象所描述的类的所有公有构造器（getConstructors） 或 所有构造器（getDeclaredConstructors）。
> 
- API: java.lang.reflect.Field
- API: java.lang.reflect.Method
- API: java.lang.reflect.Constructor
- Class getDeclaringClass()
> 返回一个用于描述类中定义的构造器、方法或域的 Class对象
- Class[] getExceptionTypes()（在Constructor 和 Method 类中）
> 返回一个用于描述方法抛出的异常类型的Class 对象数组
- int getModifiers()
> 返回一个用于描述构造器、方法或域 的修饰符的整型数值。使用 Modifier 类中的这个方法可以分析这个返回值
- String getName()
> 返回一个用于描述构造器、方法或域名的字符串
- Class[] getParameterTypes()（在 Constructor 和 Method 类中）
> 返回一个用于描述参数类型的 Class 对象数组
- Class getReturnType()（在Method 类中）
> 返回一个用于描述返回类型的 Class 对象
> 
- API: java.lang.reflect.Modifier 1.1 
- static String toString( int modifiers)
> 返回对应 modifiers 中位设置的修饰符的字符串表示。
- static boolean isAbstract(int modifiers)
- static boolean isFinal(int modifiers)
- static boolean isInterface(int modifiers)
- static boolean isNative(int modifiers)
- static boolean isPrivate(int modifiers)
- static boolean isProtected(int modifiers)
- static boolean isPublic(int modifiers)
- static boolean isStatic(int modifiers)
- static boolean isStrict(int modifiers)
- static boolean isSynchronized(int modifiers)
- static boolean isVolatile(int modifiers)
> 这些方法将检测方法名中对应的修饰符在 modifiers 值中的位。
### 5.7.4 在运行时使用反射分析对象
- 如何查看任意对象的数据域名称和类型：
- 获得对应的Class 对象。
- 通过Class 对象调用 getDeclaredFields
- 本节将进一步查看数据域的实际内容。当然，在编写程序时，如果知道想要查看的域名和类型，查看指定的域是一件很容易的事情。而利用反射机制可以查看在编译时还不清楚的对象域。
- 查看对象域的关键方法是Field 类中的get 方法。如果 f 是一个Field 类型的对象（例如，通过 getDeclaredFields 得到的对象），obj 是某个包含 f域的类的对象，f.get(obj) 将返回一个对象，其值为 obj 域的当前值。这样说起来有点抽象，看一看下面这个示例：
```
  Employee harry = new Employee("Harry Hacker", 35000, 10, 1, 1989);
  Class cl = harry.getClass();
    // the class object representing Employee
  Field f = cl.getDeclaredField("name");
    // the name field of the Employee class
  Object v = f.get(harry);
    // the value of the name field of the harry object,i.e., the String object "Harry Hacker"
```
- 实际上，这段代码存在一个问题。由于name 是一个私有域，所以 get 方法将会抛出一个 IllegalAccessException。只有利用 get方法才能得到可访问域的值。除非拥有访问权限，否则Java 安全机制只允许查看任意对象有哪些域，而不允许读取它们的值。
- 反射机制的默认行为受限于 Java的访问控制。然而，如果一个 Java程序没有受到安全管理器的机制，就可以覆盖访问控制。为了达到这个目的，需要调用 Field、Method 或 Constructor 对象的 setAccessible 方法。例如，
- ` f.setAccessible(true);`   // now OK to call f.get(harry);
- setAccessible 方法是 AccessibleObject 类中的一个方法，它是 Field、Method 和 Constructor 类的公共超类。这个特性是为了调试、持久存储和相似机制提供的。稍后将利用它编写一个通用的 toString 方法。
- get 方法还有一个需要解决的问题。name 域是一个String，因此把它作为 Object 返回没有什么问题。但是，假定我们想要查看 salary 域，它属于double 类型，而 Java中数值类型不是对象。要想解决这个问题，可以使用 Field类中的 getDouble 方法，也可以调用 get方法，此时，反射机制将会自动地将这个域值打包到相应的对象包装器中，这里讲打包成 Double。
- 当然，可以获得就可以设置。调用 f.set(obj, value) 可以将obj 对象的f 域设置成新值。
- 程序清单5-14 [ObjectAnalyzerTest](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/objectAnalyzer/ObjectAnalyzerTest.java) 显示了如何编写一个可供任意类使用的通用 toString 方法。其中使用 getDeclaredFields 获得所有的数据域，然后使用 setAccessible 将所有的域设置为可访问的。对于每个域，获得了名字和值。递归调用 toString 方法，将每个值转换成字符串。
- 循环引用将有可能导致无限递归。因此，[ObjectAnalyzer.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/objectAnalyzer/ObjectAnalyzer.java) 将记录已经被访问过的对象。另外，为了能够查看数组内部，需要采用一种不同的方式。
- 还可以使用通用的 toString 方法实现自己类中的toString 方法，如下：
```
  public String toString(){
    return new ObjectAnalyzer().toString(this);
  }
```
- 这是一种公认的提供toString 方法的手段，在编写程序时会发现，它是非常有用的。
- API: java.lang.reflect.AccessibleObject
- void setAccesssible(boolean flag)
> 为反射对象设置可访问标志。flag 为 true 表明屏蔽 Java语言的访问检查，使得对象的私有属性也可以被查询和设置。
- boolean is Accessible()
> 返回反射对象的可访问标志
- static void setAccessible(AccessibleObject[] array, boolean flag)
> 是一种设置对象数组可访问标志的快捷方法
- API: java.lang.Class
- Field getField(String name)
- Field[] getField()
> 返回指定名称的公有域、或 包含所有域的数组。
- Field getDeclaredField(String name)
- Field[] getDeclaredFields()
> 返回类中声明的给定名称的域，或者包含声明的全部域的数组
- API: java.lang.reflect.Field
- Object get(Object obj)
> 返回 obj 对象中用 Field 对象表示的域值
- void set(Object obj, Object newValue)
> 用一个新值设置 Obj对象中 Field 对象表示的域。
> 
### 5.7.5 使用反射编写泛型数组代码
- java.lang.reflect 包中的 Array 类允许动态地创建数组。例如，将这个特性应用到 Array 类中的 copyOf 方法实现中，这个方法用于扩展已经填满的数组。
```
  Employee[] a = new Employee[100];
  ...
  // array is full
  a = Arrays.copyOf(a, 2*a.length);
```
- 如何编写这样一个通用的方法？正好能够将 Employee[] 数组转换为 Object [] 数组，这让人感觉很有希望。下面进行第一次尝试。
```
  public static Object[] badCopyOf(Object[] a, int newLength){ // not useful
    Object[] newArray = new Object[newLength];
    System.arraycopy(a, 0, newArray, 0, Math.min(a.length, newLength));
    return newArray;
  }
```
- 然而，在实际**使用**结果数组时会遇到一个问题。这段代码返回的数组类型是对象数组（Object[]）类型，这是由于使用下面这行代码创建的数组：
- ` new Object[newLength]`
- 一个对象数组不能转换成雇员数组（Employee[]）。如果这样做，则在运行时 Java 将会产生 ClassCastException 异常。前面已经看到，Java 数组会记住每个元素的类型，即创建数组时 new 表达式中使用的元素类型。将一个 Employee[] 临时转换成 Object[] 数组，然后再把它转换回来是可以的，但一个从开始就是 Object[] 的数组却永远不能转换成 Employee[] 数组。为了编写这类通用的数组代码，需要能够创建与原数组类型**相同**的新数组。为此，需要 java.lang.reflect 包中 Array 类的一些方法。其中最关键的是 Array类中静态方法 newInstance，它能够构造新数组。在调用它时必须提供两个参数，一个是数组的元素类型，一个是数组的长度。
- ` Object newArray = Array.newInstance(componentType, newLength);`
- 为了能够实际地运行，需要获得新数组的长度和元素类型。
- 可以通过调用 Array.getLength(a) 获得数组的长度，也可以通过 Array 类的静态 getLength 方法的返回值得到任意数组的长度。而要获得新数组元素类型，就需要进行以下工作：
- 1）首先获得a 数组的类对象
- 2）确认它是一个数组
- 3）使用 Class 类（只能定义表示数组的类对象）的 getComponentType 方法确定对应的类型。
- 为什么 getLength 是 Array 的方法，而 getComponentType 是 Class 的方法呢？我们也不清楚。反射方法的分类有时确实显得有点古怪。
```
  public static Object goodCopyOf(Object a, int newLength){
    Class cl = a.getClass();
    if (!cl.isArray()) return null;
    Class componentType = cl.getComponentType();
    int length = Array.getLength(a);
    Object newArray = Array.newInstance(componentType, newLength);
    System.arraycopy(a, 0, newArray, 0, Math.min(length, newLength));
    return newArray;
  }
```
- 请注意，这个 CopyOf 方法可以用来扩展任意类型的数组，而不仅是对象数组。
```
  int[] a = {1, 2, 3, 4, 5};
  a = (int[])goodCopyOf(a, 10);
```
- 为了能够实现上述操作，应该将 goodCopyOf 的参数声明为 Object 类型，而不要声明为对象型数组（Object[]）。整型数组类型 int[] 可以被转换成 Object，但不能转换成对象数组。
- [CopyOfTest.java](https://github.com/Alex5Moon/notebooks/blob/master/CoreJavaVolume-I/v1ch05/arrays/CopyOfTest.java) 显示了两个扩展数组的方法。
> 
### 5.7.6 调用任意方法




























