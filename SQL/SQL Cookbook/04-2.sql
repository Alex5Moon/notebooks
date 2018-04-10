-- 4.11 合并记录
-- Q：根据表中记录存在状况，响应进行插入、更新或删除记录，条件为是否有相应的记录
-- 如果记录存在，则更新；如果不存在，则插入，如果在更新之后不满足特定的条件，删除该记录。
-- 例如，要按下列方式编辑表 emp_commission 中记录：
-- 如果在 emp_commission 中的某员工也存在于表 emp 中，那么将他们的提成更新为1000；
-- 对于已经将其comm 更新到1000的所有员工，如果他们的sal值小于2000，删除他们（这些记录在表emp_commission中将不存在）
-- 否则，从emp表中取出 empno、ename 和 deptn 值，插入到表 emp_commission中。

-- 此问题的实质是想要根据表 emp 中给出的行是否与 表emp_commission 中相应的行匹配，来执行 update 或 insert 操作。
-- 然后根据update的结果来删除那些提成太高的记录。

create table emp_commission as select * from emp where empno in (7782,7839,7934);
select * from emp_commission;

select deptno,empno,ename,comm 
  from emp 
 order by 1; 
 
DEPTNO  EMPNO ENAME                            COMM
------ ------ ------------------------------ ------
    10   7782 CLARK                          
    10   7839 KING                           
    10   7934 MILLER                         
    20   7566 JONES                          
    20   7902 FORD                           
    20   7876 ADAMS                          
    20   7369 SMITH                          
    20   7788 SCOTT                          
    30   7521 WARD                              500
    30   7844 TURNER                              0
    30   7499 ALLEN                             300
    30   7900 JAMES                          
    30   7698 BLAKE                          
    30   7654 MARTIN                           1300

select deptno,empno,ename,comm 
  from emp_commission 
 order by 1;  

DEPTNO  EMPNO ENAME                            COMM
------ ------ ------------------------------ ------
    10   7782 CLARK                          
    10   7934 MILLER                         
    10   7839 KING   

-- 解决方案 ： ORACLE 是目前可以解决的 RDBMS。该语句为 MERGE 

merge into emp_commission ec
using (select * from emp) emp 
   on (ec.empno = emp.empno) 
 when matched then 
      update set ec.comm = 1000 
      delete where (sal<2000) 
 when not matched then 
      insert (ec.empno,ec.ename,ec.deptno,ec.comm) 
      values (emp.empno,emp.ename,emp.deptno,emp.comm) ;          
      
-- 4.12 从表中删除记录 

delete from emp;  -- 当使用不带有 where 子句的 delete 命令时，将会删除指定表中的所有记录。

-- 4.13 删除指定记录

delete from emp where deptno = 10;

-- 4.14 删除单个记录 

delete from emp where empno = 7782; -- 一般按关键字删除

-- 4.15 删除违反参照完整性的记录
-- Q：从表中删除那些记录，它们要引用其他表中不存在的记录，例如，某些员工被分派到一个不存在的部门中，要将这些员工删除。

-- 用谓词 not exists 和子查询 来判别部门号是否合法
delete from emp 
 where not exists (select * from dept where dept.deptno = emp.deptno );

-- 也可以使用谓词 not in 来写
delete from emp 
 where deptno not in (select deptno from dept ); 

-- 4.16 删除重复记录
create table dupes (id integer, name varchar(10));
select t.*,t.rowid from dupes t;

   ID NAME
   ----- ----------
    1 NAPOLEON
    2 DYNAMITE
    3 DYNAMITE
    4 SHE SELLS
    5 SEA SHELLS
    6 SEA SHELLS
    7 SEA SHELLS
    
-- 解决方案：用带有聚集函数的子查询
delete from dupes 
 where id not in (select min(id) from dupes group by name );

-- 4.17 删除从其他表引用的记录 
-- Q：从一个表中删除被另一个表引用的记录
-- 考虑下面的 dept_accidents 表，其中每行代表生产过程中的一次事故，每行中记录了事故发生的部门以及事故类型。
create table dept_accidents (deptno integer,accidents varchar2(20))

select t.*,t.rowid from dept_accidents t;

       DEPTNO ACCIDENTS
       --------- --------------------
           10 BROKEN FOOT
           10 FLESH WOUND
           20 FIRE
           20 FIRE
           20 FLOOD
           30 BRUISED GLUTE

-- 要从表emp 中删除所在部门已经发生三次以上的事故的所有员工记录

-- 使用子查询和聚集函数count 来查找出发生了三次事故以上的部门，然后将这些部门的员工删除掉

delete from emp 
 where deptno in (select deptno from dept_accidents group by deptno having count(1) >= 3 );
 
 
 
 
