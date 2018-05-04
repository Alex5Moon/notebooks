-- 10. 范围处理
-- 10.1 定位连续值的范围 
create table v_10 ( 
       pro_id number(10),
       pro_start number(8),
       pro_end number(8)
);

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('1', '20050101', '20050102');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('2', '20050102', '20050103');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('3', '20050103', '20050104');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('4', '20050104', '20050105');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('5', '20050106', '20050107');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('6', '20050116', '20050117');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('7', '20050117', '20050118');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('8', '20050118', '20050119');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('9', '20050119', '20050120');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('10', '20050121', '20050122');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('11', '20050126', '20050127');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('12', '20050127', '20050128');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('13', '20050128', '20050129');

insert into v_10 (PRO_ID, PRO_START, PRO_END)
values ('14', '20050129', '20050130');

-- Q：找到连续工作的日期：
-- MySQL 使用自联查找包含连续值的行
select a1.*
  from v_10 a1,v_10 a2 
 where a1.pro_end = a2.pro_start; 

-- oracle：使用窗口函数
select pro_id,pro_start,pro_end from (
select t.pro_id,t.pro_start,t.pro_end,
       lead(pro_start)over(order by t.pro_id) next_pro_start
  from v_10 t )
 where pro_end = next_pro_start; 
 
-- 10.2 查找同一组或分区中行之间的差
-- Q：返回每个员工的 deptno，ename，sal 以及与同一部分的员工间的sal之差
-- MySQL 使用标量子查询，检索紧随各员工之后聘用的员工的hiredate。然后，使用另一个标量子查询，查找这个（后聘用）员工的工资。
select 
  from emp e 

