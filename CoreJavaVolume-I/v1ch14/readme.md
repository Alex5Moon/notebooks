### 14 多线程
- 读者可能已经很熟悉操作系统中的**多任务**（multitasking）：在同一时刻运行多个程序的能力。例如，在编辑或下载邮件的同时可以打印文件。今天，人们很可能有单台拥有多个CPU的计算机，但是，并发执行的进程数目并不是由CPU数目制约的。操作系统将CPU的时间片分配给每一个进程，给人并行处理的感觉。
- 多线程程序在较低的层次上扩展了多任务的概念：一个程序同时执行多个任务。通常，每一个任务称为一个**线程**（thread），它是线程控制的简称。可以同时运行一个以上线程的程序称为**多线程程序**（multithread）。
- 那么，**多线程**与**多进程**有哪些区别呢？本质的区别在于每个进程拥有自己的一整套变量，而线程则共享数据。这听起来似乎有些风险，的确也是这样，在本章的稍后将看到这个问题。然而，共享变量使线程之间的通信比进程之间的通信更有效、更容易。此外，在有些操作系统中，与进程相比较，线程更“轻量级”，创建、撤销一个线程比启动新进程的开销要小得多。
- 在实际应用中，多线程非常有用。例如，一个浏览器可以同时下载几幅图片。一个Web服务器需要同时处理几个并发的请求。图形用户界面（GUI）程序用一个独立的线程从宿主操作环境中收集用户界面的事件。本章将介绍如何为Java应用程序添加多线程能力。
- **温馨提示**：多线程可能会变得相当复杂。本章涵盖了应用程序可能需要的所有工具。尽管如此，对于更复杂的系统级程序设计，建议参看更高级的参考文献，例如：Brian Goetz 的 《Java Concurrency in Practice》。

#### [14.1 什么是线程](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/01.md)

#### [14.2 中断线程](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/02.md)

#### [14.3 线程状态](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/03.md)

#### [14.4 线程属性](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/04.md)

#### [14.5 同步](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/05.md)

#### [14.6 阻塞队列](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/06.md)

#### [14.7 线程安全的集合](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/07.md)

#### [14.8 Callable与Future](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/08.md)

#### [14.9 执行器](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/09.md)

#### [14.10 同步器](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/10.md)

#### [14.11 线程与Swing](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch14/11.md)

