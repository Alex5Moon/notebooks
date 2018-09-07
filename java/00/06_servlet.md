### Servlet
- Servlet（Server Applet），全称Java Servlet，未有中文译文。 
>
- 是用Java编写的服务器端程序。 
>
- 其主要功能在于交互式地浏览和修改数据，生成动态Web内容。
>
- 读取客户端（浏览器）发送的数据，处理数据并生成结果，发送数据到客户端（浏览器）。 
>
### Servlet 定义
- Servlet是一个Java应用程序，运行在服务器端，用来处理客户端请求并作出响应的程序。
>
- Servlet多线程体系结构是建立在Java多线程机制之上的，它的生命周期是由Web容器负责的。
>
- 当客户端第一次请求某个Servlet时，Servlet容器将会根据web.xml配置文件实例化这个Servlet类，此时它贮存于内存中。。当有新的客户端请求该Servlet时，一般不会再实例化该Servlet类，也就是有多个线程在使用这个实例。 这样，当两个或多个线程同时访问同一个Servlet时，可能会发生多个线程同时访问同一资源的情况，数据可能会变得不一致。所以在用Servlet构建的Web应用时要注意线程安全的问题。每一个请求都是一个线程，而不是进程，因此，Servlet对请求的处理的性能非常高。
>
- 对于Servlet，它被设计为多线程的（如果它是单线程的，你就可以想象，当1000个人同时请求一个网页时，在第一个人获得请求结果之前，其它999个人都在郁闷地等待），如果为每个用户的每一次请求都创建 一个新的线程对象来运行的话，系统就会在创建线程和销毁线程上耗费很大的开销，大大降低系统的效率。
>
- 因此，Servlet多线程机制背后有一个线程池在支持，线程池在初始化初期就创建了一定数量的线程对象，通过提高对这些对象的利用率，避免高频率地创建对象，从而达到提高程序的效率的目的。
>
### Servlet 运行步骤
- 1 客户端向服务器端发出请求；
>
- 2 这个过程比较重要，这时Tomcat会创建两个对象：HttpServletResponse和HttpServletRequest。并将它们的引用（注意是引用）传给刚分配的线程；
>
- 3 线程开始着手接洽servlet；
>
- 4 servlet根据传来的是GET和POST，分别调用doGet()和doPost()方法进行处理；
>
- 5 和⑥servlet将处理后的结果通过线程传回Tomcat，并在之后将这个线程销毁或者送还线程池；
>
- 6 Tomcat将处理后的结果变成一个HTTP响应发送回客户端，这样，客户端就可以接受到处理后的结果了。
>
### 创建 Servlet 的3种方式
- 1 实现 Servlet 接口
>
- 2 继承 GenericServlet 类
>
- 3 继承 HttpServlet 类
>
### web.xml 配置
>
```
<?xml version="1.0" encoding="UTF-8"?>
<web-app>

  <!-- 1.注册别名 -->
  <servlet>
  	<servlet-name>time</servlet-name>
  	<servlet-class>web.TimeServlet</servlet-class>
  </servlet>
  <!-- 2.注册访问路径 -->
  <servlet-mapping>
  	<servlet-name>time</servlet-name>
  	<url-pattern>/ts</url-pattern>	
  </servlet-mapping>
  
</web-app>
```
### Servlet生命周期
- Servlet运行在Servlet容器中，其生命周期由容器来管理。
- Servlet的生命周期通过javax.servlet.Servlet接口中的init()、service()和destroy()方法来表示。
### Servlet的生命周期包含了下面4个阶段： 
#### （1）加载和实例化
- Servlet容器负责加载和实例化Servlet。当Servlet容器启动时，或者在容器检测到需要这个Servlet来响应第一个请求时，创建Servlet实例。
- 当Servlet容器启动后，它必须要知道所需的Servlet类在什么位置，Servlet容器可以从本地文件系统、远程文件系统或者其他的网络服务中通过类加载器加载Servlet类，成功加载后，容器创建Servlet的实例。因为容器是通过Java的反射API来创建Servlet实例，调用的是Servlet的默认构造方法（即不带参数的构造方法），所以我们在编写Servlet类的时候，不应该提供带参数的构造方法。
>
#### （2）初始化
- 在Servlet实例化之后，容器将调用Servlet的init()方法初始化这个对象。
- 初始化的目的是为了让Servlet对象在处理客户端请求前完成一些初始化的工作，如建立数据库的连接，获取配置信息等。对于每一个Servlet实例，init()方法只被调用一次。
>
#### （3）请求处理
- Servlet容器调用Servlet的service()方法对请求进行处理。
- 要注意的是，在service()方法调用之前，init()方法必须成功执行。
>
#### （4）服务终止
- 当容器检测到一个Servlet实例应该从服务中被移除的时候，容器就会调用实例的destroy()方法，以便让该实例可以释放它所使用的资源，保存数据到持久存储设备中。
- 当需要释放内存或者容器关闭时，容器就会调用Servlet实例的destroy()方法。在destroy()方法调用之后，容器会释放这个Servlet实例，该实例随后会被Java的垃圾收集器所回收。如果再次需要这个Servlet处理请求，Servlet容器会创建一个新的Servlet实例。
>
- 在整个Servlet的生命周期过程中，创建Servlet实例、调用实例的init()和destroy()方法都只进行一次，当初始化完成后，Servlet容器会将该实例保存在内存中，通过调用它的service()方法，为接收到的请求服务。
>

