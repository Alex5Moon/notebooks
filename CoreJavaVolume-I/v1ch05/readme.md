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
### Object：所有类的超类

1. 编译器查看对象的声明类型和方法名。
2. 编译器查看调用方法时提供的参数类型。——>重载解析（overloading resolution）
> 至此，编译器已获得需要调用的方法名字和参数类型。
3. 如果是private方法、static方法、final方法或者构造器，那么编译器将可以准确地知道应该调用哪个方法。——>**静态绑定（static binding）**
4. 当程序运行，并且采用动态绑定调用方法时，虚拟机一定调用与x所引用对象的实际类型最合适的那个类的方法。
#### 在覆盖一个方法的时候，子类方法不能低于超类方法的可见性。特别是，如果超类方法是public，子类方法一定要声明为public。
#### 阻止继承：final类和方法
### Object类：所有类的超类
> Object类是Java中所有类的始祖，在Java中每个类都是由它扩展而来的。
#### equals方法 hashCode方法 toString方法  --->程序5-8
- Java语言规范要求equals方法具有下面的特性：
1. 自反性：对于任何非空引用x，x.equals(x)应该返回true。
2. 对称性：对于任何引用x和y，y.equals(x)返回true<=>x.equals(y)返回true。
3. 传递性：
4. 一致性：如果x和y引用的对象没有发生变化，反复调用x.equals(y)应该返回同样的结果。
5. 对于任意非空引用x，x.equals(null)应该返回false。
- **散列码（hash code）**是由对象导出的一个整型值。散列码是没有规律的。
1. String类使用下列算法计算散列码：
```
int hash = 0;
for(int i=0; i<length(); i++)
  hash = 31*hash + charAt(i);
```
2. 由于hashCode方法定义在Object类中，因此每个对象都有一个默认的散列码，其值为对象的存储地址。
- 强烈建议为自定义的每一个类增加toString方法。
### 泛型数组列表
- ArrayList是一个采用**类型参数（type parameter）**的**泛型类（generic class）**。
- 将Employee[] 数组替换成了 ArrayList<Employee>,请注意下面的变化:
1. 不必指出数组的大小。
2. 使用add 将任意多的元素添加到数组中。
3. 使用size() 替代length 计算元素的数目。
4. 使用a.get(i) 替代a[i] 访问元素。
### 对象包装器与自动装箱
- 有时，需要将int这样的基本类型转换为对象。
- 所有的基本类型都有一个与之对应的类。通常，这些类称为**包装器（wrapper）**。
- Integer、Long、Float、Double、Short、Byte、Character、Void 和 Boolean （前6个类派生于公共的超类 Number）
> 对象包装器类是不可变的，即一旦构造了包装器，就不允许更改包装在其中的值。同时，对象包装器类还是final，因此不能定义它们的子类。
- 自动装箱（autoboxing）
> list.add(3); ——> list.add(Integer.valueOf(3));
- 自动拆箱
> int n = list.get(i);——> int n = list.get(i).intValue();

## 反射（reflect）
> 反射库（reflection library）提供了一个非常丰富且精心设计的工具集，以便编写能够动态操纵Java代码的程序。
> 这项功能被大量应用于JavaBeans中，她是Java组件的体系结构。
- 能够分析类能力的程序称为反射（reflective）。反射机制的功能及其强大，可以用来：
1. 在运行中分析类的能力。
2. 在运行中查看对象，例如，编写一个toString方法供所有类使用。
3. 实现通用的数组操作代码。
4. 利用Method 对象，这个对象很像C++ 中的函数指针。










