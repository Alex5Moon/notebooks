-- 9.日期操作
-- 9.1 确定一年是否为闰年
-- Oracle 使用函数 last_day 
select to_char(
       last_day(add_months(trunc(sysdate,'y'),1)),'DD'),
       trunc(sysdate,'y'),
       add_months(trunc(sysdate,'y'),1),
       last_day(add_months(trunc(sysdate,'y'),1)) 
from dual;       

-- 9.2 确定一年内的天数 
-- Oracle 使用函数 trunc ，找到当前年的第一天，并使用add_months获得下一年的第一天
select add_months(trunc(sysdate,'y'),12) - trunc(sysdate,'y') 
  from dual ;

-- 9.3 从日期中提取时间的各部分
-- Oracle  使用 to_char 和 to_number
select to_char(sysdate,'hh24') hour,
       to_char(sysdate,'mi')   min,
       to_char(sysdate,'ss')   sec,
       to_char(sysdate,'dd')   day,
       to_char(sysdate,'mm')   mth,
       to_char(sysdate,'yyyy') year 
  from dual;
  
-- MySQL 使用 date_format 函数 

-- 9.4 确定某个月的第一天和最后一天 
-- Oracle 使用 trunc 得到第一天，使用 last_day 得到当月最后一天
select trunc(sysdate,'mm') firstday,
       last_day(sysdate)   lastday 
  from dual;     

-- trunc 会丢掉时间部分，而 last_day 将保留时间部分。 

-- MySQL 

-- 9.5 确定一年内属于周内某一天的所有日期 
-- Q：找出一年内属于 星期五的所有日期 
-- Oracle 使用递归 connect by 子句
with x 
  as (
  select trunc(sysdate,'y')+level-1 dy 
    from dual 
    connect by level <= add_months(trunc(sysdate,'y'),12)-trunc(sysdate,'y') 
  )
select * 
  from x 
 where to_char(dy,'dy') = 'fri';   

-- MySQL 

-- 9.6 确定某月内第一个和最后一个“周内某天”的日期
-- Q：找出当前月的第一个星期一及最后一个星期一的日期
-- Oracle 使用函数 next_day 和 last_day 
select next_day(trunc(sysdate,'mm')-1,'MONDAY') first_monday,
       next_day(last_day(trunc(sysdate,'mm'))-7,'MONDAY') last_monday 
  from dual;  

-- MySQL 

-- 9.7 创建日历
-- Oracle 使用 递归的connect by 子句
with x
  as (
  select * from (
     select to_char(trunc(sysdate,'mm')+level-1,'iw') wk,
            to_char(trunc(sysdate,'mm')+level-1,'dd') dm,
            to_number(to_char(trunc(sysdate,'mm')+level-1,'d')) dw,
            to_char(trunc(sysdate,'mm')+level-1,'mm') curr_mth,
            to_char(sysdate,'mm') mth 
       from dual 
      connect by level <= 31 
  ) 
  where curr_mth = mth
 )
select max(case dw when 2 then dm end) Mo,
       max(case dw when 3 then dm end) Tu,
       max(case dw when 4 then dm end) We,
       max(case dw when 5 then dm end) Th,
       max(case dw when 6 then dm end) Fr,
       max(case dw when 7 then dm end) Sa,
       max(case dw when 1 then dm end) Su  
  from x 
 group by wk
 order by wk  

-- 9.8 列出一年中每个季度的开始日期和结束日期
-- Oracle 使用函数 add_months 
select rownum qtr,
       add_months(trunc(sysdate,'y'),(rownum-1)*3) q_start,
       add_months(trunc(sysdate,'y'),rownum*3)-1 q_end 
  from emp 
 where rownum <=4 ;

-- 9.9 确定某个给定季度的开始日期和结束日期
-- Q：对于 yyyyq 格式的年和季度信息，返回该季度的开始日期和结束日期

-- Oracle 使用 substr，返回内联视图 x 中的年，使用 mod 函数确定要查询的季度
select add_months(q_end,-2) q_start,
       last_day(q_end) q_end 
  from (
       select to_date(substr(yrq,1,4)||mod(yrq,10)*3,'yyyymm') q_end 
         from (
              select 20051 yrq from dual union all 
              select 20052 yrq from dual union all
              select 20053 yrq from dual union all
              select 20054 yrq from dual 
         ) x
  ) y;
  
-- MySQL

-- 9.10 填充丢失的日期 

-- 9.11 按照给定的时间单位进行查找

-- 9.12 使用日期的特殊部分比较记录 
-- Q：查找聘用日期月份和周内日期都相同的员工

-- 9.13 识别重叠的日期范围 
-- Q：查找员工在老工程结束之前就开始新工程的所有实例











  

 


