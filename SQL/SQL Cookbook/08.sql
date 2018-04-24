-- 8. 日期运算
-- 8.1 加减日、月、年
-- Oracle  对天数采用标准加减，而使用add_months 函数加减月数和年数
select hiredate-5 as hd_minus_5D,
       hiredate+5 as hd_plus_5D,
       add_months(hiredate,-5) as hd_minus_5M,
       add_months(hiredate,5) as hd_plus_5M,
       add_months(hiredate,-5*12) as hd_minus_5Y,
       add_months(hiredate,5*12) as hd_plus_5Y 
  from emp t
 where deptno = 10 ;
 
-- 8.2 计算两个日期之间的天数
-- Oracle  使用两个内联视图求ward和allen的hiredate 
select ward_hd-allen_hd 
  from (select hiredate as ward_hd from emp where ename = 'WARD' ) X,
       (select hiredate as allen_hd from emp where ename = 'ALLEN' ) y;

-- 8.3 确定两个日期之间的工作日数目


-- 8.4 确定两个日期之间的月份数或年数
-- Oracle 使用 months_between 
select months_between(max_hd,min_hd) ,
       months_between(max_hd,min_hd)/12 
  from (
       select min(hiredate) min_hd, max(hiredate) max_hd from emp
  )   ;  

-- 8.5 确定两个日期之间的秒、分、小时数 
-- oracle 使用减法操作，将返回的天数进行乘法操作

-- 8.6 计算一年中周内个日期的次数 


-- 8.7 确定当前记录和下一条记录之间相差的天数 
-- Oracle 使用窗口函数 lead over
select ename,hiredate,next_id,
       next_id-hiredate diff  
  from (
       select deptno,ename,hiredate, 
              lead(hiredate) over(order by hiredate) next_id 
         from emp     
  )
 where deptno = 10;  







 
 
 
 

