### Spring mvc
>
### 工作原理
- 1 spring mvc请所有的请求都提交给DispatcherServlet,它会委托应用系统的其他模块负责负责对请求进行真正的处理工作。 
- 2 DispatcherServlet查询一个或多个HandlerMapping,找到处理请求的Controller.
- 3 DispatcherServlet请请求提交到目标Controller
- 4 Controller进行业务逻辑处理后，会返回一个ModelAndView
- 5 Dispathcher查询一个或多个ViewResolver视图解析器,找到ModelAndView对象指定的视图对象 
- 6 视图对象负责渲染返回给客户端。 
>
- 用户提交请求到前端控制器dispatcherServlet
- 由DispatcherServlet控制器查询一个或多个HandlerMapping，找到处理请求的Controller
- DispatcherServlet将请求提交到Controller
- Controller进行业务逻辑处理后，返回ModelAndView对象，该对象本身就包含了视图对象信息
- DispatcherServlet查询一个或多个ViewResoler视图解析器，找到ModelAndView对象指定的视图对象
- 视图负责将结果显示到客户端
>
- DispatcherServlet是前置控制器，配置在web.xml文件中的。拦截匹配的请求，Servlet拦截匹配规则要自已定义，把拦截下来的请求，依据相应的规则分发到目标Controller来处理，是配置spring MVC的第一步。
>
### 常用注解
>
- @Controller 
- 负责注册一个bean 到spring 上下文中
>
- @RequestMapping 
- 注解为控制器指定可以处理哪些 URL 请求
>
- @RequestBody
- 该注解用于读取Request请求的body部分数据，使用系统默认配置的HttpMessageConverter进行解析，然后把相应的数据绑定到要返回的对象上 ,再把HttpMessageConverter返回的对象数据绑定到 controller中方法的参数上
>
- @ResponseBody
- 该注解用于将Controller的方法返回的对象，通过适当的HttpMessageConverter转换为指定格式后，写入到Response对象的body数据区
>
- @ModelAttribute 　　　
- 在方法定义上使用 @ModelAttribute 注解：Spring MVC 在调用目标处理方法前，会先逐个调用在方法级上标注了@ModelAttribute 的方法
- 在方法的入参前使用 @ModelAttribute 注解：可以从隐含对象中获取隐含的模型数据中获取对象，再将请求参数 –绑定到对象中，再传入入参将方法入参对象添加到模型中 
- @RequestParam　
- 在处理方法入参处使用 @RequestParam 可以把请求参 数传递给请求方法
>
- @PathVariable
- 绑定 URL 占位符到入参
>
- @ExceptionHandler
- 注解到方法上，出现异常时会执行该方法
>
- @ControllerAdvice
- 使一个Contoller成为全局的异常处理类，类中用@ExceptionHandler方法注解的方法可以处理所有Controller发生的异常
>
### 设置一个自定义的拦截器
>
- 1 创建一个MyInterceptor类，并实现HandlerInterceptor接口
```
public class MyInterceptor implements HandlerInterceptor {

    @Override
    public void afterCompletion(HttpServletRequest arg0,
            HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {
        System.out.println("afterCompletion");
    }

    @Override
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
            Object arg2, ModelAndView arg3) throws Exception {
        System.out.println("postHandle");
    }

    @Override
    public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1,
            Object arg2) throws Exception {
        System.out.println("preHandle");
        return true;
    }

}
```
>
- 2 在SpringMVC的配置文件中配置
```
<!-- interceptor setting -->
    <mvc:interceptors>
        <mvc:interceptor>
            <mvc:mapping path="/mvc/**"/>
            <bean class="test.SpringMVC.Interceptor.MyInterceptor"></bean>
        </mvc:interceptor>        
    </mvc:interceptors>
```
>
### Spring mvc常用注解
>
- @RequestMapping:用于请求url映射
- @RequestBody：注解实现接收http请求的json数据，将json转换为java对象
- @ResponseBody：注解实现将conreoller方法返回对象转化为json对象响应给客户
>
### 如何开启注解处理器和适配器？
>
-  我们在项目中一般会在springmvc.xml中通过开启<mvc:annotation-driven>来实现注解处理器和适配器的开启
>
### 如何解决get和post乱码问题？
>
- 解决post请求乱码：我们可以在web.xml里边配置一个CharacterEncodingFilter 过滤器。设置为utf-8
- 解决get请求乱码有两种方法，对于get请求中文参数出现乱码解决方法有两个：
- 1）修改tomcat配置文件添加编码和工程编码一致
- 2）另一种方法对参数进行重新编码，String username = new String(Request.getParameter("userName").getBytes("ISO8859-1"),"utf-8");
>
### 什么是Spring MVC ？简单介绍下你对springMVC的理解?
>
- Spring MVC是一个基于MVC架构的用来简化web应用程序开发的应用开发框架，它是Spring的一个模块,无需中间整合层来整合 ，它和Struts2一样都属于表现层的框架。在web模型中，MVC是一种很流行的框架，通过把Model，View，Controller分离，把较为复杂的web应用分成逻辑清晰的几部分，简化开发，减少出错，方便组内开发人员之间的配合。
>
### Spring MVC的主要组键？
- （1）前端控制器 DispatcherServlet（不需要程序员开发）
- 作用：接收请求、响应结果 相当于转发器，有了DispatcherServlet 就减少了其它组件之间的耦合度。
-（2）处理器映射器HandlerMapping（不需要程序员开发）
- 作用：根据请求的URL来查找Handler
-（3）处理器适配器HandlerAdapter
- 注意：在编写Handler的时候要按照HandlerAdapter要求的规则去编写，这样适配器HandlerAdapter才可以正确的去执行Handler。
-（4）处理器Handler（需要程序员开发）
-（5）视图解析器 ViewResolver（不需要程序员开发）
- 作用：进行视图的解析 根据视图逻辑名解析成真正的视图（view）
-（6）视图View（需要程序员开发jsp）
- View是一个接口， 它的实现类支持不同的视图类型（jsp，freemarker，pdf等等）
>
### SpringMVC怎么样设定重定向和转发的？
>
-（1）在返回值前面加"forward:"就可以让结果转发,譬如"forward:user.do?name=method4"
-（2）在返回值前面加"redirect:"就可以让返回值重定向,譬如"redirect:http://www.baidu.com"
>
### SpringMvc里面拦截器是怎么写的：
>
- 有两种写法,一种是实现HandlerInterceptor接口,另外一种是继承适配器类,，接着在接口方法当中，实现处理逻辑；然后在SpringMvc的配置文件中配置拦截器即可:
>
```
 <!-- 配置SpringMvc的拦截器 -->
 
<mvc:interceptors>
 
    <!-- 配置一个拦截器的Bean就可以了 默认是对所有请求都拦截 -->
 
    <bean id="myInterceptor" class="com.et.action.MyHandlerInterceptor"></bean>
 
    <!-- 只针对部分请求拦截 -->
 
    <mvc:interceptor>
 
       <mvc:mapping path="/modelMap.do" />
 
       <bean class="com.et.action.MyHandlerInterceptorAdapter" />
 
    </mvc:interceptor>
 
</mvc:interceptors>
```
>
### SpringMvc的控制器是不是单例模式,如果是,有什么问题,怎么解决？
- 答：是单例模式,所以在多线程访问的时候有线程安全问题,不要用同步,会影响性能的,解决方案是在控制器里面不能写字段。
>
### @RequestMapping注解用在类上面有什么作用？
- 答：是一个用来处理请求地址映射的注解，可用于类或方法上。用于类上，表示类中的所有响应请求的方法都是以该地址作为父路径。
>
### SpingMvc中的控制器的注解一般用那个,有没有别的注解可以替代？
- 答：一般用@Conntroller注解,表示是表现层,不能用用别的注解代替。
>
### SpringMvc用什么对象从后台向前台传递数据的？
- 答：通过ModelMap对象,可以在这个对象里面用put方法,把对象加到里面,前台就可以通过el表达式拿到。
>
### SpringMvc中有个类把视图和数据都合并的一起的,叫什么？
- 答：叫ModelAndView。
>

