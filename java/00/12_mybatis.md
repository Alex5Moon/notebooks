### Mybatis
>
- MyBatis 是一款优秀的持久层框架，它支持定制化 SQL、存储过程以及高级映射。MyBatis 避免了几乎所有的 JDBC 代码和手动设置参数以及获取结果集。MyBatis 可以使用简单的 XML 或注解来配置和映射原生信息，将接口和 Java 的 POJOs(Plain Ordinary Java Object,普通的 Java对象)映射成数据库中的记录。
- 每个MyBatis应用程序主要都是使用SqlSessionFactory实例的，一个SqlSessionFactory实例可以通过SqlSessionFactoryBuilder获得。SqlSessionFactoryBuilder可以从一个xml配置文件或者一个预定义的配置类的实例获得。
>
### 特点
>
- 简单易学：本身就很小且简单。没有任何第三方依赖，最简单安装只要两个jar文件+配置几个sql映射文件易于学习，易于使用，通过文档和源代码，可以比较完全的掌握它的设计思路和实现。
- 灵活：mybatis不会对应用程序或者数据库的现有设计强加任何影响。 sql写在xml里，便于统一管理和优化。通过sql基本上可以实现我们不使用数据访问框架可以实现的所有功能，或许更多。
- 解除sql与程序代码的耦合：通过提供DAO层，将业务逻辑和数据访问逻辑分离，使系统的设计更清晰，更易维护，更易单元测试。sql和代码的分离，提高了可维护性。
- 提供映射标签，支持对象与数据库的orm字段关系映射
- 提供对象关系映射标签，支持对象关系组建维护
- 提供xml标签，支持编写动态sql。
>
### 总体流程
>
- (1)**加载配置并初始化**
- 触发条件：加载配置文件
- 处理过程：将SQL的配置信息加载成为一个个MappedStatement对象（包括了传入参数映射配置、执行的SQL语句、结果映射配置），存储在内存中。
- (2)**接收调用请求**
- 触发条件：调用Mybatis提供的API
- 传入参数：为SQL的ID和传入参数对象
- 处理过程：将请求传递给下层的请求处理层进行处理。
- (3)**处理操作请求**
- 触发条件：API接口层传递请求过来
- 传入参数：为SQL的ID和传入参数对象
- 处理过程：
- (A)根据SQL的ID查找对应的MappedStatement对象。
- (B)根据传入参数对象解析MappedStatement对象，得到最终要执行的SQL和执行传入参数。
- (C)获取数据库连接，根据得到的最终SQL语句和执行传入参数到数据库执行，并得到执行结果。
- (D)根据MappedStatement对象中的结果映射配置对得到的执行结果进行转换处理，并得到最终的处理结果。
- (E)释放连接资源。
- (4)**返回处理结果将最终的处理结果返回**。
>
### 功能架构
>
- (1)API接口层：提供给外部使用的接口API，开发人员通过这些本地API来操纵数据库。接口层一接收到调用请求就会调用数据处理层来完成具体的数据处理。
- (2)数据处理层：负责具体的SQL查找、SQL解析、SQL执行和执行结果映射处理等。它主要的目的是根据调用的请求完成一次数据库操作。
- (3)基础支撑层：负责最基础的功能支撑，包括连接管理、事务管理、配置加载和缓存处理，这些都是共用的东西，将他们抽取出来作为最基础的组件。为上层的数据处理层提供最基础的支撑。
>
### 框架架构
>
- 框架架构讲解：
- (1)加载配置：配置来源于两个地方，一处是配置文件，一处是Java代码的注解，将SQL的配置信息加载成为一个个MappedStatement对象（包括了传入参数映射配置、执行的SQL语句、结果映射配置），存储在内存中。
- (2)SQL解析：当API接口层接收到调用请求时，会接收到传入SQL的ID和传入对象（可以是Map、JavaBean或者基本数据类型），Mybatis会根据SQL的ID找到对应的MappedStatement，然后根据传入参数对象对MappedStatement进行解析，解析后可以得到最终要执行的SQL语句和参数。
- (3)SQL执行：将最终得到的SQL和参数拿到数据库进行执行，得到操作数据库的结果。
- (4)结果映射：将操作数据库的结果按照映射的配置进行转换，可以转换成HashMap、JavaBean或者基本数据类型，并将最终结果返回。
>
### 动态SQL
>
- MyBatis 的强大特性之一便是它的动态 SQL。如果你有使用 JDBC 或其他类似框架的经验，你就能体会到根据不同条件拼接 SQL 语句有多么痛苦。拼接的时候要确保不能忘了必要的空格，还要注意省掉列名列表最后的逗号。利用动态 SQL 这一特性可以彻底摆脱这种痛苦。
- 通常使用动态 SQL 不可能是独立的一部分,MyBatis 当然使用一种强大的动态 SQL 语言来改进这种情形,这种语言可以被用在任意的 SQL 映射语句中。
- 动态 SQL 元素和使用 JSTL 或其他类似基于 XML 的文本处理器相似。在 MyBatis 之前的版本中,有很多的元素需要来了解。MyBatis 3 大大提升了它们,现在用不到原先一半的元素就可以了。MyBatis 采用功能强大的基于 OGNL 的表达式来消除其他元素。
>
- if
- choose (when, otherwise)
- trim (where, set)
- foreach
>
- **if**
- 动态 SQL 通常要做的事情是有条件地包含 where 子句的一部分。比如:
```
<select id="findActiveBlogWithTitleLike"
     resultType="Blog">
  SELECT * FROM BLOG 
  WHERE state = ‘ACTIVE’ 
  <if test="title != null">
    AND title like #{title}
  </if>
</select>
```
- 这条语句提供了一个可选的文本查找类型的功能。如果没有传入"title"，那么所有处于"ACTIVE"状态的BLOG都会返回；反之若传入了"title"，那么就会把模糊查找"title"内容的BLOG结果返回（就这个例子而言，细心的读者会发现其中的参数值是可以包含一些掩码或通配符的）。
- 如果想可选地通过"title"和"author"两个条件搜索该怎么办呢？首先，改变语句的名称让它更具实际意义；然后只要加入另一个条件即可。
```
<select id="findActiveBlogLike"
     resultType="Blog">
  SELECT * FROM BLOG WHERE state = ‘ACTIVE’ 
  <if test="title != null">
    AND title like #{title}
  </if>
  <if test="author != null and author.name != null">
    AND author_name like #{author.name}
  </if>
</select>
```
- **choose, when, otherwise**
- 有些时候，我们不想用到所有的条件语句，而只想从中择其一二。针对这种情况，MyBatis 提供了 choose 元素，它有点像 Java 中的 switch 语句。
- 还是上面的例子，但是这次变为提供了"title"就按"title"查找，提供了"author"就按"author"查找，若两者都没有提供，就返回所有符合条件的BLOG（实际情况可能是由管理员按一定策略选出BLOG列表，而不是返回大量无意义的随机结果）
```
<select id="findActiveBlogLike"
     resultType="Blog">
  SELECT * FROM BLOG WHERE state = ‘ACTIVE’
  <choose>
    <when test="title != null">
      AND title like #{title}
    </when>
    <when test="author != null and author.name != null">
      AND author_name like #{author.name}
    </when>
    <otherwise>
      AND featured = 1
    </otherwise>
  </choose>
</select>
```
- **trim, where, set**
- 前面几个例子已经合宜地解决了一个臭名昭著的动态 SQL 问题。现在考虑回到"if"示例，这次我们将"ACTIVE = 1"也设置成动态的条件，看看会发生什么。
```
<select id="findActiveBlogLike"
     resultType="Blog">
  SELECT * FROM BLOG 
  WHERE 
  <if test="state != null">
    state = #{state}
  </if> 
  <if test="title != null">
    AND title like #{title}
  </if>
  <if test="author != null and author.name != null">
    AND author_name like #{author.name}
  </if>
</select>
```
- 如果这些条件没有一个能匹配上将会怎样？最终这条 SQL 会变成这样：
```
SELECT * FROM BLOG
WHERE
```
- 这会导致查询失败。如果仅仅第二个条件匹配又会怎样？这条 SQL 最终会是这样:
```
SELECT * FROM BLOG
WHERE
AND title like 'someTitle'
```
- 这个查询也会失败。这个问题不能简单的用条件句式来解决，如果你也曾经被迫这样写过，那么你很可能从此以后都不想再这样去写了。
- MyBatis 有一个简单的处理，这在90%的情况下都会有用。而在不能使用的地方，你可以自定义处理方式来令其正常工作。一处简单的修改就能得到想要的效果：
```
<select id="findActiveBlogLike"
     resultType="Blog">
  SELECT * FROM BLOG 
  <where> 
    <if test="state != null">
         state = #{state}
    </if> 
    <if test="title != null">
        AND title like #{title}
    </if>
    <if test="author != null and author.name != null">
        AND author_name like #{author.name}
    </if>
  </where>
</select>
```
- where 元素知道只有在一个以上的if条件有值的情况下才去插入"WHERE"子句。而且，若最后的内容是"AND"或"OR"开头的，where 元素也知道如何将他们去除。
- 如果 where 元素没有按正常套路出牌，我们还是可以通过自定义 trim 元素来定制我们想要的功能。比如，和 where 元素等价的自定义 trim 元素为：
```
<trim prefix="WHERE" prefixOverrides="AND |OR ">
  ... 
</trim>
```
- prefixOverrides 属性会忽略通过管道分隔的文本序列（注意此例中的空格也是必要的）。它带来的结果就是所有在 prefixOverrides 属性中指定的内容将被移除，并且插入 prefix 属性中指定的内容。
- 类似的用于动态更新语句的解决方案叫做 set。set 元素可以被用于动态包含需要更新的列，而舍去其他的。比如：
```
<update id="updateAuthorIfNecessary">
  update Author
    <set>
      <if test="username != null">username=#{username},</if>
      <if test="password != null">password=#{password},</if>
      <if test="email != null">email=#{email},</if>
      <if test="bio != null">bio=#{bio}</if>
    </set>
  where id=#{id}
</update>
```
- 这里，set 元素会动态前置 SET 关键字，同时也会消除无关的逗号，因为用了条件语句之后很可能就会在生成的赋值语句的后面留下这些逗号。
- 若你对等价的自定义 trim 元素的样子感兴趣，那这就应该是它的真面目：
```
<trim prefix="SET" suffixOverrides=",">
  ...
</trim>
```
- 注意这里我们忽略的是后缀中的值，而又一次附加了前缀中的值。
- **foreach**
- 动态 SQL 的另外一个常用的必要操作是需要对一个集合进行遍历，通常是在构建 IN 条件语句的时候。比如：
```
<select id="selectPostIn" resultType="domain.blog.Post">
  SELECT *
  FROM POST P
  WHERE ID in
  <foreach item="item" index="index" collection="list"
      open="(" separator="," close=")">
        #{item}
  </foreach>
</select>
```
- foreach 元素的功能是非常强大的，它允许你指定一个集合，声明可以用在元素体内的集合项和索引变量。它也允许你指定开闭匹配的字符串以及在迭代中间放置分隔符。这个元素是很智能的，因此它不会偶然地附加多余的分隔符。
- 注意 你可以将一个 List 实例或者数组作为参数对象传给 MyBatis，当你这么做的时候，MyBatis 会自动将它包装在一个 Map 中并以名称为键。List 实例将会以"list"作为键，而数组实例的键将是"array"。
>
### mybatis分页
>
#### 数组分页
- 查询出全部数据，然后再list中截取需要的部分。
- **mybatis接口**
```
List<Student> queryStudentsByArray();
```
- **xml配置文件**
```
<select id="queryStudentsByArray"  resultMap="studentmapper">
        select * from student
</select>
```
- **service**
```
接口
List<Student> queryStudentsByArray(int currPage, int pageSize);
实现接口
 @Override
    public List<Student> queryStudentsByArray(int currPage, int pageSize) {
        //查询全部数据
        List<Student> students = studentMapper.queryStudentsByArray();
        //从第几条数据开始
        int firstIndex = (currPage - 1) * pageSize;
        //到第几条数据结束
        int lastIndex = currPage * pageSize;
        return students.subList(firstIndex, lastIndex); //直接在list中截取
    }
```
- **controller**
```
    @ResponseBody
    @RequestMapping("/student/array/{currPage}/{pageSize}")
    public List<Student> getStudentByArray(@PathVariable("currPage") int currPage, @PathVariable("pageSize") int pageSize) {
        List<Student> student = StuServiceIml.queryStudentsByArray(currPage, pageSize);
        return student;
    }
```
- **缺点**：数据库查询并返回所有的数据，而我们需要的只是极少数符合要求的数据。当数据量少时，还可以接受。当数据库数据量过大时，每次查询对数据库和程序的性能都会产生极大的影响。
>
#### sql分页
- 在了解到通过数组分页的缺陷后，我们发现不能每次都对数据库中的所有数据都检索。然后在程序中对获取到的大量数据进行二次操作，这样对空间和性能都是极大的损耗。所以我们希望能直接在数据库语言中只检索符合条件的记录，不需要在通过程序对其作处理。这时，Sql语句分页技术横空出世。
- 实现：通过sql语句实现分页也是非常简单的，只是需要改变我们查询的语句就能实现了，即在sql语句后面添加limit分页语句。
- **mybatis接口**
```
List<Student> queryStudentsBySql(Map<String,Object> data);
```
- **xml文件**
```
<select id="queryStudentsBySql" parameterType="map" resultMap="studentmapper">
        select * from student limit #{currIndex} , #{pageSize}
</select>
```
- **service**
```
接口
List<Student> queryStudentsBySql(int currPage, int pageSize);
实现类
public List<Student> queryStudentsBySql(int currPage, int pageSize) {
        Map<String, Object> data = new HashedMap();
        data.put("currIndex", (currPage-1)*pageSize);
        data.put("pageSize", pageSize);
        return studentMapper.queryStudentsBySql(data);
    }
```
- 缺点：虽然这里实现了按需查找，每次检索得到的是指定的数据。但是每次在分页的时候都需要去编写limit语句，很冗余。而且不方便统一管理，维护性较差。所以我们希望能够有一种更方便的分页实现。
>
#### 拦截器分页
- 自定义拦截器实现了**拦截所有以ByPage结尾的查询语句**，并且利用获取到的分页相关参数统一在sql语句后面加上limit分页的相关语句，一劳永逸。不再需要在每个语句中单独去配置分页相关的参数了。。
- 创建拦截器，拦截mybatis接口方法id以ByPage结束的语句
- ......
>
#### RowBounds分页
- 原理：通过RowBounds实现分页和通过数组方式分页原理差不多，都是一次获取所有符合条件的数据，然后在内存中对大数据进行操作，实现分页效果。只是数组分页需要我们自己去实现分页逻辑，这里更加简化而已。
- 存在问题：一次性从数据库获取的数据可能会很多，对内存的消耗很大，可能导师性能变差，甚至引发内存溢出。
- 适用场景：在数据量很大的情况下，建议还是适用拦截器实现分页效果。RowBounds建议在数据量相对较小的情况下使用。
- 数据量小时，RowBounds不失为一种好办法。但是数据量大时，实现拦截器就很有必要了。
- mybatis接口加入RowBounds参数
- public List<UserBean> queryUsersByPage(String userName, RowBounds rowBounds);
- **service**
     
