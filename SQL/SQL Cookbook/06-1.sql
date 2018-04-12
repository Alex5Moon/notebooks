-- 6 使用字符串

-- 6.1 遍历字符串
-- Q：遍历一个字符，并将其中的每个字符都作为一行返回。
-- 解决方案：使用笛卡尔积来生成行号，用来在该行中返回字符串中的每个字符。然后，使用 DBMS 中的内置的字符串分析函数来摘出所要显示的字符。
create table t1 (id integer);
select t.*,t.rowid from t1 t;

select substr('KING',iter.pos,1) as c
  from (select id as pos from t10 ) iter 
 where iter.pos <= length('KING'); 
-- 逐一访问字符串中字符的关键是，所联接的表要有足够的行来得到所需要的反复次数。

-- 6.2 字符串文字中包含引号
select 'g''day mate' qmarks from t1 union all
select 'beavers'' teeth'    from t1 union all 
select ''''                 from t1;

-- 使用引号时，可以将它们当括号看待。如果有一个前括号，也必须有一个相应的后括号，这一原则也适用于引号。
-- 注意，在任何字符串中，必须保持引号个数为偶数。

-- 6.3 计算字符在字符串中出现的次数
-- Q：考虑 10,CLARK,MANAGER 有多少个逗号
-- 解决方案：首先计算出原字符串的长度，然后计算去掉逗号后字符串的长度。这两者的差就是逗号在该字符串中出现的次数。

select (length('10,CLARK,MANAGER')-length(replace('10,CLARK,MANAGER',',','')))/length(',') from t1;

-- 6.4 从字符串中删除不需要的字符 
-- Q：删除所有的 0 和元音字母
-- ORACLE
select ename,
       replace(translate(ename,'AEIOU','aaaaa'),'a') as stripped1,
       sal,
       replace(sal,0,'') as stripped2
  from emp;     

select replace('ABCDEFS','C') from dual;

-- MySQL
select ename,
       replace(
       replace(
       replace(
       replace(
       replace(ename,'A'),'E'),'I'),'O'),'U') as stripped1,
       sal,
       replace(sal,0) as stripped2 
  from emp;    

-- 6.5 将字符和数字数据分离
-- Q：在一列中数字数据和字符数据混合存储在一起，要将这些数据中的数字和字符分离出来。
-- Oracle translate,replace
select replace(translate(data,'0123456789','0000000000'),'0') ename,
       replace(translate(lower(data),'abcdefghijklmnopqrstuvwxyz',rpad('z',26,'z')),'z') sal 
  from (select ename||sal as data from emp ) ;     
select ename||sal from emp;
select length(rpad('z',26,'z')) from dual;

-- 6.6 判别字符串是不是字母数字型的
-- Q：去掉那些包含非字母数字数据的记录
create view v_6 as 
 select ename as data from emp where deptno = 10 
 union all
 select ename||', $'||sal||'.00' as data from emp where deptno = 20 
 union all
 select ename||sal as data from emp where deptno = 30 ;

select * from v_6;
/*
    DATA
    -----------
    CLARK
    KING
    MILLER
    SMITH, $800.00
    JONES, $2975.00
    SCOTT, $3000.00
    ADAMS, $1100.00
    FORD, $3000.00
    ALLEN1600
    WARD1250
    MARTIN1250
    BLAKE2850
    TURNER1500
    JAMES950
*/
-- MySQL  创建视图 字符连接用 concat ，使用正则表达式可以很容易解决

select data from v_6 where data regexp '[^0-9a-zA-Z]' = 0;

-- Oracle
select data 
  from v_6 
 where translate(lower(data),'0123456789abcdefghijklmnopqrstuvwxyz',rpad('a',36,'a')) = rpad('a',length(data),'a'); 

-- 6.7 提取姓名的大写首字母缩写
-- Q： Stewie Griffin           S.G.
select replace(
       replace(
       translate(replace('Stewie Griffin','.',''),
                'abcdefghijklmnopqrstuvwxyz',
                rpad('#',26,'#')),'#',''),' ','.')||'.'  ,
       replace('Stewie Griffin','.',''),
       translate(replace('Stewie Griffin','.',''),
                'abcdefghijklmnopqrstuvwxyz',
                rpad('#',26,'#')) ,                       
       replace(
       translate(replace('Stewie Griffin','.',''),
                'abcdefghijklmnopqrstuvwxyz',
                rpad('#',26,'#')),'#','')
  from t1;     

