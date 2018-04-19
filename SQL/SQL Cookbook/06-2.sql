-- 6.8 按字符串中的部分内容排序
-- Q：按照姓名的最后两个字符排序：
-- 解决方案：substr 函数 
select ename ,substr(ename,length(ename)-1) 
  from emp 
 order by substr(ename,length(ename)-1); 

-- 6.9 按字符串中的数值排序
create view v_6_2 as 
       select m.ename||'  '||cast(m.empno as char(4))||'  '||t.dname as data 
        from emp m, dept t
       where m.deptno = t.deptno; 
       
select data,translate(data,'0123456789','##########'),
       replace(
       translate(data,'0123456789','##########'),
                 '#'),
       translate(data,
         replace(
       translate(data,'0123456789','##########'),
                 '#'),rpad('#',20,'#'))            
                 
  from v_6_2 
       order by 
       replace(
       translate(data,
         replace(
       translate(data,'0123456789','##########'),
                 '#'),rpad('#',20,'#')),'#');       
                 
-- 6.10 根据表中的行创建一个分隔列表
-- Q：要求将表中的行作为一个分隔列表中的值，分解符可能是逗号而不是通常使用的竖线。
-- MySQL 使用 group_concat 来构建分隔列表
select deptno,
       group_concat(ename order by empno separator,',') as emps 
  from emp 
 group by deptno;      

-- Oracle 使用 sys_connect_by_path 
select deptno,
       ltrim(sys_connect_by_path(ename,','),',') emps 
  from (
  select deptno,
         ename,
         row_number() over 
                      (partition by deptno order by empno ) rn,
         count(*) over
                  (partition by deptno) cnt 
    from emp 
    ) 
 where level = cnt 
 start with rn = 1 
 connect by prior deptno = deptno and prior rn = rn-1;                                            

-- 要理解Oracle查询，首先要对它进行拆分。
-- 单独运行内联视图，就可以得到每个员工的如下信息：
-- 所在部门、姓名、按empno升序在部门中的序号以及部门员工数 。

select deptno,
       ename,
       row_number() over 
                    (partition by deptno order by empno) rn,
       count(1) over (partition by deptno ) cnt 
  from emp;                  
 
-- 6.11 将分隔数据转化为多值 in 列表
-- Q：已经有了分隔数据，想要将其转换为where子句in列表中的项目。  '7654,7698,7782,7788'
-- MySQL 通过遍历传递给 in 列别的字符串，可以很轻松地将其转换为若干行：
select empno,ename,sal,deptno 
  from emp 
 where empno in (
       select substring_index(
              substring_index(list.vals,',',iter.pos),',',-1) empno 
         from (select id pos from t10 ) iter,
              (select '7654,7698,7782,7788' as vals from t1 ) list 
        where iter.pos <= 
              (length(list.vals)-length(replace(list.vals,',','')))+1
              ) x          

-- Oracle 通过遍历传递给in列表的字符串，可以很轻松地将其转换为若干行。这里函数 rownum、substr 和 instr 
select empno,ename,sal,deptno 
  from emp 
 where empno in (
       select rtrim(
              substr(emps,
               instr(emps,',',1,iter.pos)+1,
               instr(emps,',',1,iter.pos+1)-
               instr(emps,',',1,iter.pos)),',') emps 
         from (select ','||'7654,7698,7782,7788'||',' emps from t1) csv,  
              (select rownum pos from emp ) iter 
        where iter.pos <= ((length(csv.emps)-length(replace(csv.emps,',')))/length(','))-1)                                                                    

-- 6.12 按字母顺序排列字符串
-- Q：对表中的字符串，按照字母顺序排列其中的各个字符。
-- Oracle 使用 sys_connect_by_path 允许以迭代方式构建一张列表
select old_name, new_name 
  from (
  select old_name, replace(sys_connect_by_path(c, ' '),' ') new_name 
    from ( 
    select e.ename old_name,
           row_number() over (partition by e.ename order by substr(e.ename,iter.pos,1)) rn,
           substr(e.ename,iter.pos,1) c
      from emp e,
           (select rownum pos from emp) iter 
     where iter.pos <= length(e.ename) 
     order by 1 
         ) x
   start with rn = 1                     
   connect by prior rn = rn-1 and prior old_name = old_name 
       )
 where  length(old_name) = length(new_name);       

-- MySQL  使用 group_concat 函数，该函数不仅将构成姓名的字符连接起来，还对它们进行排序。
select ename,group_concat(c order by c separator '') 
  from (
  select ename, substr(a.ename,iter.pos,1) c
    from emp a  
         (select id pos from t10 ) iter 
   where iter.pos <= length(a.ename) 
       ) x 
group by ename;

-- 6.13 判别可作为数值的字符串
-- Q：表中的某列已经定义为字符类型数据，遗憾的是，这些行中既有数值数据又有字符数据。
create view v_6_13 as 
    select  replace(mixed,' ','') as mixed  from 
     ( select substr(ename,1,2)||cast(deptno as char(4))||substr(ename,3,2) as mixed
         from emp 
        where deptno = 10 
       union all 
       select cast(empno as char(4)) as mixed
         from emp
        where deptno = 20  
       union all
       select ename as mixed
         from emp 
        where deptno = 30 )  x   ;

select * from v_6_13;        
        
-- MySQL 

-- Oracle 
select case 
         when replace(translate(x.mixed,'0123456789','0000000000'),'0') is not null 
           then 
             replace(
        translate(x.mixed,replace(translate(x.mixed,'0123456789','0000000000'),'0'),rpad('#',length(x.mixed),'#')),'#')
         else
           x.mixed
         end  as numb   
  from v_6_13 x
 where instr(translate(x.mixed,'0123456789','0000000000'),'0')>0 ;

-- 6.14 提取第n个分隔的子串
-- Q：从字符串中提取一个指定的、由分隔符隔开的子字符串
create view v_6_14 
as select 'mo,larry,curly' as name from t1 
union all
   select 'tina,gina,jaunita,regina,leena' as name from t1;

select * from v_6_14;
-- 要取出每行中第二个姓名
select substr(substr(x.name,instr(x.name,',')+1),0,instr(substr(x.name,instr(x.name,',')+1),',')-1) from v_6_14 x;

-- 6.15 分解 IP 地址
-- Q：将一个IP地址字段分解到列中，考虑下面的IP地址
-- 111.22.3.4 
select substr(x.ip,1,instr(x.ip,'.')-1)  as a,
       substr(x.ip,instr(x.ip,'.')+1,
                   instr(x.ip,'.',1,2)-instr(x.ip,'.')-1) as b,
       substr(x.ip,instr(x.ip,'.',1,2)+1,
                   instr(x.ip,'.',1,3)-instr(x.ip,'.',1,2)-1) as c,
       substr(x.ip,instr(x.ip,'.',1,3)+1) as d                               
  from (select '111.22.3.4' as ip from dual ) x 

select instr(x.ip,'.'),instr(x.ip,'.',1,1),instr(x.ip,'.',1,2),instr(x.ip,'.',1,3),x.ip 
  from (select '111.22.3.4' as ip from dual ) x  






























 
