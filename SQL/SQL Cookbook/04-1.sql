-- 4 插入、更新与删除
-- 前几章着重介绍了一些基本的查询技术，重点是如何从数据库中获取数据。本章要介绍以下三部分内容：
-- 在数据库中插入新记录
-- 更新已有记录
-- 删除不需要的记录

-- 4.1 插入新记录
insert into dept 
values (50, 'PROGRAMMING', 'BALTIMORE');

-- 4.2 插入默认值
create table D (id integer default 0);

insert into D values (default);

-- 4.3 使用 null 代替默认值
create table D1 (id integer default 0,foo varchar2(10));

insert into d1 values (null, 'Brighten');

-- 4.4 从一个表向另外的表中复制行
create table dept_east as select * from dept where 1 = 0;

insert into dept_east 
select deptno,dname,loc 
  from dept 
 where loc in ('NEW YORK', 'BOSTON'); 
 
-- 4.5 复制表定义
-- Q：要创建新表，该表与已有表的列设置相同。
create table dept_mid as select * from dept where 1 = 0;

-- 4.6 一次向多个表中插入记录
-- Q：要将一个查询中返回的行插入到多个目标表中。 dept_east dept_west dept_mid
-- ORACLE
insert all 
  when loc in ('NEW YORK', 'BOSTON') then
    into dept_east
  when loc = 'CHICAGO' then
    into dept_mid
  else
    into dept_west 
select * from dept;             

-- MySQL 现阶段不支持

-- 4.7 阻止对某几列插入
-- Q：防止用户或是错误的软件应用程序对某几列插入数据
-- 解决方案：在表中创建一个视图，该视图将只显示允许用户进行操作的列，强制所有的插入操作都通过该视图进行。
create view new_emp as select empno, ename, job from emp ;

insert into new_emp values (1, 'Jonathan', 'Editor');
-- 视图的插入操作是一个复杂的话题。除了最简单的视图之外，操作规则变得越来越复杂。

-- 4.8 在表中编辑记录
-- Q：要修改表中某些行的值。例如，将部门20中所有员工的工资增加10%
update emp set sal = sal*1.1 where deptno = 20;

-- 4.9 当相应行存在时更新
-- Q：如果表emp_bonus 中存在某位员工，则要将该员工的工资增加 20%
update emp set sal = sal*1.2 where empno in (select empno from emp_bouns);

-- 4.10 用其他表中值更新
-- Q：要用一个表中的值来更新另外一个表中的行。例如，在表 new_sal 中保存着某个特定员工的新工资。
create table new_sal as select deptno,sal from emp where 1 = 0;
select t.*,t.rowid from new_sal t;
-- 在表 new_sal 中，deptno 为主关键字。要用表 new_sal 中的值更新表 emp 中相应员工的工资。
-- 条件是 emp.deptno 与 new_sal.deptno 相等，将匹配记录的 emp.sal 更新为 new_sal.sal,将 emp.comm 更新为 new_sal.sal 的 50%

-- MySQL
update emp t set (t.sal,t.comm) = (select m.sal,m.sal/2 from new_sal m where m.deptno = t.deptno ) 
where exists (select 1 from new_sal m where m.deptno = t.deptno );

select * from emp t where exists (select 1 from new_sal m where m.deptno = t.deptno );

-- Oracle 还可以使用内联视图进行更新 

update ( 
 select t.sal as emp_sal, t.comm as emp_comm,
        m.sal as ns_sal, m.sal/2 as ns_comm 
   from emp t,new_sal m 
  where t.deptno = m.deptno )
set emp_sal = ns_sal,emp_comm = ns_comm;  
-- cannot modify a column which maps to a non-key-preserved table  
-- 

CREATE UNIQUE INDEX emp_idx_001 ON emp (empno);

-- merge方式：

MERGE INTO emp_merge USING new_sal 

ON (emp_merge.deptno = new_sal.deptno)

WHEN MATCHED THEN UPDATE

  SET emp_merge.sal = new_sal.sal,emp_merge.comm = new_sal.sal/2;

create table emp_merge as select * from emp;  

select * from emp_merge;
(select * from emp 
minus
select * from emp_merge 
) 
 union all 
(select * from emp_merge 
minus
select * from emp);

-- merge方法是最简洁，效率最高的方式，在大数据量更新时优先使用这种方式 

-- 使用并行，加快大量数据更新：

-- MERGE /*+parallel(test1,4)*/ INTO test1 USING test2

-- ON (test1.id = test2.id)

-- WHEN MATCHED THEN UPDATE

--  SET test1.name = NVL2(test1.name,test2.name,test1.name); 
  
  
  
