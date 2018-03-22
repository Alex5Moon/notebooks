-- 2 查询结果排序

-- 2.1 以指定的次序返回查询结果
-- Q: 显示部门10中的员工名字、职位和工资，并按照工资的升序排列
select t.ename, t.job, t.sal
  from emp t
 where t.deptno = 10
 order by t.sal asc;

select t.ename, t.job, t.sal
  from emp t
 where t.deptno = 10
 order by t.sal desc;

select t.ename, t.job, t.sal from emp t where t.deptno = 10 order by 3 asc;
-- 不一定要指定排序所基于的列名，也可以给出表示这列的编号。这个编号从1开始，从左到右对应 SELECT 列表中的各项目
select t.ename, t.job, t.sal from emp t order by 3 desc, 1;

-- 2.2 按多个字段排序
-- Q: 在 emp 表中，首先按照 deptno 的升序排序行，然后按工资的降序排序
select t.empno, t.deptno, t.sal, t.ename, t.job
  from emp t
 order by deptno, sal desc;

select t.empno, t.deptno, t.sal, t.ename, t.job
  from emp t
 order by 2, 3 desc;
-- 在 ORDER BY 中，优先次序是从左到右。如果在 SELECT 列表中使用列的数字位置排序，那么，这个数值不能大于SELECT 列表中项目的数目。
-- 一般情况下都可以按照SELECT列表中没有的列来排序，但是必须显示地给出排序的列名。
-- 而如果在查询中使用 GROUP BY 或 DISTINCT，则不能按照SELECT列表中没有的列来排序。

-- 2.3 按子串排序
-- Q：按字符串的某一部分对查询结果排序。例如，要从emp表中返回员工名字和职位，并且按照职位字段的最后两个字符排序
select t.ename, t.job, substr(job, length(job) - 1), length(job)
  from emp t
 order by substr(job, length(job) - 1);
-- 使用 DBMS 的子串函数 substr('20180808',length('20180808')) = '8' 包括起始位置，从1开始

-- 2.4 对字母数字混合的数据排序
-- Q：现有字母和数字混合的数据，希望按照数字或字符部分来排序。考虑这个视图：
create view V as
  select ename || ' ' || deptno as data from emp;
select * from V;
-- 要通过 DEPTNO 或 ENAME 来排序结果。
/* ORDER BY DEPTNO*/
select data,
       translate(data, '0123456789', '##########'),
       replace(translate(data, '0123456789', '##########'), '#', ''),
       replace(data,
               replace(translate(data, '0123456789', '##########'), '#', ''),
               '')
  from v
 order by replace(data,
                  replace(translate(data, '0123456789', '##########'),
                          '#',
                          ''),
                  '');
/* ORDER BY ENAME*/
select data from v order by replace(translate(data,'0123456789','##########'),'#',''); 
-- TRANSLATE 和 REPLACE 函数从每一行中去掉数字或字符，这样就可以很容易地根据具体情况来排序。

-- 2.5 处理排序空值
-- Q：在emp中根据 COMM 排序结果。但是，这个字段可以有空值。需要指定将空值排在最后，或者排在最前。
select ename,sal,comm from emp order by 3;
select ename,sal,comm from emp order by 3 desc;
-- 使用 CASE 表达式来标记"标记"一个值是否为 NULL。这个标记有两个值，一个表示 NULL,一个表示非NULL。
-- 这样，只要在ORDER BY子句中增加标记列，便可以很容易的控制空值是排在前面还是排在最后。                 
select ename,sal,comm from (
   select ename,sal,comm,case when comm is null then 0 else 1 end as is_null 
    from emp 
) x order by is_null desc,comm;
-- ORACLE 9i 以后可以在 ORDER BY 子句中使用 NULLS FIRST 或 NULLS LAST ，来确保 NULL 是首先排序，还是最后排序。
select ename,sal,comm from emp order by comm nulls last;
select ename,sal,comm from emp order by comm nulls first;

-- 2.6 根据数据项的键排序
-- Q：要根据某些条件逻辑来排序。例如，如果JOB是"SALESMAN"，要根据COMM来排序。否则，根据SAL排序。
select ename,sal,job,comm
  from emp 
 order by case when job = 'SALESMAN' then comm else sal end;

-- 可以使用 CASE 表达式来动态改变如何对结果排序。传递给 ORDER BY 的值类似这样：
select ename,sal,job,comm, 
       case when job = 'SALESMAN' then comm else sal end as ordered
  from emp 
  order by 5;       