```
    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED, propagation = Propagation.SUPPORTS)
    public List<RoleBean> queryRolesByPage(String roleName, int start, int limit) {
        return roleDao.queryRolesByPage(roleName, new RowBounds(start, limit));
    }
```
>
- 从上面四种sql分页的实现方式可以看出，通过RowBounds实现是最简便的，但是通过拦截器的实现方式是最优的方案。只需一次编写，所有的分页方法共同使用，还可以避免多次配置时的出错机率，需要修改时也只需要修改这一个文件，一劳永逸。而且是我们自己实现的，便于我们去控制和增加一些逻辑处理，使我们在外层更简单的使用。同时也不会出现数组分页和RowBounds分页导致的性能问题。当然，具体情况可以采取不同的解决方案。数据量小时，RowBounds不失为一种好办法。但是数据量大时，实现拦截器就很有必要了。
>
### #{}和${}的区别是什么？
- #{}是预编译处理，${}是字符串替换。
- Mybatis在处理#{}时，会将sql中的#{}替换为?号，调用PreparedStatement的set方法来赋值；
- Mybatis在处理${}时，就是把${}替换成变量的值。
- 使用#{}可以有效的防止SQL注入，提高系统安全性。     
>
### 当实体类中的属性名和表中的字段名不一样 ，怎么办？
- 第1种： 通过在查询的sql语句中定义字段名的别名，让字段名的别名和实体类的属性名一致 
```
    <select id=”selectorder” parametertype=”int” resultetype=”me.gacl.domain.order”> 
       select order_id id, order_no orderno ,order_price price form orders where order_id=#{id}; 
    </select> 
```
- 第2种： 通过<resultMap>来映射字段名和实体类属性名的一一对应的关系 
     
