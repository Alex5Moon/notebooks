-- 3 操作多个表
-- 3.9 聚集与联接
-- Q：要在包含多个表的查询中执行聚集运算，要确保表间联接不能使聚集运算发生错误。
-- 例如，要查找在部门10中所有员工的工资合计和奖金合计。由于有些员工的奖金记录不止一条，
-- 在表 emp 和 emp_bonus_1 之间做联接会导致聚集函数 sum 算得的值错误。
create table emp_bonus_1 as select * from emp_bonus where rownum < 1 ;
select t.*,t.rowid from emp_bonus_1 t;
select t.empno,
       t.ename,
       t.sal,
       t.deptno,
       t.sal*case when m.type = 1 then .1 
                  when m.type = 2 then .2 
                  else .3 
             end as bonus          
  from emp t,emp_bonus_1 m 
 where t.empno = m.empno 
   and t.deptno = 10;
-- 进行到这，一切正常，然而，为了计算奖金总数而跟 emp_bonus_1 做联接时，错误出现了
select deptno,
       sum(sal) as total_sal,
       sum(bonus) as total_bonus 
  from (       
  select t.empno,
       t.ename,
       t.sal,
       t.deptno,
       t.sal*case when m.type = 1 then .1 
                  when m.type = 2 then .2 
                  else .3 
             end as bonus  
    from emp t,emp_bonus_1 m 
   where t.empno = m.empno 
     and t.deptno = 10 
       ) x 
group by deptno;       

-- 尽管 total_bonus 的值是正确的，total_sal 却是错误的。
-- total_sal 为什么错了？
-- 因为联接导致 sal 列存在重复。MILLER 的工资被统计了两次。
-- 解决方案：
-- 当处理聚集与联接混合操作时，一定要小心。如果联接产生重复行，可以有两种方法避免聚集函数计算错误：
-- 一、只要在调用聚集函数时使用关键字 distinct，这样每个值只参与一次计算
-- 二、在进行联接前先执行聚集操作
-- MySQL
select deptno,
       sum(distinct  sal) as total_sal,
       sum(bonus) as total_bonus 
  from (       
  select t.empno,
       t.ename,
       t.sal,
       t.deptno,
       t.sal*case when m.type = 1 then .1 
                  when m.type = 2 then .2 
                  else .3 
             end as bonus  
    from emp t,emp_bonus_1 m 
   where t.empno = m.empno 
     and t.deptno = 10 
       ) x 
group by deptno;     

-- ORACLE 窗口函数  也支持上面的方案，还支持一种使用窗口函数 SUM OVER 

select distinct deptno,total_sal,total_bonus 
  from (
  select t.empno,
         t.ename,
         sum(distinct t.sal ) over 
         (partition by t.deptno) as total_sal,
         t.deptno,
         sum(t.sal*case when m.type = 1 then .1 
                        when m.type = 2 then .2
                        else .3 end) over 
         (partition by deptno) as total_bonus                  
    from emp t,emp_bonus_1 m 
   where t.empno = m.empno  
     and t.deptno = 10 
        ) x
        
-- 3.10 聚集与外联接
-- Q：问题的开始与3.9节一样，区别在于，修改 emp_bouns 表，使得 部门10 中不是每个员工都有奖金。
create table emp_bonus_2 as select * from emp_bonus_1;
select t.*,t.rowid from emp_bonus_2 t;
select deptno,
       sum(distinct  sal) as total_sal,
       sum(bonus) as total_bonus 
  from (       
  select t.empno,
       t.ename,
       t.sal,
       t.deptno,
       t.sal*case when m.type is null then 0 
                  when m.type = 1 then .1 
                  when m.type = 2 then .2 
                  else .3 
             end as bonus  
    from emp t,emp_bonus_2 m 
   where t.empno = m.empno(+)
     and t.deptno = 10 
       ) x 
group by deptno; 

-- 3.11 从多个表中返回丢失的数据
-- Q：同时返回多个表中丢失的数据。要从 DEPT 中返回 EMP 不存在的行（所有没有员工的部门）需要做外联接。
-- 考虑下面的查询，它返回表 DEPT 中的 DEPTNO 和 DNAME 字段，以及每个部门中所有员工的姓名（如果该某个部门有员工的话）：
select m.deptno,m.dname,t.ename
  from dept m left outer join emp t 
    on (m.deptno = t.deptno);

