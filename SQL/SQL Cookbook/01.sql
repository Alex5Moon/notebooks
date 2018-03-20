-- 1 ������¼

-- 1.1 �ӱ��м��������к���
-- Q���鿴���е���������
select * from emp;

-- 1.2 �ӱ��м���������
-- Q���ӱ��в鿴�����ض���������
select * from emp where deptno = 10;

-- 1.3 ������������������
-- Q��Ҫ������������������
select *
  from emp
 where deptno = 10
    or comm is not null
    or sal <= 2000
   and deptno = 20;

select *
  from emp
 where (deptno = 10 or comm is not null or sal <= 2000)
   and deptno = 20;

-- 1.4 �ӱ��м���������
-- Q��Ҫ�鿴һ�������ض��е�ֵ�������������е�ֵ��
select ename, deptno, sal from emp;

-- 1.5 Ϊ��ȡ�����������
-- Q���ı��ѯ�����ص�������ʹ���Ǹ��߿ɶ��ԡ�
select sal as salary, comm as commission from emp;

-- 1.6 ��WHERE�Ӿ�������ȡ��������
select *
  from (select sal as salary, comm as commission from emp) x
 where salary < 5000;

-- 1.7 ������ֵ
select ename || ' works as a ' || job as msg from emp where deptno = 10;
select concat(concat(ename, ' works as a '), job) as msg
  from emp
 where deptno = 10;

-- MySQL 
select concat(ename, ' works as a ', job) as msg
  from emp
 where deptno = 10;

-- 1.8 ��SELECT�����ʹ�������߼�
-- Q���������С��2000���ͷ���UNDERPAID������4000��OVERPAID������OK
select ename,
       sal,
       case
         when sal <= 2000 then
          'UNDERPAID'
         when sal >= 4000 then
          'OVERPAID'
         else
          'OK'
       end as status
  from emp;

-- 1.9 ���Ʒ��ص�����
-- Q: ���Ʋ�ѯ�з��ص����������ﲻ����˳��
-- ORACLE
select * from emp where rownum <= 5;
-- MySQL �� PostgreSQL
select * from emp limit 5;
-- DB2
select *
  from emp fetch first 5 rows only
       -- SQL Server
         select top 5 * from emp;


-- ������ݿ��ṩһЩ�Ӿ䣬���� FETCH FIRST �� LIMIT�����û�ָ���Ӳ�ѯ�з��ص�������
-- Oracle ��������ͬ������ʹ�� ROWNUM �������õ�ÿ�е��к�(�� 1 ��ʼ������ֵ)
-- Oracle �� ROWNUM ��ֵ���ڻ�ȡÿ��֮��Ÿ���ġ�
-- ROWNUM = 5 ������ ��5�� ʧ�ܵ�ԭ����������ص�1�е���4�еĻ����Ͳ����е�5�С�
-- ROWNUM = 1 ȷʵ�Ƿ��ص� 1 �С�

-- 1.10 �ӱ���������� n ����¼
-- Q���ӱ���������� n ����¼��Ҫ���´�ִ��ʱ���ز�ͬ�Ľ������
-- ORACLE  ʹ�� DBMS_RANDOM ���е����ú��� VALUE��ORDER BY �����ú��� ROWNUM��
select *
  from (select ename, job from emp order by dbms_random.value())
 where rownum <= 5;
-- MySQL ͬʱʹ�����õ� RAND ������LIMIT �� ORDER BY 
select ename, job from emp order by rand() limit 5;
-- �� ORDER BY �Ӿ���ָ�����ֳ���ʱ����Ҫ�����SELECT�б�����Ӧλ�õ���������
-- �� ORDER BY �Ӿ���ʹ�ú���ʱ���򰴺�����ÿһ�м���������

-- 1.11 ���ҿ�ֵ
-- Q������ĳ��ֵΪ�յ�������
select * from emp where comm is null;

-- 1.12 ����ֵת��Ϊʵ��ֵ
-- Q��ʹ�÷ǿ�ֵ��������Щ��ֵ  COALESCE ���������������е�DBMS��
select coalesce(comm, 0) from emp;
select nvl(comm, 0) from emp;

-- 1.13 ��ģʽ����
-- Q���ڲ���10�Ͳ���20�У���Ҫ������������һ����I" ���� ְ���д��� "ER" ��Ա��
select ename, job
  from emp
 where deptno in (10, 20)
   and (ename like '%I%' or job like '%ER_');
-- �� LIKE ģʽƥ������У��ٷֺ� "%" ���������ƥ���κ��ַ����С�����SQLʵ����Ҳ�ṩ���»��� "_" ��ƥ�䵥���ַ�    
   
