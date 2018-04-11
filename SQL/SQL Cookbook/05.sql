-- 5.元数据查询

-- 本章介绍在给定模式中查找信息的有关内容，例如，哪些表已经创建，或者哪些外键没
-- 有被索引。通用的 RDBMS 都有表或视图以提供这些数据。
-- 假定所用模式名为 SMEAGOL   , HZYB_NEW

-- 5.1 列出模式中的表   
-- 模式schema   用户user 
-- 查看在给出的模式中所有已创建的表的清单 
-- ORACLE
select table_name
  from all_tables 
 where owner = 'HZYB_NEW'; 

-- MySQL 
select table_name 
  from information_schema.tables 
 where table_schema = 'SMEAGOL' ;

-- 5.2 列出表的列
-- 列出表的各列、它们的数据类型，以及这些列在表中的位置 
-- ORACLE 
select column_name, data_type, column_id 
  from all_tab_columns 
 where owner = 'HZYB_NEW' 
   and table_name = 'EMP';  
  
-- MySQL
select column_name, data_type, ordinal_position 
  from information_schema.columns 
 where table_schema = 'SMEAGOL'
   and table_name = 'EMP';
   
-- 5.3 列出表的索引列
-- 列出给定表的索引、索引的列以及这些列在索引中的位置（如果可能）

-- ORACLE
select table_name, index_name, column_name, column_position 
  from sys.all_ind_columns 
 where table_name = 'EMP' 
   and table_owner = 'HZYB_NEW'; 

-- MySQL 
show index from emp;

-- 5.4 列出表约束 
-- Q：列出某模式中对某表定义的约束以及这些约束所基于的列。

-- ORACLE 
select t.TABLE_NAME,
       t.CONSTRAINT_NAME,
       x.COLUMN_NAME,
       t.CONSTRAINT_TYPE 
  from all_constraints t, all_cons_columns x 
 where t.OWNER = x.OWNER 
   and t.CONSTRAINT_NAME = x.CONSTRAINT_NAME 
   and t.TABLE_NAME = 'KC25' 
   and t.OWNER = 'HZYB_NEW';
   
-- MySQL



-- 5.5 列出没有相应索引的外键
-- 列出含有没有被索引的外键的表
-- ORACLE 

-- MySQL 

-- 5.6 使用SQL 来生成 SQL 
-- Q：创建动态SQL，使之自动完成维护任务。例如，要完成如下的3个任务：
-- 计算所有表中的行数、禁用所有表中定义的外键约束以及用表中数据生成插入操作脚本 

/* 生成SQL来计算所有表中的行数 */
select 'select count(1) from '||table_name||';' cnts from user_tables ;
    
/* 禁用所有表中的外键 */
select 'alter table '||table_name||' disable constraint '||constraint_name||';' cons 
  from user_constraints 
 where constraint_type = 'R';

/* 根据表 emp 中的某些列生成插入脚本 */
select 'insert into emp(empno,ename,hiredate) values('||empno||','||''''||ename||''',to_date('||''''||hiredate||''') );' 
  from emp 
 where deptno = 10;      
 
 select chr(10) from dual;

-- 5.7 在Oracle 中描述数据字典视图
-- Q：使用的数据库平台为 Oracle，但无法记住可利用的数据字典视图，也记不住列定义，更糟的是，连Oracle的说明文档也找不到了。
-- 查询名为 dictionary 的视图，用来列出数据字典视图和他们的用途
select table_name,comments 
  from dictionary 
 order by table_name; 
 
-- 查询 dict_columns 来描述给出的数据字典视图中的列
select column_name, comments 
  from dict_columns  
 where table_name = 'ALL_TAB_COLUMNS';
 
 