select m.deptno,m.dname,t.ename
  from dept m , emp t 
 where m.deptno = t.deptno(+);   

/*
  20	RESEARCH	  SMITH
  30	SALES	      ALLEN
  30	SALES	      WARD
  20	RESEARCH	  JONES
  30	SALES	      MARTIN
  30	SALES	      BLAKE
  10	ACCOUNTING	CLARK
  20	RESEARCH	  SCOTT
  10	ACCOUNTING	KING
  30	SALES	      TURNER
  20	RESEARCH	  ADAMS
  30	SALES	      JAMES
  20	RESEARCH	  FORD
  10	ACCOUNTING	MILLER
  40	OPERATIONS	 
  */ 

-- 最后一行 OPERATIONS 部门，尽管该部门没有员工，还是返回了这一行，
-- 因为 emp 被外联接到了表 dept 。
-- 现在，假设有一个员工没有部门，那么如何得到在上述的结果集，并为该没有部门的员工返回一行？
-- 换句话说，要在一个查询中同时外联接到 emp 和 dept  
insert into emp select 1111,'YODA','JEDI',null,hiredate,sal,comm,null from emp where ename = 'KING';

select m.deptno,m.dname,t.ename
  from dept m right outer join emp t 
    on (m.deptno = t.deptno);

select m.deptno,m.dname,t.ename
  from dept m , emp t 
 where m.deptno(+) = t.deptno;  
        
/*
  10	ACCOUNTING	MILLER
  10	ACCOUNTING	KING
  10	ACCOUNTING	CLARK
  20	RESEARCH	  FORD
  20	RESEARCH	  ADAMS
  20	RESEARCH	  SCOTT
  20	RESEARCH	  JONES
  20	RESEARCH	  SMITH
  30	SALES	      JAMES
  30	SALES	      TURNER
  30	SALES	      BLAKE
  30	SALES	      MARTIN
  30	SALES	      WARD
  30	SALES	      ALLEN
                  YODA 
*/

-- 解决方案： 使用基于公共值的完全外联接来返回两个表中丢失的数据 
-- MySQL  使用 full outer join 
select m.deptno,m.dname,t.ename
  from dept m full outer join emp t 
    on (m.deptno = t.deptno);
-- 或者合并两个外联接的结果 

select m.deptno,m.dname,t.ename
  from dept m left outer join emp t 
    on (m.deptno = t.deptno)
union 
select m.deptno,m.dname,t.ename
  from dept m right outer join emp t 
    on (m.deptno = t.deptno)       
    
    
/*
    10	ACCOUNTING	CLARK
    10	ACCOUNTING	KING
    10	ACCOUNTING	MILLER
    20	RESEARCH	  ADAMS
    20	RESEARCH	  FORD
    20	RESEARCH	  JONES
    20	RESEARCH	  SCOTT
    20	RESEARCH	  SMITH
    30	SALES	      ALLEN
    30	SALES	      BLAKE
    30	SALES	      JAMES
    30	SALES	      MARTIN
    30	SALES	      TURNER
    30	SALES	      WARD
    40	OPERATIONS	
                    YODA     
*/
-- ORACLE9i 及以后使用上述两种方案都可以
 
select m.deptno,m.dname,t.ename
  from dept m , emp t 
 where m.deptno(+) = t.deptno
union
select m.deptno,m.dname,t.ename
  from dept m , emp t 
 where m.deptno = t.deptno(+) ;

-- 3.12 在运算和比较时使用 NULL 值 
-- Q：null 值 永远不会等于或不等于任何值，也包括 null 值自己，但是需要像计算真实值一样计算可为空列的返回值。
-- 例如，需要在表 emp 中查出所有比 “WARD” 提成（COMM）低的员工
-- 解决方案： 使用 COALESCE 函数
select ename,comm,coalesce(comm,0) 
  from emp 
 where coalesce(comm,0) < (select comm from emp where ename = 'WARD') 

