-- 1 检索记录

-- 1.1 从表中检索所有行和列
-- Q：查看表中的所有数据
select * from emp;

-- 1.2 从表中检索部分行
-- Q：从表中查看满足特定条件的行
select * from emp where deptno = 10;

-- 1.3 查找满足多个条件的行
-- Q：要返回满足多个条件的行
select *
  from emp
 where deptno = 10
    or comm is not null
    or sal <= 2000
   and deptno = 20;

select *
  from emp
 where (deptno = 10 or comm is not null or sal <= 2000)
   and deptno = 20;

-- 1.4 从表中检索部分列
-- Q：要查看一个表中特定列的值，而不是所有列的值。
select ename, deptno, sal from emp;

-- 1.5 为列取有意义的名称
-- Q：改变查询所返回的列名，使它们更具可读性。
select sal as salary, comm as commission from emp;

-- 1.6 在WHERE子句中引用取别名的列
select *
  from (select sal as salary, comm as commission from emp) x
 where salary < 5000;

-- 1.7 连接列值
select ename || ' works as a ' || job as msg from emp where deptno = 10;
select concat(concat(ename, ' works as a '), job) as msg
  from emp
 where deptno = 10;

-- MySQL 
select concat(ename, ' works as a ', job) as msg
  from emp
 where deptno = 10;

-- 1.8 在SELECT语句中使用条件逻辑
-- Q：如果工资小于2000，就返回UNDERPAID，大于4000，OVERPAID，否则，OK
select ename,
       sal,
       case
         when sal <= 2000 then
          'UNDERPAID'
         when sal >= 4000 then
          'OVERPAID'
         else
          'OK'
       end as status
  from emp;

-- 1.9 限制返回的行数
-- Q: 限制查询中返回的行数，这里不关心顺序
-- ORACLE
select * from emp where rownum <= 5;
-- MySQL 和 PostgreSQL
select * from emp limit 5;
-- DB2
select *
  from emp fetch first 5 rows only
       -- SQL Server
         select top 5 * from emp;


-- 许多数据库提供一些子句，比如 FETCH FIRST 和 LIMIT，让用户指定从查询中返回的行数。
-- Oracle 的做法不同，必须使用 ROWNUM 函数来得到每行的行号(从 1 开始递增数值)
-- Oracle 的 ROWNUM 数值是在获取每行之后才赋予的。
-- ROWNUM = 5 来返回 第5行 失败的原因：如果不返回第1行到第4行的话，就不会有第5行。
-- ROWNUM = 1 确实是返回第 1 行。

-- 1.10 从表中随机返回 n 条记录
-- Q：从表中随机返回 n 条记录，要求下次执行时返回不同的结果集。
-- ORACLE  使用 DBMS_RANDOM 包中的内置函数 VALUE、ORDER BY 和内置函数 ROWNUM；
select *
  from (select ename, job from emp order by dbms_random.value())
 where rownum <= 5;
-- MySQL 同时使用内置的 RAND 函数、LIMIT 和 ORDER BY 
select ename, job from emp order by rand() limit 5;
-- 在 ORDER BY 子句中指定数字常量时，是要求根据SELECT列表中相应位置的列来排序，
-- 在 ORDER BY 子句中使用函数时，则按函数在每一行计算结果排序。

-- 1.11 查找空值
-- Q：查找某列值为空的所有行
select * from emp where comm is null;

-- 1.12 将空值转换为实际值
-- Q：使用非空值来代替这些空值  COALESCE 函数可以用于所有的DBMS。
select coalesce(comm, 0) from emp;
select nvl(comm, 0) from emp;

-- 1.13 按模式搜索
-- Q：在部门10和部门20中，需要返回名字中有一个”I" 或者 职务中带有 "ER" 的员工
select ename, job
  from emp
 where deptno in (10, 20)
   and (ename like '%I%' or job like '%ER_');
-- 在 LIKE 模式匹配操作中，百分号 "%" 运算符可以匹配任何字符序列。多数SQL实现中也提供了下划线 "_" 来匹配单个字符    
   
