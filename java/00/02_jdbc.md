## JDBC
- Java数据库连接，（Java Database Connectivity，简称JDBC）是Java语言中用来规范客户端程序如何来访问数据库的应用程序接口，提供了诸如查询和更新数据库中数据的方法。
- 数据持久化（固化）层，hibernate、mybatis等
### 一般步骤
- 1 利用Class.forName()方法来加载JDBC驱动程序（Driver）至DriverManager：
```
  Class.forName( "com.somejdbcvendor.TheirJdbcDriver" );
```
>
- 2 然后，从DriverManager中，通过JDBC URL，用户名，密码来获取相应的数据库连接（Connection）：
```
  Connection conn = DriverManager.getConnection( 
        "jdbc:somejdbcvendor:other data needed by some jdbc vendor", // URL
        "myLogin", // 用户名
        "myPassword" ); // 密码
```
- 3 获取连接成功后，准备SQL语句，对数据库进行相应的操作：查询、新增、更新、删除、调用函数等。
- Statement：用以执行SQL查询和更新（针对静态SQL语句和单次执行）。
- PreparedStatement：用以执行包含动态参数的SQL查询和更新（在服务器端编译，允许重复执行以提高效率）。
- CallableStatement：用以调用数据库中的存储过程。
>
- 4 关闭连接
>
### 经常连接关闭，消耗资源比较大，利用连接池来操作。
-
>
### 事务
```
  boolean autoCommitDefault = conn.getAutoCommit();
  try {
      conn.setAutoCommit(false);

      /* 在此基于有事务控制的conn执行你的代码 */

      conn.commit();
  } catch (Throwable e) {
      try { conn.rollback(); } catch (Throwable ignore) {}
      throw e;
  } finally {
      try { conn.setAutoCommit(autoCommitDefault); } catch (Throwable ignore) {}
  }
```
- 原子性：事务是一个完整的过程，要么都成功，要么都失败。
- 一致性：事务前后的数据要一致，即收支平衡(总和不变)。
- 隔离性：事务过程中的数据不能被访问。
- 持久性：事务一旦达成，就永久有效，不能否认。
>


