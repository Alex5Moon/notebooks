### Hibernate 
>
- Hibernate是一个开放源代码的对象关系映射框架，它对JDBC进行了非常轻量级的对象封装，它将POJO与数据库表建立映射关系，是一个全自动的orm框架，hibernate可以自动生成SQL语句，自动执行，使得Java程序员可以随心所欲的使用对象编程思维来操纵数据库。
>
### Hibernate特定
>
- 将对数据库的操作转换为对Java对象的操作，从而简化开发。通过修改一个“持久化”对象的属性从而修改数据库表中对应的记录数据。
- 提供线程和进程两个级别的缓存提升应用程序性能。
- 有丰富的映射方式将Java对象之间的关系转换为数据库表之间的关系。
- 屏蔽不同数据库实现之间的差异。在Hibernate中只需要通过“方言”的形式指定当前使用的数据库，就可以根据底层数据库的实际情况生成适合的SQL语句。
- 非侵入式：Hibernate不要求持久化类实现任何接口或继承任何类，POJO即可。
>
### 核心API
>
- Hibernate的API一共有6个，分别为:Session、SessionFactory、Transaction、Query、Criteria和Configuration。通过这些接口，可以对持久化对象进行存取、事务控制。
>
- Session接口负责**执行被持久化对象的CRUD操作**(CRUD的任务是完成与数据库的交流，包含了很多常见的SQL语句)。但需要注意的是**Session对象是非线程安全的**。
- SessionFactory接口负责**初始化Hibernate**。它充当数据存储源的代理，**并负责创建Session对象**。这里用到了工厂模式。需要注意的是SessionFactory并不是轻量级的，因为一般情况下，一个项目通常只需要一个SessionFactory就够，当需要操作多个数据库时，可以为每个数据库指定一个SessionFactory。
- Transaction 接口是一个可选的API，可以选择不使用这个接口，取而代之的是Hibernate 的设计者自己写的底层事务处理代码。
- Query接口**让你方便地对数据库及持久对象进行查询**，它可以有两种表达方式：HQL语言或本地数据库的SQL语句。Query经常被用来绑定查询参数、限制查询记录数量，并最终执行查询操作。
- Criteria接口**与Query接口非常类似**，允许创建并执行面向对象的标准化查询。值得注意的是Criteria接口也是轻量级的，它不能在Session之外使用。
- Configuration 类的作用是**对Hibernate 进行配置，以及对它进行启动**。在Hibernate 的启动过程中，Configuration 类的实例首先定位映射文档的位置，读取这些配置，然后创建一个SessionFactory对象。虽然Configuration 类在整个Hibernate 项目中只扮演着一个很小的角色，但它是启动hibernate 时所遇到的第一个对象。
>
### Hibernate运行过程或原理
>
- 1 通过Configuration().configure();读取并解析hibernate.cfg.xml配置文件
- 2 由hibernate.cfg.xml中的<mappingresource="com/xx/User.hbm.xml"/>读取并解析映射信息
- 3 通过config.buildSessionFactory();//创建SessionFactory
- 4 sessionFactory.openSession();//打开Sesssion
- 5 session.beginTransaction();//创建事务Transation
- 6 persistent operate持久化操作 //一般指Save这个方法
- 7 session.getTransaction().commit();//提交事务
- 8 关闭Session
- 9 关闭SesstionFactory
>
### Hibernate主键
>
- **Assigned**方式由用户生成主键值，并且要在save()之前指定否则会抛出异常
- 特点：主键的生成值完全由用户决定，与底层数据库无关。用户需要维护主键值，在调用session.save()之前要指定主键值。
- **Hilo**使用高低位算法生成主键，高低位算法使用一个高位值和一个低位值，然后把算法得到的两个值拼接起来作为数据库中的唯一主键。
- 特点：需要额外的数据库表的支持，能保证同一个数据库中主键的唯一性，但不能保证多个数据库之间主键的唯一性。
- **Increment**方式对主键值采取自动增长的方式生成新的主键值，但要求底层数据库的主键类型为long,int等数值型。主键按数值顺序递增，增量为1。
- 特点：由Hibernate本身维护，适用于所有的数据库，不适合多进程并发更新数据库，适合单一进程访问数据库。不能用于群集环境。
- Identity方式根据底层数据库，来支持自动增长，不同的数据库用不同的主键增长方式。
- **Sequence**需要底层数据库支持Sequence方式，例如Oracle数据库等
- 特点：需要底层数据库的支持序列，支持序列的数据库有DB2、PostgreSql、Oracle、SAPDb等在不同数据库之间移植程序，特别从支持序列的数据库移植到不支持序列的数据库需要修改配置文件。
- **Native**主键生成方式会根据不同的底层数据库自动选择Identity、Sequence、Hilo主键生成方式
- 特点：根据不同的底层数据库采用不同的主键生成方式。由于Hibernate会根据底层数据库采用不同的映射方式，因此便于程序移植，项目中如果用到多个数据库时，可以使用这种方式。
- **UUID**使用128位UUID算法生成主键，能够保证网络环境下的主键唯一性，也就能够保证在不同数据库及不同服务器下主键的唯一性。
- 特点：能够保证数据库中的主键唯一性，生成的主键占用比较多的存贮空间
- **Foreign**用于一对一关系中。GUID主键生成方式使用了一种特殊算法，保证生成主键的唯一性，支持SQL Server和MySQL
>
### Hibernate缓存管理
>
- 首先说下Hibernate缓存的作用（即为什么要用缓存机制），然后再具体说说Hibernate中缓存的分类情况，最后可以举个具体的例子。
- Hibernate缓存的作用：
- Hibernate是一个持久层框架，经常访问物理数据库，为了**降低应用程序对物理数据源访问的频次，从而提高应用程序的运行性能**。缓存内的数据是对物理数据源中的数据的复制，应用程序在运行时从缓存读写数据，在特定的时刻或事件会同步缓存和物理数据源的数据Hibernate缓存分类：
- Hibernate缓存包括两大类：Hibernate一级缓存和Hibernate二级缓存Hibernate一级缓存又称为“Session的缓存”，它是内置的，不能被卸载（不能被卸载的意思就是这种缓存不具有可选性，必须有的功能，不可以取消session缓存）。由于Session对象的生命周期通常对应一个数据库事务或者一个应用事务，因此它的缓存是事务范围的缓存。第一级缓存是必需的，不允许而且事实上也无法卸除。在第一级缓存中，持久化类的每个实例都具有唯一的OID。 Hibernate二级缓存又称为“SessionFactory的缓存”，由于SessionFactory对象的生命周期和应用程序的整个过程对应，因此Hibernate二级缓存是进程范围或者集群范围的缓存，有可能出现并发问题，因此需要采用适当的并发访问策略，该策略为被缓存的数据提供了事务隔离级别。第二级缓存是可选的，是一个可配置的插件，在默认情况下，SessionFactory不会启用这个插件。
- **什么样的数据适合存放到第二级缓存中？**
- 1 很少被修改的数据
- 2 不是很重要的数据，允许出现偶尔并发的数据
- 3 不会被并发访问的数据
- 4 常量数据
- **不适合存放到第二级缓存的数据？**
- 1 经常被修改的数据
- 2 .绝对不允许出现并发访问的数据，如财务数据，绝对不允许出现并发
- 3 与其他应用共享的数据。
- **Hibernate查找对象如何应用缓存？**
- 当Hibernate根据ID访问数据对象的时候，首先从Session一级缓存中查；查不到，如果配置了二级缓存，那么从二级缓存中查；如果都查不到，再查询数据库，把结果按照ID放入到缓存,删除、更新、增加数据的时候，同时更新缓存。Hibernate管理缓存实例无论何时，当你给save()、update()或saveOrUpdate()方法传递一个对象时，或使用load()、 get()、list()、iterate() 或scroll()方法获得一个对象时, 该对象都将被加入到Session的内部缓存中。 当随后flush()方法被调用时，对象的状态会和数据库取得同步。 如果你不希望此同步操作发生，或者你正处理大量对象、需要对有效管理内存时，你可以调用evict() 方法，从一级缓存中去掉这些对象及其集合。
>
### [Hibernate之实体类之间的关系](https://blog.csdn.net/yanjie_1572828/article/details/77488112)
>
- 1 一对一：如一个公民对应一张身份证。
- 2 一对多：省与市
- 3 多对多： 权限表
>