### Servlet 任务
- Servlet 执行以下主要任务：
>
- 读取客户端（浏览器）发送的显式的数据。这包括网页上的 HTML 表单，或者也可以是来自 applet 或自定义的 HTTP 客户端程序的表单。
- 读取客户端（浏览器）发送的隐式的 HTTP 请求数据。这包括 cookies、媒体类型和浏览器能理解的压缩格式等等。
- 处理数据并生成结果。这个过程可能需要访问数据库，执行 RMI 或 CORBA 调用，调用 Web 服务，或者直接计算得出对应的响应。
- 发送显式的数据（即文档）到客户端（浏览器）。该文档的格式可以是多种多样的，包括文本文件（HTML 或 XML）、二进制文件（GIF 图像）、Excel 等。
- 发送隐式的 HTTP 响应到客户端（浏览器）。这包括告诉浏览器或其他客户端被返回的文档类型（例如 HTML），设置 cookies 和缓存参数，以及其他类似的任务。
>
### 请求方式
#### GET
- 默认情况下所有的请求都是GET请求
- 采用路径传参，即通过路径携带参数
- 传参过程中参数可见，隐私性差
- 因为路径大小有限制，所以能够传递的参数很小
>
#### POST
- method="post"
- 采用实体内容传参
- 在传参的过程中，路径上看不到参数，隐私性好
- 实体内容专门用于传递数据，因此大小不受限制
>
### 使用场景
- 向服务器索取(查询)数据时通常用GET
- 向服务器提交(保存)数据时通常用POST
>
### 解决乱码问题
#### get/post
- Servlet 接收乱码 String，采用 ISO8859-1 将其还原为 byte，在采用 utf-8 将此 byte 编成 string。
- 优点：对 get/post 都有效
- 缺点：太麻烦。
>
#### get
- 在 /tomcat/conf/server.xml，加上 URLEncoding = "utf-8"
- 优点：简单
- 会影响 tomcat 内所有项目。
>
#### post
- 通过 request 设置实体内容的解码方式为 utf-8，req.setCharacterEncoding("utf-8")，必须写在 req.getParamter() 之前。
- 优点：简单
- 缺点：只对 post 有效。
>
### 解决请求乱码的建议
- 1 get 请求避免传中文
- 2 post 请求 req.setCharacterEncoding("utf-8")
>
### 转发
- 一个web资源收到客户端的请求后，通知服务器调用另外一个web资源进行处理。
- 运用场景：MVC设计模式
- 实现方式：通过request对象来实现：
- request.getRequestDispatcher("new.jsp").forward(request, response); //转发到new.jsp
>
### 重定向
- 一个web资源收到客户端的请求后，通知客户端去访问另外一个web资源，这称之为请求重定向。
- 运用场景：如用户登录。
- 实现方式：通过response来实现：
- response.sendRedirect（"new.jsp"） // 重定向到 new.jsp
>
### 转发和重定向区别
- 转发是**服务器**行为,重定向是**客户端**行为
- 1 转发在服务器端完成的；重定向是在客户端完成的
- 2 转发的速度快；重定向速度慢
- 3 转发的是同一次请求；重定向是两次不同请求;所以相比较而言，转发对于服服务器的压力更小
- 4 转发不会执行转发后的代码；重定向会执行重定向之后的代码
- 5 转发地址栏没有变化；重定向地址栏有变化
- 6 转发必须是在同一台服务器下完成；重定向可以在不同的服务器下完成 
#### 7 转发 "/"的根目录是当前web应用下的根目录，而重定向是整个web站点的根目录，如下面的示例代码中，同样跳转到Login.jsp界面，但重定向却要在前面加上项目名；
```
  // 转发
  request.getRequestDispatcher("/Login.jsp").forward(request, response);  
  
  // 重定向
  response.sendRedirect("/ServletDemo/Login.jsp");   
```
- RequestDispatcher.forward方法的调用者与被调用者之间**共享**相同的request对象和response对象，它们属于同一个访问请求和响应过程.而HttpServletResponse.sendRedirect方法调用者与被调用者使用**各自**的request对象和response对象，它们属于两个独立的访问请求和响应过程。
>
#### 转发过程：
- 客户浏览器发送http请求,web服务器接受此请求,调用内部的一个方法在容器内部完成请求处理和转发动作,将目标资源发送给客户；在这里，转发的路径必须是同一个web容器下的url，其不能转向到其他的web路径上去，中间传递的是自己的容器内的request。在客户浏览器路径栏显示的仍然是其第一次访问的路径，也就是说客户是感觉不到服务器做了转发的。转发行为是浏览器只做了一次访问请求。
>
#### 重定向过程：
- 客户浏览器发送http请求,web服务器接受后发送302状态码响应及对应新的location给客户浏览器,客户浏览器发现是302响应，则自动再发送一个新的http请求，请求url是新的location地址,服务器根据此请求寻找资源并发送给客户。在这里location可以重定向到任意URL，既然是浏览器重新发出了请求，则就没有什么request传递的概念了。在客户浏览器路径栏显示的是其重定向的路径，客户可以观察到地址的变化的。重定向行为是浏览器做了至少两次的访问请求的。 
>
#### 重定向，其实是两次request, 
- 第一次，客户端request   A,服务器响应，并response回来，告诉浏览器，你应该去B。这个时候IE可以看到地址变了，而且历史的回退按钮也亮了。重定向可以访问自己web应用以外的资源。在重定向的过程中，传输的信息会被丢失。
>
#### 重定向与转发的区别，
- 通俗的来讲，打个比方：张三找李四借钱，李四没有钱，李四让张三自己去找王五借，这是重定向；张三找李四借钱，李四虽然没有钱，但李四从王五那借来钱，然后再借给张三，这是转发。
>
### Servlet路径的配置方式及用途
- Servlet路径有3种配置方式，不同的方式使得它处理请求的方式不同。
#### 1 精准匹配（/abc）
- 只有这唯一的路径可以访问此Servlet
- 该Servlet只能处理这一个请求
>
#### 2 通配符（/\*）
- 所有的路径都可以访问此Servlet
- 该Servlet可以处理所有请求
>
#### 3 后缀（/\*.a）
- 所有以 .a 为后缀的路径都可以访问此Servlet
- 该Servlet可以处理很多请求
>
### ServletConfig和ServletContext
#### ServletContext对象：
- servlet容器在启动时会加载web应用，并为每个web应用创建唯一的servlet context对象，可以把ServletContext看成是一个Web应用的服务器端组件的共享内存，在ServletContext中可以存放共享数据。ServletContext对象是真正的一个全局对象，凡是web容器中的Servlet都可以访问。
>
#### servletConfig对象：
- 用于封装servlet的配置信息。从一个servlet被实例化后，对任何客户端在任何时候访问有效，但仅对servlet自身有效，一个servlet的ServletConfig对象不能被另一个servlet访问。
>
#### 作用
- 可以从web.xml中读取数据,给Servlet使用。
- 它们都能够给Servlet预置参数
>
#### 区别
- config和Servlet是1对1的关系
- context和Servlet是1对多的关系
>
#### ServletConfig
- 1)场景介绍
- 假设开发一个网页游戏
- 如果在线人数达到最大值时,新登录的人需要排队
- 需要开发登录功能LoginServlet
- 在此Servlet内要获取在线人数最大值并加以判断
- 最大值maxonline要求可以配置
>
- 2)实现方式
- 将参数配置到web.xml内
- 该参数只给登录功能LoginServlet使用,使用config读取
```
<!-- LoginServlet案例(ServletConfig) -->
  <servlet>
    <servlet-name>login</servlet-name>
    <servlet-class>web.LoginServlet</servlet-class>
    <!-- 给此Servlet预置参数 -->
    <init-param>
      <param-name>maxOnline</param-name>
      <param-value>3000</param-value>
    </init-param>
  </servlet>
  <servlet-mapping>
    <servlet-name>login</servlet-name>
    <url-pattern>/login</url-pattern>
  </servlet-mapping>
```
>
#### ServletContext
- 1)场景介绍
- 项目通常都有很多查询功能,几乎每个查询都支持分页
- 分页的已知条件: 页码page, 每页显示行数size
- size要求可以配置,便于系统上线时实施人员去修改
- 2)实现方式
- 配置到web.xml中
- 因为多个功能都要使用该参数,所以使用context来读取它
```
<!-- (ServletCotext全局) 可以通过ServletContext读取该参数-->
  <context-param>
    <param-name>size</param-name>
    <param-value>20</param-value>
  </context-param>
 
  <!-- findDeptServlet和案例findEServlet -->
  <servlet>
    <servlet-name>findDept</servlet-name>
    <servlet-class>web.findDeptServlet</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>findDept</servlet-name>
    <url-pattern>/findDept</url-pattern>
  </servlet-mapping>
  <servlet>
    <servlet-name>findEmp</servlet-name>
    <servlet-class>web.findEmpServlet</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>findEmp</servlet-name>
    <url-pattern>/findEmp</url-pattern>
  </servlet-mapping>
```
>
#### ServletContext的特殊用途
- 1)特殊用途
- config和context典型的用途是读取web.xml中的常量
- 特殊用途:context还可以读写变量
- 用该对象读写的变量是可以被所有servlet共用的
- setAttribute()/getAttribute()
>
- 2)场景介绍
- 要统计软件的流量(访问量/访问人次)
- 任何人访问软件的任何功能,则流量+1
>
```

public class InitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	/**
	 * 该Servlet不负责处理具体的业务,只用来在Tomcat启动时初始化数据
	 * 一般WEB项目中都有1-2个这样的Servlet
	 * init()或init(ServletConfig config)两种方法都可以
	 */
	@Override
	public void init() throws ServletException {
		super.init();
		ServletContext context = getServletContext();
		//将数据保存在context对象中,默认访问量为0
		context.setAttribute("count", 0);
	}
}


//统计访问量
Integer count = (Integer)context.getAttribute("count");
//更新count,重新写入ServletContext
context.setAttribute("count", ++count);
System.out.println("当前访问量:"+count);


<!-- InitServlet案例 servlet-mapping可以不写 -->
  <servlet>
    <servlet-name>init</servlet-name>
    <servlet-class>web.InitServlet</servlet-class>
    <load-on-startup>1</load-on-startup>
  </servlet>
  

```
#### 总结：
- 1 当需要给Servlet预置参数时使用这样的对象
- 2 若参数只给一个Servlet使用,用ServletConfig
- 3 若参数只给多个Servlet使用,用ServletContext
>
### 线程安全问题
- 局部变量存在于栈内，栈内数据是多份，每个线程都有自己的一套数据，没有并发问题。
- 成员变量存在于堆内，堆内数据只有一份，多个线程共用一份数据，存在并发问题。
>




