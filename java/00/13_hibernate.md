### Hibernate 
>
- Hibernate是一个开放源代码的对象关系映射框架，它对JDBC进行了非常轻量级的对象封装，它将POJO与数据库表建立映射关系，是一个全自动的orm框架，hibernate可以自动生成SQL语句，自动执行，使得Java程序员可以随心所欲的使用对象编程思维来操纵数据库。
>
### Hibernate特点
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
- 类与类之间的关系主要体现在表与表之间的关系进行操作，它们都是对对象进行操作，我们程序中把所有的表与类都映射在一起，它们通过配置文件中的many-to-one、one-to-many、many-to-many。
>
- 1 一对一：如一个公民对应一张身份证。
- 2 一对多：省与市
- 3 多对多： 权限表
>
### Hibernate延迟加载
>
- Hibernate对象关系映射提供延迟的与非延迟的对象初始化。非延迟加载在读取一个对象的时候会将与这个对象所有相关的其他对象一起读取出来。这有时会导致成百的（如果不是成千的话）select语句在读取对象的时候执行。这个问题有时出现在使用双向关系的时候，经常会导致整个数据库都在初始化的阶段被读出来了。当然，你可以不厌其烦地检查每一个对象与其他对象的关系，并把那些最昂贵的删除，但是到最后，我们可能会因此失去了本想在ORM工具中获得的便利。
>
- 一个明显的解决方法是使用Hibernate提供的延迟加载机制。这种初始化策略只在一个对象调用它的一对多或多对多关系时才将关系对象读取出来。这个过程对开发者来说是透明的，而且只进行了很少的数据库操作请求，因此会得到比较明显的性能提升。这项技术的一个缺陷是延迟加载技术要求一个Hibernate会话要在对象使用的时候一直开着。
>
- 当Hibernate在查询数据的时候，数据并没有存在与内存中，当程序真正对数据的操作时，对象才存在与内存中，就实现了延迟加载，他节省了服务器的内存开销，从而提高了服务器的性能。
>
- hibernate中，在many-to-one时，如果我们设置了延迟加载，会发现我们在eclipse的调试框中查看one对应对象时，它的内部成员变量全是null的。
- 设置非延迟加载后不为null。
>
- 在hibernate方法中，直接涉及到延迟加载的方法有get和load，使用get时，不会延迟加载，load则反之。另外，在many-to-one等关系配置中，我们也可以通过lazy属性设置是否延迟加载，这是我们对hibernate最直观的认识。
>
- 在hibernate设置延迟加载后，hibernate返回给我们的对象（要延迟加载的对象）是一个代理对象，并不是真实的对象，该对象没有真实对象的数据，只有真正需要用到对象数据（调用getter等方法时）时，才会触发hibernate去数据库查对应数据，而且查回来的数据不会存储在代理对象中，所以这些数据是无法在调试窗口查看到的。
>
- 代理是一个中间者，它的主要作用之一是我们可以利用代理对象来增强对真正对象的控制：例如在hibernate中控制数据加载的时间在正真调用数据时发生。
>
- 在jdk中的代理，主要通过一个叫做InvocationHandler的委托接口和Proxy的代理类来实现动态代理，一般来说，Proxy会通过调用InvocationHandler的invoke方法进行代理委托：也就是invoke方法才是真正的代理方法。所以java中要动态代理的话，必须有一个InvocationHandler的具体实现类。
>
### get和load的区别
>
- 1、get和load都是利用主键策略查询数据， 
- 2、get默认不使用懒加载机制，load默认要使用懒加载机制，所谓的懒加载就是我们这个数据如果不使用，hibernate就不发送SQL到数据库查询数据。 
- 3、当查询数据库不存在的数据的时候，get方法返回null，load方法抛出空指针异常， 
- 原因是因为，load方法采用的动态代理的方式实现的，我们使用load方法的时候，hibernate会创建一个该实体的代理对象，该代理只保存了该对象的ID，当我们访问该实体对象其他属性，hibernate就发送SQL查询数据封装到代理对象，然后在利用代理对象返回给我们实际的数据，
>
### Hibernate优化
>
- 1 使用双向一对多关联，不使用单向一对多
- 2 灵活使用单向一对多关联
- 3 不用一对一，用多对一取代
- 4 配置对象缓存，不使用集合缓存
- 5 一对多集合使用Bag,多对多集合使用Set
- 6 继承类使用显式多态
- 7 表字段要少，表关联不要怕多，有二级缓存撑腰
>
- 大体上，对于HIBERNATE性能调优的主要考虑点如下：
- .数据库设计调整
- .HQL优化
- .API的正确使用(如根据不同的业务类型选用不同的集合及查询API)
- .主配置参数(日志，查询缓存，fetch_size, batch_size等)
- .映射文件优化(ID生成策略，二级缓存，延迟加载，关联优化)
- .一级缓存的管理
- .针对二级缓存，还有许多特有的策略
- .事务控制策略。
>
- 数据库设计
- a) 降低关联的复杂性
- b) 尽量不使用联合主键
- c) ID的生成机制，不同的数据库所提供的机制并不完全一样
- d) 适当的冗余数据，不过分追求高范式
>
- HQL优化
- HQL如果抛开它同HIBERNATE本身一些缓存机制的关联，HQL的优化技巧同普通的SQL优化技巧一样
>
- 主配置
- a) 查询缓存，同下面讲的缓存不太一样，它是针对HQL语句的缓存，即完全一样的语句再次执行时可以利用缓存数据。但是，查询缓存在一个交易系统(数据变更频繁，查询条件相同的机率并不大)中可能会起反作用:它会白白耗费大量的系统资源但却难以派上用场。
- b) fetch_size，同JDBC的相关参数作用类似，参数并不是越大越好，而应根据业务特征去设置
- c) batch_size同上。
- d) 生产系统中，切记要关掉SQL语句打印。
>
- 缓存
- a) 数据库级缓存:这级缓存是最高效和安全的，但不同的数据库可管理的层次并不一样，比如，在Oracle中，可以在建表时指定将整个表置于缓存当中。
- b) SESSION缓存:在一个HibernateSESSION有效，这级缓存的可干预性不强，大多于HIBERNATE自动管理，但它提供清除缓存的方法，这在大批量增加/更新操作是有效的。比如，同时增加十万条记录，按常规方式进行，很可能会发现OutofMemeroy的异常，这时可能需要手动清除这一级缓存:Session.evict以及 Session.clear
- c) 应用缓存:在一个SESSIONFACTORY中有效，因此也是优化的重中之重，因此，各类策略也考虑的较多，在将数据放入这一级缓存之前，需要考虑一些前提条件：
- i. 数据不会被第三方修改(比如，是否有另一个应用也在修改这些数据?)
- ii. 数据不会太大
- iii. 数据不会频繁更新(否则使用CACHE可能适得其反)
- iv. 数据会被频繁查询
- v. 数据不是关键数据(如涉及钱，安全等方面的问题)。
- 缓存有几种形式，可以在映射文件中配置:read-only(只读，适用于很少变更的静态数据/历史数据)，nonstrict-read- write，read-write(比较普遍的形式，效率一般)，transactional(JTA中，且支持的缓存产品较少)
- d) 分布式缓存:同c)的配置一样，只是缓存产品的选用不同，oscache, jboss cache，的大多数项目，对它们的用于集群的使用(特别是关键交易系统)都持保守态度。在集群环境中，只利用数据库级的缓存是最安全的。
>
- 延迟加载
- a) 实体延迟加载:通过使用动态代理实现
- b) 集合延迟加载:通过实现自有的SET/LIST，HIBERNATE提供了这方面的支持
- c) 属性延迟加载:
>
- 事务控制
- 事务方面对性能有影响的主要包括:事务方式的选用，事务隔离级别以及锁的选用
- a) 事务方式选用:如果不涉及多个事务管理器事务的话，不需要使用JTA，只有JDBC的事务控制就可以。
- b) 事务隔离级别:参见标准的SQL事务隔离级别
- c) 锁的选用:悲观锁(一般由具体的事务管理器实现)，对于长事务效率低，但安全。乐观锁(一般在应用级别实现)，如在HIBERNATE中可以定义 VERSION字段，显然，如果有多个应用操作数据，且这些应用不是用同一种乐观锁机制，则乐观锁会失效。因此，针对不同的数据应有不同的策略，同前面许多情况一样，很多时候我们是在效率与安全/准确性上找一个平衡点，无论如何，优化都不是一个纯技术的问题，你应该对你的应用和业务特征有足够的了解。
>
- 批量操作
- 即使是使用JDBC，在进行大批数据更新时，BATCH与不使用BATCH有效率上也有很大的差别。可以通过设置batch_size来让其支持批量操作。
>
### hibernate数据三种状态
>
- hibernate把他所管理的数据划分为三种状态 
- 瞬时的（刚new出来的数据–内存有，数据库没有） 
- 持久的 （从数据查询的，或者刚保存到数据库，session没关闭的， 数据库有，内存也有） 
- 游离的 、脱管的（数据库有，内存没有）
>
- 实际上hibernate对数据划分三种状态，主要是为了管理我们持久的数据，在事务提交的时候，hibernate去对比处于持久状态的数据是否发生改变，(快照区、一级缓存区)，当我们会话结束前，对持久状态数据进行了修改的话，快照区的数据会跟着改变。当session提交事务的时候，如果发现快照区和一级缓存的数据不一致，就会发送SQL进行修改。
>
### hibernate的乐观锁和悲观锁
>
- hibernate在管理我们数据的时候的，永远无法避免一个问题，那就是并发，
- **并发**指的是多个线程同时访问同一个资源，而并发会存在很多问题，**同步**指的是多个线程访问同一资源的时候，当一个线程对该资源的操作完成了以后，才交给下一个线程进行操作，有点像排队，**异步**指的是多个线程访问同一资源的时候，所有的线程一起访问这个资源，不需要等待其他线程访问完成，也可以进行访问和操作。
- hiberante在并发的时候会存在如下问题: 
>
- 1 丢失数据更新 
- 2 数据脏读，所谓的数据脏读，就是当并发的时候，一个线程进行修改，还未提交事务的时候另一个线程就读取了更新后的数据，但是后面第一个线程回滚，更新无效，那第二个线程读取到的数据就是脏数据。 
- 3 数据虚读或者幻读，此处的线程1修改完age之后，线程2立马进来修改了name，并提交事务，线程1在读取我们的数据，发现被修改了2个字段，这就是虚读或者幻读
- 4 不可重复读，此处线程1先查询age=20，线程2把age修改Wie30，线程1再次查询的时候发现age=30，所以重复读取两次数据不一致，所以重复读取出错。
>
- 所谓的**悲观锁**，就是hibernate心态不好，认为每一次操作都会出现并发，所以当我们查询数据的时候就直接把这一条数据锁住，不让别人操作。底层是利用的数据库的for update来实现的，就是查询数据的时候利用数据库把当前查询的数据给锁住，不让其他线程操作
- 其实这就是一个非常依赖于数据库的悲观锁的使用，同理，Hibernate之所以也能够这样，也就是通过数据库中的锁机制来实现的。
>
- Hibernate的加锁模式有：
- LockMode.NONE ：无锁机制。
- LockMode.WRITE ：Hibernate在 Insert和 Update记录的时候会自动获取。
- LockMode.READ ：Hibernate在读取记录的时候会自动获取。
- 以上这三种锁机制一般由 Hibernate内部使用，如Hibernate为了保证 Update过程中对象不会被外界修改，会在 save 方法实现中自动为目标对象加上 WRITE锁。
LockMode.UPGRADE ：利用数据库的 for update 子句加锁。
- LockMode. UPGRADE_NOWAIT ： Oracle的特定实现，利用 Oracle的 for update nowait子句实现加锁。
>
- 悲观锁---------锁的粒度为数据库
- 乐观锁----------锁的粒度为表，而且当出现了问题之后，才采取措施，有点类似CAS
- 乐观锁，从名字来看，就肯定比悲观锁有着更为乐观的态度了，就是说悲观锁大多数情况下依靠数据库的锁机制实现，以保证操作最大程度的独占性。但随之而来的就是数据库性能的大量开销，特别是对长事务而言，这样的开销往往无法承受。乐观锁机制在一定程度上解决了这个问题。
- 乐观锁的工作原理：读取出数据时，将此版本号一同读出，之后更新时，对此版本号加一。此时，将提交数据的版本数据与数据库表对应记录的当前版本信息进行比对，如果提交的数据版本号大于数据库表当前版本号，则予以更新，否则认为是过期数据。
- Hibernate为乐观锁提供了三 种实现：
- 1 基于version----------最常用
- 2 基于timestamp-----------较常用
- 3 为遗留项目添加添加乐观锁------不常用
>
### hibernate中getCurrentSession和openSession区别 
>
- getCurrentSession和openSession都是通过H的工厂去获取数据库的会话对象， 
- 1、getCurrentSession会绑定当前线程，而openSession不会，因为我们把hibernate交给我们的spring来管理之后，我们是有事务配置，这个有事务的线程就会绑定当前的工厂里面的每一个session，而openSession是创建一个新session。 
- 2、getCurrentSession事务是有spring来控制的，而openSession需要我们手动开启和手动提交事务， 
- 3、getCurrentSession是不需要我们手动关闭的，因为工厂会自己管理，而openSession需要我们手动关闭。 
- 4、而getCurrentSession需要我们手动设置 绑定事务的机制，有三种设置方式，jdbc本地的Thread、JTA、第三种是spring提供的事务管理机制org.springframework.orm.hibernate4.SpringSessionContext，而且srping默认使用该种事务管理机制，
>
- Hibetnate有两种方式获得session,分别是：OpenSession和getCurrentSession，他们的区别在于
- 1. 获取的是否是同一个session对象
- OpenSession每次都会得到一个新的Session对象
- getCurrentSession在同一个线程中，每次都是获取想同的Session对象，但是在不同的线程中获取的是不同的Session对象
>
- 2. 事务提交的必要性
- openSession只有在增加，删除，修改的时候需要事务，查询时不需要的
- getCurrentSession是所有操作都必须放在事务中进行，并且提交事务后，session就自动关闭，不能够再进行关闭
>
### 事务的类型
>
- 第一种：本地事务：在单个 EIS 或数据库的本地并且限制在单个进程内的事务。本地事务不涉及多个数据来源
- 第二种：全局事务：资源管理器管理和协调的事务，可以跨越多个数据库和进程。
- 如果在项目中有需要进行不同中数据库源的数据操作（比如mysql和oracle结合）那么就需要进行全局事务的管理，如果是使用的同一种数据源的话，那么可以考虑使用本地事务即可
>
### 进行更新操作的时候，为什么一般都是需要先获取到数据库中原数据，然后再把新对象的内容进行复制，然后再执行更新操作呢？
>
- 在hibernate的工作机制中，对应在同一区域（Hibernate缓存区）和时间是不能够有相同主键内容的数据存在的，也就是说不能有两个相同主键的持久化类存在。更为通俗的讲解就是，如果当前需要更新的实体，刚好的主键id对应着Hibernate缓存区中，已经存在了，那么这样就会报一个different object with the same identitifer的错误，很明显就是说存在了相同id的两个持久化类了，所以，通过先拿到当前修改id的原始内容，然后进行修改属性内容之后，再把改对象放入到更新操作中，就相当于从hibernate缓存区先取出已经存在的，然后修改了，再放回去，这样就肯定保证了只会存在一个唯一了，所以就防止不会出现上述的这个错误了。当然，如果不进行先获取，再保存也可以，只是这样增加了安全性，所以记住，如果进行修改操作，那么就需要这样的步骤才是最安全的。
>
### 如何解决hibernate中，懒加载load方法出现，no session的错误?
>
- 之所以出现这样的问题是在于，session对象当执行了相应的crud操作之后，就会结束生命周期了，而当session结束之后，然后又访问刚获取到的对象的相应的内容，那么因为是load（）方法是进行懒加载，当真正进行使用该对象的时候，再会真正的去获取，而此时session对象已经关闭了，所以肯定就会出现上面的问题了。
- 如何解决这个问题，其实很好解决，那就是扩大session的生命周期。
>
### hibernate的n+1问题
>
- 一般而言说n+1意思是，无论在一对多还是多对一当查询出n条数据之后，每条数据会关联的查询1次他的关联对象，这就叫做n+1。
- 本来所有信息可以一次性查询出来，也就是简单的连表查询，但是Hibernate会首先查询1次得到当前对象，然后当前对象里面的n个关联对象会再次访问数据库n次，这就是1+n问题。
- 既然出现这个问题，肯定是要避免的，尤其是对于高并发的互联网应用，这种现象是绝对不允许出现的。
- Hibernate给出了3中解决方案，不过比较偏向于手动写sql，也就是JDBC或者iBatis那种风格。因为这样的sql是绝对可控的，只是在移植性方面不如Hibernate。各有所长各有所短吧。
>
- 1 延迟加载，当需要的时候才查询，不需要就不查询，但是感觉这种方式治标不治本，尤其是在那种报表统计查询的时候更为明显。
- 2 fetch="join"，默认是fetch="select"，这个其实说白了就是一个做外连接，允许外键为空的情况之下。
- 3 二级缓存，第一次查询之后存在内存中，后面的相同查询就快了。但是有2个缺点：a.二级缓存首先是有点浪费内存空间，如果多了的话浪费还比较严重，这是一个不好的方面，当然这不是主要的，主要的问题在于，二级缓存的特性决定的，那就是很少的增删改才做二级缓存，而对于普通的CRUD系统，其实不太适合。所以感觉也不是首选。
>
- oneToXXX延迟查询效率最高的几种方法
- 第一种：lazy=true fetch=select batch-size= 5 然后，你的所有语句不用考虑联合查询 from Department d
- 第二种：lazy=true fetch=subselect 然后，你的所有语句不用考虑联合查询from Department d
- 第三种： 默认 lazy=true，fetch=select 你自己知道什么时候用Department ： from  Department d 什么时候Deparment - Employee ： from Department d left join fetch d.employees
>
- XXXToOne延迟查询效率最高的方法
- 第一种：左外连接，只需一句SQL语句查询
- 第二种：否则用懒加载@LazyToOne(LazyToOneOption.PROXY)
>
### update和saveOrUpdate的区别？
- update()和saveOrUpdate()是用来对跨Session的PO进行状态管理的。 
- update()方法操作的对象必须是持久化了的对象。也就是说，如果此对象在数据库中不存在的话，就不能使用update()方法。 
- saveOrUpdate()方法操作的对象既可以使持久化了的，也可以使没有持久化的对象。如果是持久化了的对象调用saveOrUpdate()则会 更新数据库中的对象；如果是未持久化的对象使用此方法,则save到数据库中。
>
### 比较hibernate的三种检索策略优缺点
>
- 1立即检索； 
- 优点： 对应用程序完全透明，不管对象处于持久化状态，还是游离状态，应用程序都可以方便的从一个对象导航到与它关联的对象； 
- 缺点： 1.select语句太多；2.可能会加载应用程序不需要访问的对象白白浪费许多内存空间； 
- 2延迟检索： 
- 优点： 由应用程序决定需要加载哪些对象，可以避免可执行多余的select语句，以及避免加载应用程序不需要访问的对象。因此能提高检索性能，并且能节省内存空间； 
- 缺点： 应用程序如果希望访问游离状态代理类实例，必须保证他在持久化状态时已经被初始化； 
- 3 迫切左外连接检索 
- 优点： 1对应用程序完全透明，不管对象处于持久化状态，还是游离状态，应用程序都可以方便地冲一个对象导航到与它关联的对象。2使用了外连接，select语句数目少； 
- 缺点： 1 可能会加载应用程序不需要访问的对象，白白浪费许多内存空间；2复杂的数据库表连接也会影响检索性能；
>
### hibernate里面的sorted collection 和ordered collection有什么区别
>
- sorted collection是在内存中通过Java比较器进行排序的 
- ordered collection是在数据库中通过order by进行排序的
>
### Hibernate有哪几种查询数据的方式
>
- 3种：hql、条件查询QBC(QueryBy Criteria)、原生sql （通过createSQLQuery建立）
>
### 谈谈Hibernate中inverse的作用
>
- nverse属性默认是false,就是说关系的两端都来维护关系。 
- 比如Student和Teacher是多对多关系，用一个中间表TeacherStudent维护。
- 如果Student这边inverse=”true”, 那么关系由另一端Teacher维护，就是说当插入Student时，不会操作TeacherStudent表（中间表）。只有Teacher插入或删除时才会触发对中间表的操作。所以两边都inverse=”true”是不对的，会导致任何操作都不触发对中间表的影响；当两边都inverse=”false”或默认时，会导致在中间表中插入两次关系。
>
### 什么是SessionFactory,她是线程安全么？
>
- SessionFactory 是Hibrenate单例数据存储和线程安全的，以至于可以多线程同时访问。一个SessionFactory 在启动的时候只能建立一次。SessionFactory应该包装各种单例以至于它能很简单的在一个应用代码中储存.
>
### Hibernate分页
>
- 第一种：hql分页（不推荐）需要手动关闭session连接
- 第二种：DetachedCriteria （推荐使用）
>
### Hibernate实现分页查询的原理分析
>
- Hibernate的查询定义在net.sf.hibernate.loader.**Loader**这个类里面，仔细阅读该类代码，就可以把问题彻底搞清楚。
- 如果相应的数据库定义了限定查询记录的sql语句，那么直接使用特定数据库的sql语句。
- 然后来看net.sf.hibernate.dialect.MySQLDialect:
```
public boolean supportsLimit(); {  
  return true;  
}  
public String getLimitString(String sql); {  
  StringBuffer pagingSelect = new StringBuffer(100);;  
  pagingSelect.append(sql);;  
  pagingSelect.append(" limit ?, ?");;  
  return pagingSelect.toString();;  
}  
```
- 这是MySQL的专用分页语句，再来看net.sf.hibernate.dialect.Oracle9Dialect:
```
public boolean supportsLimit(); {  
  return true;  
}  

public String getLimitString(String sql); {  
  StringBuffer pagingSelect = new StringBuffer(100);;  
  pagingSelect.append("select * from ( select row_.*, rownum rownum_ from ( ");;  
  pagingSelect.append(sql);;  
  pagingSelect.append(" ); row_ where rownum <= ?); where rownum_ > ?");;  
  return pagingSelect.toString();;  
} 
```
- Oracle采用嵌套3层的查询语句结合rownum来实现分页，这在Oracle上是最快的方式，如果只是一层或者两层的查询语句的rownum不能支持order by。
>