```
    <select id="getOrder" parameterType="int" resultMap="orderresultmap">
        select * from orders where order_id=#{id}
    </select>
   <resultMap type=”me.gacl.domain.order” id=”orderresultmap”> 
        <!–用id属性来映射主键字段–> 
        <id property=”id” column=”order_id”> 
        <!–用result属性来映射非主键字段，property为实体类属性名，column为数据表中的属性–> 
        <result property = “orderno” column =”order_no”/> 
        <result property=”price” column=”order_price” /> 
    </reslutMap>     
```
> 
### 模糊查询like语句该怎么写?
- 第1种：在Java代码中添加sql通配符。
```
    string wildcardname = “%smi%”; 
    list<name> names = mapper.selectlike(wildcardname);

    <select id=”selectlike”> 
     select * from foo where bar like #{value} 
    </select>        
```
- 第2种：在sql语句中拼接通配符，会引起sql注入
>
```
    string wildcardname = “smi”; 
    list<name> names = mapper.selectlike(wildcardname);

    <select id=”selectlike”> 
     select * from foo where bar like "%"#{value}"%"
    </select>
```
>
### Mybatis是如何进行分页的？分页插件的原理是什么？
- Mybatis使用RowBounds对象进行分页，它是针对ResultSet结果集执行的内存分页，而非物理分页，可以在sql内直接书写带有物理分页的参数来完成物理分页功能，也可以使用分页插件来完成物理分页。
>
- 分页插件的基本原理是使用Mybatis提供的插件接口，实现自定义插件，在插件的拦截方法内拦截待执行的sql，然后重写sql，根据dialect方言，添加对应的物理分页语句和物理分页参数。
>
### Mybatis是如何将sql执行结果封装为目标对象并返回的？都有哪些映射形式？
- 第一种是使用<resultMap>标签，逐一定义列名和对象属性名之间的映射关系。第二种是使用sql列的别名功能，将列别名书写为对象属性名，比如T_NAME AS NAME，对象属性名一般是name，小写，但是列名不区分大小写，Mybatis会忽略列名大小写，智能找到与之对应对象属性名，你甚至可以写成T_NAME AS NaMe，Mybatis一样可以正常工作。
>
- 有了列名与属性名的映射关系后，Mybatis通过反射创建对象，同时使用反射给对象的属性逐一赋值并返回，那些找不到映射关系的属性，是无法完成赋值的。
>
     
