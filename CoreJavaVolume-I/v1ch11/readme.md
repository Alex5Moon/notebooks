### 异常、断言、日志和调试
- 在理想状态下，用户输入数据的格式永远都是正确的，选择打开的文件也一定存在，并且永远不会出现bug。然而，现实世界中却充满了不良的数据和带有问题的代码，现在是讨论Java 程序设计语言处理这些问题的机制的时候了。
- 人们在遇到错误时会感觉不爽。如果一个用户在运行程序期间，由于程序的错误或一些外部环境的影响造成用户数据的丢失，用户就有可能不再使用这个程序了。为了避免这类事情的发送，至少应该做到以下几点：
- 1）向用户通告错误；
- 2）保存所有的工作结果；
- 3）允许用户以妥善的形式推出程序。
- 对于异常情况，例如，可能造成程序崩溃的错误输入，Java 使用一种称为**异常处理（exception handing）**的错误捕获机制处理。Java中的异常处理与C++ 或 Delphi 中的异常处理十分类似。本章的第 1 部分先介绍 Java的异常。
- 在测试期间，需要进行大量的检测以验证程序操作的正确性。然而这些检测可能非常耗时，在测试完成后也不必保留它们，因此，可以将这些检测删掉，并在其他测试需要时将他们粘贴回来，这是一件很乏味的事情。本章的第 2 部分将介绍如何使用断言来有选择地启用检测。
- 当程序出现错误时，并不总是能够与用户或终端进行沟通。此时，可能希望记录下出现的问题，以备日后进行分析。本章的第 3 部分将讨论标准 Java 日志框架。
- 最后，介绍如何获得一个正在运行的 Java应用程序的有用信息，以及如何使用IDE 中的调试器的技巧。

#### [11.1 处理错误](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch11/01.md)

#### [11.2 捕获异常](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch11/02.md)

#### [11.3 使用异常机制](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch11/03.md)

#### [11.4 使用断言](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch11/04.md)

#### [11.5 记录日志](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch11/05.md)

#### [11.6 调试技巧](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch11/06.md)

#### [11.8 使用调试器](https://github.com/lu666666/notebooks/blob/master/CoreJavaVolume-I/v1ch11/08.md)
