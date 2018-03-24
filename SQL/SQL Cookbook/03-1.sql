-- 3 ���������

-- 3.1 ��¼���ĵ���
-- Q��Ҫ�����Զ�����������֯��һ�𣬾���һ����������ӵ���һ������һ������Щ��������ͬ�Ĺؼ��֣����ǣ����Ƕ�Ӧ�е���������Ӧ��ͬ��
select ename as ename_and_dname,deptno 
  from emp
 where deptno = 10 
union all
select '----------',null 
  from dual 
union all
select dname,deptno 
  from dept; 
-- ע�⣺UNION ALL �������ظ�����Ŀ�����Ҫɸѡȥ���ظ������ʹ�� UNION �������
select deptno 
  from emp
union /*all*/
select deptno
  from dept;   

select distinct deptno 
  from (
select deptno 
  from emp
union all
select deptno
  from dept       
       );   

-- 3.2 �����ص��� 
-- �������һЩ��ͬ�У�����Щ�е�ֵ��ͬ��Ҫͨ��������Щ�еõ���������磬Ҫ��ʾ����10������Ա�������֣��Լ�ÿ��Ա�����ڲ��ŵĹ����ص㡣
select m.ename,t.loc 
  from emp m,dept t
 where m.deptno = t.deptno 
 and m.deptno = 10; 
 
-- �÷��������ӵ�һ�֣���׼ȷ��˵�ǵ�ֵ���ӣ����������ӵ�һ�����͡����Ӳ��������������������ϵ�һ�����С�
-- �Ӹ����Ͻ���Ҫ�õ����ӵĽ����������Ҫ����FROM�Ӿ���г��ı�ĵѿ�������
-- ����һ�ֽ������������������ʾ��JOIN �Ӿ䣨INNER �ؼ��ֿ�ѡ��      
select m.ename,t.loc
  from emp m inner join dept t 
    on (m.deptno = t.deptno) 
 where m.deptno = 10;
-- ���ϣ���������߼����� FROM �Ӿ��У��������� WHERE �Ӿ��У�����ʹ�� JOIN �Ӿ䡣

-- 3.3 ���������в��ҹ�ͬ��
-- Q�������������й�ͬ�У����ж��п��������ӵ������������磬�����������ͼV��
create view V_1 as
select ename,job,sal 
  from emp 
 where job = 'CLERK' ;  
-- Ҫ������ȷ�Ľ�������밴���б�Ҫ���н������ӡ����ߣ��������������ӣ�Ҳ����ʹ�ü��ϲ���INTERSECT,����������Ľ���
select m.empno,m.ename,m.job,m.sal,m.deptno 
  from emp m ,v_1 v 
 where m.ename =  v.ename 
   and m.job = v.job 
   and m.sal = v.sal;
   
 select empno,ename,job,sal,deptno 
   from emp 
  where (ename,job,sal) in (
   select ename,job,sal from emp 
   intersect 
   select ename,job,sal from v_1     
  );   
-- ���ϲ��� INTERSECT ��������������Դ�еĹ�ͬ�С���ʹ�� INTERSECT ʱ��Ҫ�����������Ŀ��Ŀ��ͬ����Ӧ����������Ҳ��ͬ��ʹ�ü��ϲ�����ʱ��ע�⣬Ĭ������£����᷵���ظ��С�

-- 3.4 ��һ�����в�����һ����û�е�ֵ
-- Q��Ҫ��һ������֮ΪԴ���в�������һĿ���в����ڵ�ֵ���� DEPT �в����� EMP �в��������ݵ����в��š�
-- ORACLE ʹ�ü��ϲ��� MINUS
select deptno from dept 
minus
select deptno from emp;   
-- MySQL ʹ���Ӳ�ѯ
select deptno 
  from dept 
 where deptno not in (select deptno from emp );
-- ��ʹ�� MySQL �������ʱ��Ӧ���������ɾ���ظ��С���� DEPTNO ���ǹؼ��֣�����ʹ�� DISTINCT �Ӿ���ȷ��ÿ���� EMP ����û�е�DEPTNO ֵֻ�ڽ���г���һ�Ρ�
-- ��ʹ�� NOT IN �Ӿ�ʱ��һ��Ҫע�� NULL ֵ�����⡣��������ı� new_dept:
create table new_dept(deptno integer);
insert into new_dept values (10);
insert into new_dept values (50);
insert into new_dept values (null);

select * 
  from dept
 where deptno not in (select deptno from new_dept );
-- deptno ֵΪ 20��30 �� 40 �ļ�¼�� new_dept �������ڣ��������ѯû�з��ؽ����
-- ԭ����� new_dept ����һ����ֵ��
-- �Ӳ�ѯ���ص�3�н�����У�deptno ��ֵ �ֱ�Ϊ 10��50 �� null��
-- in �� not in �������� or ���㣬��������߼� or ʱ���� null ֵ�ķ�ʽ��ͬ��
select deptno
  from dept
 where deptno in (10,50,null); 

select deptno
  from dept
 where (deptno=10 or deptno=50 or deptno=null);

-- �� SQL�У�" true or null" �Ľ���� true���� "false or null"�Ľ���� null�����ڽ������һ�� null ֵʱ��null ֵ�ͻ�������ȥ��
-- Ҫ�����not in��null �йص����⣬����ʹ�� not exists ������Ӳ�ѯ��
select m.deptno
  from dept m 
 where not exists (select 1 from emp t where t.deptno = m.deptno ); 
 
-- 3.5  ��һ�����в�����������ƥ��ļ�¼
-- Q�����ھ�����ͬ�ؼ��ֵ�������Ҫ��һ�����в���������һ�����в�ƥ����С�Ҫ����û��ְԱ�Ĳ��š�
-- ʹ�������Ӽ�nullɸѡ��outer �ؼ����ǿ�ѡ�ģ�
select m.* 
  from dept m left outer join emp t 
    on (m.deptno = t.deptno) 
 where t.deptno is not null;   
 
--  Oracle 
select m.* 
  from dept m, emp t
 where m.deptno = t.deptno(+)
   and t.deptno is null; 
   
-- ���ֽ������ʹ�������ӣ�Ȼ��ֻ������ƥ��ļ�¼�����ֲ�����ʱҲ����Ϊ�����ӡ�
-- Ҫ����õ��˽ⷴ���ӵĹ����������ȿ������������δɸѡ��ֵ�Ľ������
select t.ename,t.deptno as emp_deptno,m.* 
  from dept m left join emp t 
    on (m.deptno = t.deptno); 
-- ע�⣬��emp�����һ�е�ename �� emp_deptno �ֶε�ֵΪ null��������Ϊ ����40��û��Ա����
-- �˽������ʹ��where�Ӿ�ֻ����emp_deptno�ֶ�ֵΪnull���У�Ҳ���ǣ��ڱ�dept �����н�������emp�����ڵ�ƥ���еĲ��֣� 
     