### 如何执行批量插入?
- 首先,创建一个简单的insert语句:   
     
```
    <insert id=”insertname”> 
     insert into names (name) values (#{value}) 
    </insert>
```
>
- 然后在java代码中像下面这样执行批处理插入:
```
    list<string> names = new arraylist(); 
    names.add(“fred”); 
    names.add(“barney”); 
    names.add(“betty”); 
    names.add(“wilma”); 

    // 注意这里 executortype.batch 
    sqlsession sqlsession = sqlsessionfactory.opensession(executortype.batch); 
    try { 
     namemapper mapper = sqlsession.getmapper(namemapper.class); 
     for (string name : names) { 
     mapper.insertname(name); 
     } 
     sqlsession.commit(); 
    } finally { 
     sqlsession.close(); 
    }
```
>
### 如何获取自动生成的(主)键值?
- insert 方法总是返回一个int值 - 这个值代表的是插入的行数。 而自动生成的键值在 insert 方法执行完后可以被设置到传入的参数对象中。 
```
    <insert id=”insertname” usegeneratedkeys=”true” keyproperty=”id”> 
     insert into names (name) values (#{name}) 
    </insert>

    name name = new name(); 
    name.setname(“fred”); 

    int rows = mapper.insertname(name); 
    // 完成后,id已经被设置到对象中 
    system.out.println(“rows inserted = ” + rows); 
    system.out.println(“generated key value = ” + name.getid());
```
>
- biernate调用插入方法save会返回一个对象,这个对象对应的ID就是主键。
- 你调用 save方法后，你的对象的 自增列id会自动被 赋值 本来新加的id在 save之前是0，save之后，xxx .id你自动被修改成数据库中生生成的id
- User user = new User();   save(user);   String id = user.getId();
>
### 在mapper中如何传递多个参数?
- 第1种：
```
//DAO层的函数

Public UserselectUser(String name,String area);  
```
>
```
//对应的xml,#{0}代表接收的是dao层中的第一个参数，#{1}代表dao层中第二参数，更多参数一致往后加即可。

<select id="selectUser"resultMap="BaseResultMap">  
    select *  fromuser_user_t   whereuser_name = #{0} anduser_area=#{1}  
</select> 
```
>
- 第2种：    使用 @param 注解: 
```
    import org.apache.ibatis.annotations.param; 
        public interface usermapper { 
         user selectuser(@param(“username”) string username, 
         @param(“hashedpassword”) string hashedpassword); 
        }
```
- 然后,就可以在xml像下面这样使用(推荐封装为一个map,作为单个参数传递给mapper): 
```
    <select id=”selectuser” resulttype=”user”> 
         select id, username, hashedpassword 
         from some_table 
         where username = #{username} 
         and hashedpassword = #{hashedpassword} 
    </select>
```
>
### Mybatis动态sql是做什么的？都有哪些动态sql？能简述一下动态sql的执行原理不？
>
- Mybatis动态sql可以让我们在Xml映射文件内，以标签的形式编写动态sql，完成逻辑判断和动态拼接sql的功能。
- Mybatis提供了9种动态sql标签：trim|where|set|foreach|if|choose|when|otherwise|bind。
- 其执行原理为，使用OGNL从sql参数对象中计算表达式的值，根据表达式的值动态拼接sql，以此来完成动态sql的功能。
>
### Mybatis的Xml映射文件中，不同的Xml映射文件，id是否可以重复？
>
- 不同的Xml映射文件，如果配置了namespace，那么id可以重复；如果没有配置namespace，那么id不能重复；毕竟namespace不是必须的，只是最佳实践而已。
- 原因就是namespace+id是作为Map<String, MappedStatement>的key使用的，如果没有namespace，就剩下id，那么，id重复会导致数据互相覆盖。有了namespace，自然id就可以重复，namespace不同，namespace+id自然也就不同。
>
### 为什么说Mybatis是半自动ORM映射工具？它与全自动的区别在哪里？
- Hibernate属于全自动ORM映射工具，使用Hibernate查询关联对象或者关联集合对象时，可以根据对象关系模型直接获取，所以它是全自动的。而Mybatis在查询关联对象或关联集合对象时，需要手动编写sql来完成，所以，称之为半自动ORM映射工具。
>
###  一对一、一对多的关联查询 ？
>
```
<mapper namespace="com.lcb.mapping.userMapper">  
    <!--association  一对一关联查询 -->  
    <select id="getClass" parameterType="int" resultMap="ClassesResultMap">  
        select * from class c,teacher t where c.teacher_id=t.t_id and c.c_id=#{id}  
    </select>  
    <resultMap type="com.lcb.user.Classes" id="ClassesResultMap">  
        <!-- 实体类的字段名和数据表的字段名映射 -->  
        <id property="id" column="c_id"/>  
        <result property="name" column="c_name"/>  
        <association property="teacher" javaType="com.lcb.user.Teacher">  
            <id property="id" column="t_id"/>  
            <result property="name" column="t_name"/>  
        </association>  
    </resultMap>  
     
    <!--collection  一对多关联查询 -->  
    <select id="getClass2" parameterType="int" resultMap="ClassesResultMap2">  
        select * from class c,teacher t,student s where c.teacher_id=t.t_id and c.c_id=s.class_id and c.c_id=#{id}  
    </select>  
    <resultMap type="com.lcb.user.Classes" id="ClassesResultMap2">  
        <id property="id" column="c_id"/>  
        <result property="name" column="c_name"/>  
        <association property="teacher" javaType="com.lcb.user.Teacher">  
            <id property="id" column="t_id"/>  
            <result property="name" column="t_name"/>  
        </association>  
        <collection property="student" ofType="com.lcb.user.Student">  
            <id property="id" column="s_id"/>  
            <result property="name" column="s_name"/>  
        </collection>  
    </resultMap>  

</mapper>       
```
>
### Xml映射文件中，除了常见的select|insert|updae|delete标签之外，还有哪些标签？
- 还有很多其他的标签，<resultMap>、<parameterMap>、<sql>、<include>、<selectKey>，加上动态sql的9个标签，trim|where|set|foreach|if|choose|when|otherwise|bind等，其中<sql>为sql片段标签，通过<include>标签引入sql片段，<selectKey>为不支持自增的主键生成策略标签。
>
     
