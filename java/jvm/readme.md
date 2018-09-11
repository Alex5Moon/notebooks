### 深入理解Java虚拟机:JVM高级特性与最佳实践
>
- 围绕内存管理、执行子系统、编程编译与优化、高效并发等核心内容对JVM进行全面而深入的分析，深刻揭示JVM的工作原理；注重实现，以解决实践中的疑难问题为首要目的，包含大量经典案例和最佳实践。
>
#### 第一部分
- 从宏观的角度介绍了整个Java技术体系的过去、现在和未来，以及如何独立地编译一个OpenJDK7，这对理解后面的内容很有帮助。
>
- [走近Java](https://github.com/lu666666/notebooks/blob/master/java/jvm/01/readme.md)
>
#### 第二部分
- 讲解了JVM的自动内存管理，包括虚拟机内存区域的划分原理以及各种内存溢出异常产生的原因；常见的垃圾收集算法以及垃圾收集器的特点和工作原理；常见的虚拟机的监控与调试工具的原理和使用方法。
>
- [Java内存区域与内存溢出异常](https://github.com/lu666666/notebooks/blob/master/java/jvm/02/readme.md)
>
- [垃圾收集器与内存分配策略](https://github.com/lu666666/notebooks/blob/master/java/jvm/03/readme.md)
>
- [虚拟机性能监控与故障处理工具](https://github.com/lu666666/notebooks/blob/master/java/jvm/04/readme.md)
>
- [调优案例分析与实战](https://github.com/lu666666/notebooks/blob/master/java/jvm/05/readme.md)
>
#### 第三部分
- 分析了虚拟机的执行子系统，包括Class的文件结构以及如何存储和访问Class中的数据；虚拟机的类创建机制以及类加载器的工作原理和它对虚拟机的意义；虚拟机字节码的执行引擎以及它在实行代码时涉及的内存结构。
>
- [类文件结构](https://github.com/lu666666/notebooks/blob/master/java/jvm/06/readme.md)
>
- [虚拟机类加载机制](https://github.com/lu666666/notebooks/blob/master/java/jvm/07/readme.md)
>
- [虚拟机字节码执行引擎](https://github.com/lu666666/notebooks/blob/master/java/jvm/08/readme.md)
>
- [类加载及执行子系统的案例与实战](https://github.com/lu666666/notebooks/blob/master/java/jvm/09/readme.md)
>
#### 第四部分
- 讲解了程序的编译与代码的优化，阐述了泛型、自动装箱拆箱、条件编译等语法糖的原理；讲解了虚拟机的热点探测方法、HotSpot的即时编译器、编译触发条件，以及如何从虚拟机外部观察和分析JIT编译的数据和结果。
>
- [早期（编译期）优化](https://github.com/lu666666/notebooks/blob/master/java/jvm/10/readme.md)
>
- [晚期（运行期）优化](https://github.com/lu666666/notebooks/blob/master/java/jvm/11/readme.md)
>
#### 第五部分
- 探讨了Java实现高效并发的原理，包括JVM内存模型的结构和操作；原子性、可见性和有序性在Java内存模型中的体现；先行发生原则的规则和使用；线程在Java语言中的实现原理；虚拟机实现高效并发所做的一系列锁优化措施。
>
- [Java内存模型与线程](https://github.com/lu666666/notebooks/blob/master/java/jvm/12/readme.md)
>
- [线程安全与锁优化](https://github.com/lu666666/notebooks/blob/master/java/jvm/13/readme.md)
>
