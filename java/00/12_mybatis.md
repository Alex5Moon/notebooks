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
```
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
- 。。。。。。
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
























