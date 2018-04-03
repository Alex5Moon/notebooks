-- 3 操作多个表
-- 3.6 向查询中增加联接
-- Q：已经有了一个查询可以返回所需要的值，还需要得到其他的信息，但当加入这些信息时，发现原始结果集中的数据有丢失
-- 例如，要返回所有的员工信息、他们工作部门的地点及所获得的奖励。
-- 在这个问题中，表 EMP_BONUS 包含如下信息。
-- 现要讲每个员工所获得的奖励的日期列加入到结果集中，但是联接到 EMP_BONUS 表后，
-- 所返回的记录数要比所希望的要少，因为并不是每个员工都有奖励：
create table emp_bonus as select empno,hiredate,sal from emp where rownum < 2;
select t.*,t.rowid from emp_bonus t ;

select m.ename, x.loc, y.received 
  from emp m,dept x,emp_bonus y 
 where m.deptno = x.deptno 
   and m.empno = y.empno ;


select m.ename, x.loc, y.received 
  from emp m,dept x,emp_bonus y 
 where m.deptno = x.deptno 
   and m.empno = y.empno(+) 
   order by 2;
   
-- 标量子查询
select m.ename, x.loc, 
       (select received from emp_bonus t where t.empno = m.empno ) as  received 
  from emp m,dept x
 where m.deptno = x.deptno 
   order by 2;
   
-- 3.7 检测两个表中是否有相同的数据
-- Q：要知道两个表或视图中是否有相同的数据（基数和值）
create view v_3 as 
select * from emp where deptno != 10 
union all
select * from emp where ename = 'WARD'; 

select * from v_3;
-- 现要检测这个视图与表EMP中的数据是否完全相同。员工"WARD"行重复，说明解决方案不仅要显示不同行，还要显示重复行。——

-- ORACL 使用集合运算函数 MINUS 和 UNION ALL 求视图 v_3 和表 EMP 的差集，以及表 EMP 和 视图 v_3 的差集，并将两个差集合并。
(
select t.EMPNO,t.ENAME,t.JOB,t.MGR,t.HIREDATE,t.SAL,t.COMM,t.DEPTNO,count(1) as cnt
  from v_3 t   
 group by  t.EMPNO,t.ENAME,t.JOB,t.MGR,t.HIREDATE,t.SAL,t.COMM,t.DEPTNO 
 minus 
select t.EMPNO,t.ENAME,t.JOB,t.MGR,t.HIREDATE,t.SAL,t.COMM,t.DEPTNO,count(1) as cnt
  from emp t   
 group by  t.EMPNO,t.ENAME,t.JOB,t.MGR,t.HIREDATE,t.SAL,t.COMM,t.DEPTNO  
)   
union all 
(
select t.EMPNO,t.ENAME,t.JOB,t.MGR,t.HIREDATE,t.SAL,t.COMM,t.DEPTNO,count(1) as cnt
  from emp t   
 group by  t.EMPNO,t.ENAME,t.JOB,t.MGR,t.HIREDATE,t.SAL,t.COMM,t.DEPTNO 
 minus 
select t.EMPNO,t.ENAME,t.JOB,t.MGR,t.HIREDATE,t.SAL,t.COMM,t.DEPTNO,count(1) as cnt
  from v_3 t   
 group by  t.EMPNO,t.ENAME,t.JOB,t.MGR,t.HIREDATE,t.SAL,t.COMM,t.DEPTNO  
);

-- MySQL 使用关联子查询和UNION ALL来查找在视图V中存在而在表EMP中不存在的行，
-- 然后与在表EMP中存在而在视图V中不存在的行进行合并。

-- 3.8 识别和消除笛卡尔积
-- Q：要返回在部门10中每个员工的姓名，以及部门的工作地点，下面的查询得到的是错误数据：
select m.ename,x.loc 
  from emp m,dept x
  where m.deptno = '10';
-- 查询中，对表EMP的筛选条件是部门为10，结果有3行；因为没有对表DEPT进行筛选，表DEPT的所有4行全部返回，  
-- 3*4 = 12。
-- 一般来说，要避免产生笛卡尔积，需要使用 n-1 规则。
-- n 为 from 子句中表的数量，并且，n-1 是要避免笛卡尔积的最小联接数。
-- 注意：如果笛卡尔积应用适当也很有用。很多查询都用到了笛卡尔积，
-- 常用的场合有转置（反向转置）结果集、产生顺序值和模拟循环等。
   
   
