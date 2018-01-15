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
- 在通过扩展超类定义子类的时候，仅需要指出子类与超类的**不同之处**。因此在设计类的时候，应该将通用的方法放在超类中，而将
- 在子类中可以增加域、增加方法或覆盖超类的方法，然而绝对不能删除继承的任何域和方法。
- 使用关键字super调用超类的方法。
1. 关键字 this  有两个用途：一是引用隐式参数，二是调用该类其他的构造器。
2. 关键字super也有两个用途：一是调用超类的方法，二是调用超类的构造器。
- 调用构造器的语句只能作为另一个构造器的第一条语句出现。
> 
> 一个对象变量可以指示多种实际类型的现象被称为**多态（polymorphism）**。
> 
> 在运行期能够自动地选择调用哪个方法的现象被称为**动态绑定（dynamic binding）**。
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