### 最佳实践中，通常一个Xml映射文件，都会写一个Dao接口与之对应，请问，这个Dao接口的工作原理是什么？Dao接口里的方法，参数不同时，方法能重载吗？
- Dao接口，就是人们常说的Mapper接口，接口的全限名，就是映射文件中的namespace的值，接口的方法名，就是映射文件中MappedStatement的id值，接口方法内的参数，就是传递给sql的参数。**Mapper接口是没有实现类的**，当调用接口方法时，**接口全限名+方法名拼接字符串作为key值**，可唯一定位一个MappedStatement，举例：com.mybatis3.mappers.StudentDao.findStudentById，可以唯一找到namespace为com.mybatis3.mappers.StudentDao下面id = findStudentById的MappedStatement。在Mybatis中，**每一个<select>、<insert>、<update>、<delete>标签，都会被解析为一个MappedStatement对象**。
>
- Dao接口里的方法，是不能重载的，因为是全限名+方法名的保存和寻找策略。
- Dao接口的工作原理是JDK动态代理，Mybatis运行时会使用JDK动态代理为Dao接口生成代理proxy对象，代理对象proxy会拦截接口方法，转而执行MappedStatement所代表的sql，然后将sql执行结果返回。
>
     
### mybatis延迟加载 
- 什么是延迟加载 
- resultMap中的association和collection标签具有延迟加载的功能。
- 延迟加载的意思是说，在关联查询时，利用延迟加载，先加载主信息。使用关联信息时再去加载关联信息。
- 设置延迟加载
- 需要在SqlMapConfig.xml文件中，在<settings>标签中设置下延迟加载。
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
- Mybatis将所有Xml配置信息都封装到All-In-One重量级对象Configuration内部。在Xml映射文件中，<parameterMap>标签会被解析为ParameterMap对象，其每个子元素会被解析为ParameterMapping对象。<resultMap>标签会被解析为ResultMap对象，其每个子元素会被解析为ResultMapping对象。每一个<select>、<insert>、<update>、<delete>标签均会被解析为MappedStatement对象，标签内的sql会被解析为BoundSql对象。
>   
     
### 通常一个Xml映射文件，都会写一个Dao接口与之对应，请问，这个Dao接口的工作原理是什么？Dao接口里的方法，参数不同时，方法能重载吗？
>
```
- Dao接口，就是人们常说的Mapper接口，接口的全限名，就是映射文件中的namespace的值，接口的方法名，就是映射文件中MappedStatement的id值，接口方法内的参数，就是传递给sql的参数。Mapper接口是没有实现类的，当调用接口方法时，接口全限名+方法名拼接字符串作为key值，可唯一定位一个MappedStatement，举例：com.mybatis3.mappers.StudentDao.findStudentById，可以唯一找到namespace为com.mybatis3.mappers.StudentDao下面id = findStudentById的MappedStatement。在Mybatis中，每一个<select>、<insert>、<update>、<delete>标签，都会被解析为一个MappedStatement对象。
```
>
- Dao接口里的方法，是不能重载的，因为是全限名+方法名的保存和寻找策略。
>
- Dao接口的工作原理是JDK动态代理，Mybatis运行时会使用JDK动态代理为Dao接口生成代理proxy对象，代理对象proxy会拦截接口方法，转而执行MappedStatement所代表的sql，然后将sql执行结果返回。
>




