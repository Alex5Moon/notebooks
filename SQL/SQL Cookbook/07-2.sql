-- 7.7 生成累乘积 
-- Q：计算某个数字列的累乘积
-- oracle 使用窗口函数 sum over，用对数相加来模拟乘法操作
select empno,ename,sal,
       round(exp(sum(ln(sal)) over (order by sal,empno)),0) as running_prod 
  from emp 
 where deptno = 10; 
-- 在 SQL中，对小于等于0的值取对数是无效的。如果表中包含这样的值，一定要避免把这些无效的值传递给SQL的ln函数。
-- 如果一定要用到负值和0值，那么这种解决方案不合适。

-- oracle独有的一种是10g新引入的 model 子句。
select empno, ename, sal, tmp as running_prod 
  from (
       select empno,ename,-sal as sal 
         from emp 
        where deptno = 10  
  )
 model 
     dimension by (row_number() over (order by sal desc) rn)
     measures(sal, 0 tmp, empno, ename) 
     rules (
           tmp[any] = case when sal[cv()-1] is null then sal[cv()] 
                            else tmp[cv()-1]*sal[cv()] 
                       end        
     );

-- MySQL 使用标量子查询取代窗口函数
select t.empno,t.ename,t.sal,
       round((select exp(sum(ln(d.sal))) 
          from emp d 
         where d.empno <= t.empno 
           and d.deptno = t.deptno ),0) as running_prod 
  from emp t
 where t.deptno = 10; 

-- 所有解决方案都利用了乘法运算的特性，按下列步骤用加法进行计算
-- 1. 计算各自的自然对数
-- 2. 计算这些对数的和
-- 3. 对结果进行数学常量e的幂运算
-- 对于0值和负值，这种方法不可行。

-- 7.8 计算累计差
-- Oracle 
select t.ename,t.sal,
       sum(case when rn = 1 then sal else -sal end) 
        over(order by sal,empno) as running_diff
  from (
     select empno,ename,sal,
            row_number() over(order by sal,empno) as rn 
       from emp   
      where deptno = 10  
  ) t;

-- MySQL 使用标量子查询
select t.empno,t.ename,t.sal,
       (select case when t.empno= min(t.empno) then sum(x.sal) else sum(-x.sal) end 
          from emp x 
         where x.empno <= t.empno 
           and x.deptno = t.deptno  ) as rnk 
  from emp t 
 where t.deptno = 10; 
 
-- 7.9  计算模式 
-- Q：查询某个列中出现频率最高的值
select sal 
  from emp 
 where deptno = 20 
 group by sal 
having count(1)>= all (select count(1) from emp where deptno = 20 group by sal) ;

--7.10 计算中间值 
-- oracle 
select median(t.sal)
  from emp t 
 where deptno = 20; 

-- 7.11 求总和的百分比
select distinct (d10/total)*100 as pct 
  from (
       select deptno,
              sum(sal)over() total,
              sum(sal)over(partition by deptno) d10 
         from emp 
  ) x 
 where deptno = 10; 

-- 7.12 对可空列作聚集
-- 对某列进行聚集运算，但该列的值可为空，由于函数会忽略null值，能否保持聚集运算的准确性令人担忧。
select avg(comm),avg(nvl(comm,0)),sum(comm)/count(1) 
  from emp  
 where deptno = 30; 

-- 7.13 计算不包含最大值和最小值的均值
-- MySQL
select avg(sal) 
  from emp 
 where sal not in ((select max(sal) from emp),(select  min(sal) from emp ) ) ;

-- oracle 
-- 使用内联视图及窗口函数max over 和 min over
select avg(sal) 
  from (
     select sal,min(sal) over() min_sal,max(sal)over() max_sal 
       from emp   
  ) x 
 where sal not in (min_sal,max_sal) ;
 
-- 

select (sum(sal)-min(sal)-max(sal))/(count(1)-2) 
  from emp; 

-- 7.14 把字母数字串转换为数值
-- 使用translate 和 replace 
select translate('paul123f321','abcdefghijklmnopqrstuvwxyz',rpad('#',26,'#')),
       replace(translate('paul123f321','abcdefghijklmnopqrstuvwxyz',rpad('#',26,'#')),'#') as num
  from dual;

select rpad('#',26,'#') from dual;


-- 7.15 更改累计和中的值

 
