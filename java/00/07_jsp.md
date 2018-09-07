### JSP
- 在Servlet中编写一些HTML代码，是很不方便的一件事情，每次都需要out.println(HTML); 因此就出现了JSP，来解决这样的问题，JSP中的内容就是html，但是能够嵌套java语言，
- JSP全名为Java Server Pages，中文名叫java服务器页面，其根本是一个简化的Servlet设计，它是由Sun Microsystems公司倡导、许多公司参与一起建立的一种动态网页技术标准。
- JSP技术有点类似ASP技术，它是在传统的网页HTML（标准通用标记语言的子集）文件(*.htm,*.html)中插入Java程序段(Scriptlet)和JSP标记(tag)，从而形成JSP文件，后缀名为(*.jsp)。
- 它实现了Html语法中的java扩展（以 <%, %>形式）。JSP与Servlet一样，是在服务器端执行的。通常返回给客户端的就是一个HTML文本，因此客户端只要有浏览器就能浏览。
>
- Servlet特点：在Java源码中嵌入html源码
- JSP特点：在html源码中嵌入java代码
#### JSP就是Servlet
>
#### 一个JSP页面可以被分为以下几部份：
- 静态数据，如HTML
- JSP指令，如include指令
- JSP脚本元素和变量
- JSP动作
- 用户自定义标签
>
#### 静态数据
- 静态数据在输入文件中的内容和输出给HTTP响应的内容完全一致。此时，该JSP输入文件会是一个没有内嵌JAVA或动作的HTML页面。而且，客户端每次请求都会得到相同的响应内容。
>
#### JSP指令
- JSP指令控制JSP编译器如何去生成servlet，以下是可用的指令：
- 包含指令include –包含指令通知JSP编译器把另外一个文件完全包含入当前文件中。效果就好像被包含文件的内容直接被粘贴到当前文件中一样。 <%@ include file="relativeURL"%> 
- 页面指令page：
- 标签库指令taglib –标签库指令描述了要使用的JSP标签库。该指令需要指定一个前缀prefix（和C++的命名空间很类似）和标签库的描述URI: <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
- **JSP指令格式**：<%@ directive {attribute=value}* %>
- directive：指令名称，例如page指令
- attribute=value：紧跟指令名称后面的就是各种属性，以键值对的形式书写
- *：代表后面能跟0个或多个属性。
```
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
```
- page指令，后面跟着三个属性，分别是language、contentType、pageEncoding。这只是其中的几个属性，并没有写全，page指令允许的属性如下表所示
- http://www.cnblogs.com/whgk/p/6427759.html
>
#### JSP 脚本
- 
#### JSP 动作
- 
### JSP 内置对象
- page、config、application、request、response、session、out、exception、pageContext
#### page：
- page对象代表当前JSP页面，是当前JSP编译后的Servlet类的对象。相当于this。
#### config：
- 标识Servlet配置，类型：ServletConfig，api跟Servlet中的ServletConfig对象是一样的，能获取该servlet的一些配置信息，能够获取ServletContext
#### application：
- 标识web应用上下文，类型：ServletContext，详情就看Servlet中的ServletContext的使用
#### request:
- 请求对象，　　类型：httpServletRequest
#### response:
- 响应对象　　类型：httpServletResponse
#### session：
- 表示一次会话，在服务器端记录用户状态信息的技术
#### out：
- 输出响应体 类型：JspWriter
#### exception 
- 表示发生异常对象，类型 Throwable，在上面我们介绍page指令中的一个errorPage属性时就有说到他
#### pageContext：
- 表示 jsp页面上下文（jsp管理者） 类型：PageContext
>
- 在这个由jsp转换为servlet的文件中，只能看到8个内置对象，少了exception对象，因为我们在将page指令时，说过一个isErrorPage属性，默认是false，被关闭了，所以其中并没有exception对象。
>
### JSP的四大作用域：
- page、request、session、application
- 这四大作用域，其实就是其九大内置对象中的四个，为什么说他们也是JSP的四大作用域呢？
- 因为这四个对象都能存储数据，比如request.setAttribute()注意和request.setParameter()区分开来，一个是存储在域中的、一个是请求参数，session.setAttribute()、application其实就是SerlvetContext，自然也有setAttribute()方法。而page作用域的操作就需要依靠pageContext对象来进行了。
>
#### page作用域：
- 代表变量只能在当前页面上生效
#### request：
- 代表变量能在一次请求中生效，一次请求可能包含一个页面，也可能包含多个页面，比如页面A请求转发到页面B
#### session：
- 代表变量能在一次会话中生效，基本上就是能在web项目下都有效，session的使用也跟cookie有很大的关系。一般来说，只要浏览器不关闭，cookie就会一直生效，cookie生效，session的使用就不会受到影响。
#### application：
- 代表变量能一个应用下(多个会话)，在服务器下的多个项目之间都能够使用。比如baidu、wenku等共享帐号。
>
### 总结
1、什么是JSP？

　　　　　　JSP本质上就是一个servlet，因为servlet输出html太麻烦了，所以就有了JSP，JSP就是专门用来书写html的，当然其中也能写java代码。

2、JSP的内容包括什么？

　　　　　　模版数据和元素。其中元素有包括脚本(java代码)、指令(页面属性)、和行为(标签，为了JSP中不嵌入那么多java代码衍生的)

3、JSP中九大内置对象是哪九个？

　　　　　　九大内置对象，page、config、appliction、request、response、session、out、exception、pageContext

4、九大内置对象和servlet中对象的关系

　　　　　　page就是jsp转换为servletservlet对象本身，也就是this

　　　　　　config -- Servlet中的servletConfig

　　　　　　application -- Servlet中的ServletContext

　　　　　　request　　-- Servlet中的request

　　　　　　response　　-- Servlet中的response

　　　　　　session　　-- Servlet中的session　　　　

　　　　　　out　　--　JspWriter

　　　　　　exception　　-- 异常对象

　　　　　　pageContext　　-- 表示 jsp页面上下文（jsp管理者） 类型：PageContext，

　　　　　　　　其中pageContext对象最牛逼，有了他就拥有了天下，哈哈~

5、JSP中的四大作用域。

　　　　　　page、request、session、application

　　　　　　其中操作page域中属性需要借助pageContext对象。

6、JSP中还有其他两大块内容

　　　　　　一个是EL表达式，很重要，

　　　　　　另一个是jstl标签库的使用，也很重要，


