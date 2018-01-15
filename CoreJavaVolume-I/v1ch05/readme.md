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
- 然而，不能讲一个超类的引用
#### 动态绑定
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










