-- 2 ��ѯ�������

-- 2.1 ��ָ���Ĵ��򷵻ز�ѯ���
-- Q: ��ʾ����10�е�Ա�����֡�ְλ�͹��ʣ������չ��ʵ���������
select t.ename, t.job, t.sal
  from emp t
 where t.deptno = 10
 order by t.sal asc;

select t.ename, t.job, t.sal
  from emp t
 where t.deptno = 10
 order by t.sal desc;

select t.ename, t.job, t.sal from emp t where t.deptno = 10 order by 3 asc;
-- ��һ��Ҫָ�����������ڵ�������Ҳ���Ը�����ʾ���еı�š������Ŵ�1��ʼ�������Ҷ�Ӧ SELECT �б��еĸ���Ŀ
select t.ename, t.job, t.sal from emp t order by 3 desc, 1;

-- 2.2 ������ֶ�����
-- Q: �� emp ���У����Ȱ��� deptno �����������У�Ȼ�󰴹��ʵĽ�������
select t.empno, t.deptno, t.sal, t.ename, t.job
  from emp t
 order by deptno, sal desc;

select t.empno, t.deptno, t.sal, t.ename, t.job
  from emp t
 order by 2, 3 desc;
-- �� ORDER BY �У����ȴ����Ǵ����ҡ������ SELECT �б���ʹ���е�����λ��������ô�������ֵ���ܴ���SELECT �б�����Ŀ����Ŀ��
-- һ������¶����԰���SELECT�б���û�е��������򣬵��Ǳ�����ʾ�ظ��������������
-- ������ڲ�ѯ��ʹ�� GROUP BY �� DISTINCT�����ܰ���SELECT�б���û�е���������

-- 2.3 ���Ӵ�����
-- Q�����ַ�����ĳһ���ֶԲ�ѯ����������磬Ҫ��emp���з���Ա�����ֺ�ְλ�����Ұ���ְλ�ֶε���������ַ�����
select t.ename, t.job, substr(job, length(job) - 1), length(job)
  from emp t
 order by substr(job, length(job) - 1);
-- ʹ�� DBMS ���Ӵ����� substr('20180808',length('20180808')) = '8' ������ʼλ�ã���1��ʼ

-- 2.4 ����ĸ���ֻ�ϵ���������
-- Q��������ĸ�����ֻ�ϵ����ݣ�ϣ���������ֻ��ַ����������򡣿��������ͼ��
create view V as
  select ename || ' ' || deptno as data from emp;
select * from V;
-- Ҫͨ�� DEPTNO �� ENAME ����������
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
-- TRANSLATE �� REPLACE ������ÿһ����ȥ�����ֻ��ַ��������Ϳ��Ժ����׵ظ��ݾ������������

-- 2.5 ���������ֵ
-- Q����emp�и��� COMM �����������ǣ�����ֶο����п�ֵ����Ҫָ������ֵ������󣬻���������ǰ��
select ename,sal,comm from emp order by 3;
select ename,sal,comm from emp order by 3 desc;
-- ʹ�� CASE ���ʽ�����"���"һ��ֵ�Ƿ�Ϊ NULL��������������ֵ��һ����ʾ NULL,һ����ʾ��NULL��
-- ������ֻҪ��ORDER BY�Ӿ������ӱ���У�����Ժ����׵Ŀ��ƿ�ֵ������ǰ�滹���������                 
select ename,sal,comm from (
   select ename,sal,comm,case when comm is null then 0 else 1 end as is_null 
    from emp 
) x order by is_null desc,comm;
-- ORACLE 9i �Ժ������ ORDER BY �Ӿ���ʹ�� NULLS FIRST �� NULLS LAST ����ȷ�� NULL ���������򣬻����������
select ename,sal,comm from emp order by comm nulls last;
select ename,sal,comm from emp order by comm nulls first;

-- 2.6 ����������ļ�����
-- Q��Ҫ����ĳЩ�����߼����������磬���JOB��"SALESMAN"��Ҫ����COMM�����򡣷��򣬸���SAL����
select ename,sal,job,comm
  from emp 
 order by case when job = 'SALESMAN' then comm else sal end;

-- ����ʹ�� CASE ���ʽ����̬�ı���ζԽ�����򡣴��ݸ� ORDER BY ��ֵ����������
select ename,sal,job,comm, 
       case when job = 'SALESMAN' then comm else sal end as ordered
  from emp 
  order by 5;       
