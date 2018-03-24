-- 3 操作多个表

-- 3.1 记录集的叠加
-- Q：要将来自多个表的数据组织到一起，就像将一个结果集叠加到另一个上面一样。这些表不必有相同的关键字，但是，它们对应列的数据类型应相同。
select ename as ename_and_dname,deptno 
  from emp
 where deptno = 10 
union all
select '----------',null 
  from dual 
union all
select dname,deptno 
  from dept; 
-- 注意：UNION ALL 将包括重复的项目。如果要筛选去掉重复项，可以使用 UNION 运算符。
select deptno 
  from emp
union /*all*/
select deptno
  from dept;   

select distinct deptno 
  from (
select deptno 
  from emp
union all
select deptno
  from dept       
       );   

-- 3.2 组合相关的行 
-- 多个表有一些相同列，或有些列的值相同，要通过联接这些列得到结果。例如，要显示部门10中所有员工的名字，以及每个员工所在部门的工作地点。
select m.ename,t.loc 
  from emp m,dept t
 where m.deptno = t.deptno 
 and m.deptno = 10; 
 
-- 该方案是联接的一种，更准确地说是等值联接，这是内联接的一种类型。联接操作会来自两个表的行组合到一个表中。
-- 从概念上讲，要得到联接的结果集，首先要创建FROM子句后列出的表的笛卡尔积。
-- 还有一种解决方案，就是利用显示的JOIN 子句（INNER 关键字可选）      
select m.ename,t.loc
  from emp m inner join dept t 
    on (m.deptno = t.deptno) 
 where m.deptno = 10;
-- 如果希望将联接逻辑放在 FROM 子句中，而不是在 WHERE 子句中，可以使用 JOIN 子句。

-- 3.3 在两个表中查找共同行
-- Q：查找两个表中共同行，但有多列可以来联接的这两个表。例如，考虑下面的视图V：
create view V_1 as
select ename,job,sal 
  from emp 
 where job = 'CLERK' ;  
-- 要返回正确的结果，必须按所有必要的列进行联接。或者，如果不想进行联接，也可以使用集合操作INTERSECT,返回两个表的交集
select m.empno,m.ename,m.job,m.sal,m.deptno 
  from emp m ,v_1 v 
 where m.ename =  v.ename 
   and m.job = v.job 
   and m.sal = v.sal;
   
 select empno,ename,job,sal,deptno 
   from emp 
  where (ename,job,sal) in (
   select ename,job,sal from emp 
   intersect 
   select ename,job,sal from v_1     
  );   
-- 集合操作 INTERSECT 将返回两个行来源中的共同行。在使用 INTERSECT 时，要求两个表的项目数目相同，对应的数据类型也相同。使用集合操作的时候注意，默认情况下，不会返回重复行。

-- 3.4 从一个表中查找另一个表没有的值
-- Q：要从一个表（称之为源表）中查找在另一目标中不存在的值。从 DEPT 中查找在 EMP 中不存在数据的所有部门。
-- ORACLE 使用集合操作 MINUS
select deptno from dept 
minus
select deptno from emp;   
-- MySQL 使用子查询
select deptno 
  from dept 
 where deptno not in (select deptno from emp );
-- 当使用 MySQL 解决方案时，应当考虑如何删除重复行。如果 DEPTNO 不是关键字，可以使用 DISTINCT 子句来确保每个在 EMP 表中没有的DEPTNO 值只在结果中出现一次。
-- 当使用 NOT IN 子句时，一定要注意 NULL 值的问题。考虑下面的表 new_dept:
create table new_dept(deptno integer);
insert into new_dept values (10);
insert into new_dept values (50);
insert into new_dept values (null);

select * 
  from dept
 where deptno not in (select deptno from new_dept );
-- deptno 值为 20、30 和 40 的记录在 new_dept 并不存在，但这个查询没有返回结果。
-- 原因就是 new_dept 中有一个空值。
-- 子查询返回的3行结果集中，deptno 的值 分别为 10、50 和 null。
-- in 和 not in 本质上是 or 运算，因而计算逻辑 or 时处理 null 值的方式不同。
select deptno
  from dept
 where deptno in (10,50,null); 

select deptno
  from dept
 where (deptno=10 or deptno=50 or deptno=null);

-- 在 SQL中，" true or null" 的结果是 true，而 "false or null"的结果是 null！当在结果中有一个 null 值时，null 值就会延续下去。
-- 要解决与not in和null 有关的问题，可以使用 not exists 和相关子查询。
select m.deptno
  from dept m 
 where not exists (select 1 from emp t where t.deptno = m.deptno ); 
 
-- 3.5  在一个表中查找与其他表不匹配的记录
-- Q：对于具有相同关键字的两个表，要在一个表中查找与另外一个表中不匹配的行。要查找没有职员的部门。
-- 使用外联接及null筛选（outer 关键字是可选的）
select m.* 
  from dept m left outer join emp t 
    on (m.deptno = t.deptno) 
 where t.deptno is not null;   
 
--  Oracle 
select m.* 
  from dept m, emp t
 where m.deptno = t.deptno(+)
   and t.deptno is null; 
   
-- 这种解决方案使用外联接，然后只保留不匹配的记录。这种操作有时也被称为反联接。
-- 要想更好地了解反联接的工作机理，首先看看下面这个尚未筛选空值的结果集：
select t.ename,t.deptno as emp_deptno,m.* 
  from dept m left join emp t 
    on (m.deptno = t.deptno); 
-- 注意，表emp中最后一行的ename 和 emp_deptno 字段的值为 null。这是因为 部门40中没有员工。
-- 此解决方案使用where子句只保留emp_deptno字段值为null的行（也就是，在表dept 的行中仅保留表emp不存在的匹配行的部分） 
     
