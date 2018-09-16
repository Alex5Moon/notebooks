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













































