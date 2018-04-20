-- 7. 使用数字

-- 7.1 计算平均值 
-- Q：计算所有职员的平均工资以及每个部门的平均工资 

-- 不带 where 子句时，会对所有的 非null 工资值计算平均值 

select avg(sal) as avg_sal 
  from emp;
  
select t.deptno,avg(sal) as avg_sal  
  from emp t 
 group by t.deptno; 

-- 注意： avg 函数会忽略 null 值，下面给出了忽略 null 值的效果：
create table t2(sal integer);
insert into t2 values (10);
insert into t2 values (20);
insert into t2 values (null);

select avg(t.sal),30/2,sum(sal)/count(1) 
  from t2 t ;

-- avg() >= sum()/count(1) 

-- 7.2 求某列中的最小、最大值
-- Q：计算所有职工的最高工资和最低工资，以及每个部门的最高工资和最低工资
select max(sal) as max_sal,min(sal) as min_sal 
  from emp;  

select deptno,max(sal) as max_sal,min(sal) as min_sal 
  from emp 
 group by deptno; 

-- min 和 max 函数会忽略null，而且允许包含null组，组中的列也允许null值。
select deptno,comm 
  from emp 
 where deptno in(10,30) 
 order by 1; 

select min(t.comm),max(t.comm)
  from emp t ;

select t.deptno,min(t.comm),max(t.comm)
  from emp t  
 group by t.deptno; 

DEPTNO MIN(T.COMM) MAX(T.COMM)
------ ----------- -----------
    30           0        1300
    20             
    10             


-- 7.3 对某列的值求和
-- Q：计算所有职工的工资总额
select sum(sal) 
  from emp;

select t.deptno,sum(t.sal) as total_for_dept 
  from emp t
 group by t.deptno ;  

-- sum函数会忽略null，但可以存在null组
select deptno,sum(comm)
  from emp t 
 where deptno in (10,30) 
 group by t.deptno; 

DEPTNO  SUM(COMM)
------ ----------
    30       2100
    10 

-- 7.4 求一个表的行数
select count(1)
  from emp t  ;

select deptno,count(1)  
  from emp t 
 group by t.deptno; 
 
-- 注意：当把列名作为参数传递给 count 函数时，就会忽略null值；
--      但如果传递常量或 "*" 字符，则包含 null 
select count(1),count(*),count(comm)
  from emp t ;
  
  COUNT(1)   COUNT(*) COUNT(COMM)
---------- ---------- -----------
        14         14           4
        
select count(1),count(sal) 
  from t2;         
  
-- 7.5 求某列值的个数
-- Q：计算某个列中非 null 值的个数 
select count(comm) 
  from emp t   ;
  
-- 7.6 生成累计和
-- Q：计算某个列中所有值的累计和
-- Oracle  使用窗口版本的 sum 函数计算累计和 
select t.ename,
       t.sal,
       sum(t.sal) over (order by sal,empno) as running_total 
  from emp t 
 order by 2; 
 
ENAME                             SAL RUNNING_TOTAL
------------------------------ ------ -------------
SMITH                             800           800
JAMES                             950          1750
ADAMS                            1100          2850
WARD                             1250          4100
MARTIN                           1250          5350
MILLER                           1300          6650
TURNER                           1500          8150
ALLEN                            1600          9750
CLARK                            2450         12200
BLAKE                            2850         15050
JONES                            2975         18025
SCOTT                            3000         21025
FORD                             3000         24025
KING                             5000         29025

-- MySQL 

-- 7.7 生成累计积
 
