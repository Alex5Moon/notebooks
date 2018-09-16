### mybatis延迟加载 
- 什么是延迟加载 
- resultMap中的association和collection标签具有延迟加载的功能。
- 延迟加载的意思是说，在关联查询时，利用延迟加载，先加载主信息。使用关联信息时再去加载关联信息。
- 设置延迟加载
- 需要在SqlMapConfig.xml文件中，在\<settings>标签中设置下延迟加载。
- lazyLoadingEnabled、aggressiveLazyLoading
>
     
```
<!-- 开启延迟加载 -->
    <settings>
        <!-- lazyLoadingEnabled:延迟加载启动，默认是false -->
        <setting name="lazyLoadingEnabled" value="true"/>
        <!-- aggressiveLazyLoading：积极的懒加载，false的话按需加载，默认是true -->
        <setting name="aggressiveLazyLoading" value="false"/>
         
        <!-- 开启二级缓存，默认是false -->
        <setting name="cacheEnabled" value="true"/>
    </settings>
```
>
### Mybatis缓存
>
- Mybatis的一级缓存是指**SqlSession**。一级缓存的作用域是一个SqlSession。Mybatis默认开启一级缓存。
- 在同一个SqlSession中，执行相同的查询SQL，第一次会去查询数据库，并写到缓存中；第二次直接从缓存中取。当执行SQL时两次查询中间发生了增删改操作，则SqlSession的缓存清空。
>
- Mybatis的二级缓存是指**mapper映射文件**。二级缓存的作用域是**同一个namespace下的mapper映射文件内容，多个SqlSession共享**。Mybatis需要手动设置启动二级缓存。
- 在同一个namespace下的mapper文件中，执行相同的查询SQL，第一次会去查询数据库，并写到缓存中；第二次直接从缓存中取。当执行SQL时两次查询中间发生了增删改操作，则二级缓存清空。
>
### 一级缓存原理
- 一级缓存区域是根据SqlSession为单位划分的。
- 每次查询会先去缓存中找，如果找不到，再去数据库查询，然后把结果写到缓存中。Mybatis的内部缓存使用一个HashMap，key为hashcode+statementId+sql语句。Value为查询出来的结果集映射成的java对象。
- SqlSession执行insert、update、delete等操作commit后会清空该SQLSession缓存。
>
### 二级缓存原理
- 二级缓存是mapper级别的。Mybatis默认是没有开启二级缓存。
- 第一次调用mapper下的SQL去查询用户信息。查询到的信息会存到该mapper对应的二级缓存区域内。
- 第二次调用相同namespace下的mapper映射文件中相同的SQL去查询用户信息。会去对应的二级缓存内取结果。
- 如果调用相同namespace下的mapper映射文件中的增删改SQL，并执行了commit操作。此时会清空该namespace下的二级缓存。
>
- 开启二级缓存
- 1、在核心配置文件SqlMapConfig.xml中加入以下内容（开启二级缓存总开关）：cacheEnabled设置为 true
- 2、在映射文件中，加入以下内容，开启二级缓存：
>
### 自定义缓存
- 自定义缓存对象，该对象必须实现 org.apache.ibatis.cache.**Cache 接口**，
```
import org.apache.ibatis.cache.Cache;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 * Created by Luky on 2017/10/14.
 */
public class BatisCache implements Cache {
    private ReadWriteLock lock = new ReentrantReadWriteLock();
    private ConcurrentHashMap<Object,Object> cache = new ConcurrentHashMap<Object, Object>();
    private String id;

    public  BatisCache(){
        System.out.println("初始化-1！");
    }

  //必须有该构造函数
    public BatisCache(String id){
        System.out.println("初始化-2！");
        this.id = id;
    }

    // 获取缓存编号
    public String getId() {
        System.out.println("得到ID：" + id);
        return id;
    }

    //获取缓存对象的大小
    public int getSize() {
        System.out.println("获取缓存大小！");
        return 0;
    }
    // 保存key值缓存对象
    public void putObject(Object key, Object value) {
        System.out.println("往缓存中添加元素：key=" + key+",value=" + value);
        cache.put(key,value);
    }

    //通过KEY
    public Object getObject(Object key) {
        System.out.println("通过kEY获取值：" + key);
        System.out.println("OVER");
        System.out.println("=======================================================");
        System.out.println("值为：" + cache.get(key));
        System.out.println("=====================OVER==============================");
        return cache.get(key);
    }

    // 通过key删除缓存对象
    public Object removeObject(Object key) {
        System.out.println("移除缓存对象：" + key);
        return null;
    }

    // 清空缓存
    public void clear() {
        System.out.println("清除缓存！");
        cache.clear();
    }

    // 获取缓存的读写锁
    public ReadWriteLock getReadWriteLock() {
        System.out.println("获取锁对象！！！");
        return lock;
    }
}
```
-  在Mapper文件里配置使用该自定义的缓存对象，如：
```
<cache type="com.sanyue.utils.BatisCache"/>
```
>
### Mybatis都有哪些Executor执行器？它们之间的区别是什么？
>
- Mybatis有三种基本的Executor执行器，SimpleExecutor、ReuseExecutor、BatchExecutor。
- SimpleExecutor：每执行一次update或select，就开启一个Statement对象，用完立刻关闭Statement对象。
- ReuseExecutor：执行update或select，以sql作为key查找Statement对象，存在就使用，不存在就创建，用完后，不关闭Statement对象，而是放置于Map<String, Statement>内，供下一次使用。简言之，就是重复使用Statement对象。
- BatchExecutor：执行update（没有select，JDBC批处理不支持select），将所有sql都添加到批处理中（addBatch()），等待统一执行（executeBatch()），它缓存了多个Statement对象，每个Statement对象都是addBatch()完毕后，等待逐一执行executeBatch()批处理。与JDBC批处理相同。
>
- 作用范围：Executor的这些特点，都严格限制在SqlSession生命周期范围内。
>
### Mybatis中如何指定使用哪一种Executor执行器？
>
- 在Mybatis配置文件中，可以指定默认的ExecutorType执行器类型，也可以手动给DefaultSqlSessionFactory的创建SqlSession的方法传递ExecutorType类型参数。
>
### Mybatis是否可以映射Enum枚举类？
- Mybatis可以映射枚举类，不单可以映射枚举类，Mybatis可以映射任何对象到表的一列上。映射方式为自定义一个TypeHandler，实现TypeHandler的setParameter()和getResult()接口方法。TypeHandler有两个作用，一是完成从javaType至jdbcType的转换，二是完成jdbcType至javaType的转换，体现为setParameter()和getResult()两个方法，分别代表设置sql问号占位符参数和获取列查询结果。
>
### 简述Mybatis的Xml映射文件和Mybatis内部数据结构之间的映射关系？
- Mybatis将所有Xml配置信息都封装到All-In-One重量级对象Configuration内部。
- 在Xml映射文件中，\<parameterMap>标签会被解析为ParameterMap对象，其每个子元素会被解析为ParameterMapping对象。
- \<resultMap>标签会被解析为ResultMap对象，其每个子元素会被解析为ResultMapping对象。
- 每一个\<select>、\<insert>、\<update>、\<delete>标签均会被解析为MappedStatement对象，标签内的sql会被解析为BoundSql对象。
>   
### 通常一个Xml映射文件，都会写一个Dao接口与之对应，请问，这个Dao接口的工作原理是什么？Dao接口里的方法，参数不同时，方法能重载吗？
>
- Dao接口，就是人们常说的Mapper接口，接口的全限名，就是映射文件中的namespace的值，接口的方法名，
- 就是映射文件中MappedStatement的id值，接口方法内的参数，就是传递给sql的参数。Mapper接口是没有实现类的，
- 当调用接口方法时，接口全限名+方法名拼接字符串作为key值，可唯一定位一个MappedStatement，
- 举例：com.mybatis3.mappers.StudentDao.findStudentById，可以唯一找到namespace为com.mybatis3.mappers.StudentDao下面id = findStudentById的MappedStatement。
- 在Mybatis中，每一个\<select>、\<insert>、\<update>、\<delete>标签，都会被解析为一个MappedStatement对象。
>
- Dao接口里的方法，是不能重载的，因为是全限名+方法名的保存和寻找策略。
>
- Dao接口的工作原理是JDK动态代理，Mybatis运行时会使用JDK动态代理为Dao接口生成代理proxy对象，代理对象proxy会拦截接口方法，转而执行MappedStatement所代表的sql，然后将sql执行结果返回。
>



