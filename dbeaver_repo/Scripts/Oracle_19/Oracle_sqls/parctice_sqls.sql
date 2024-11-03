select * from dual;

select ROWNUM R from dual Connect By ROWNUM <= 10;

select * from customer;

-- ################## Removing Duplicate ####################

delete from customer C1 where C1.ROWID > ( select  min(C2.ROWID) from customer C2 where C1.CUSTOMER_ID = C2.CUSTOMER_ID );

select * from customer;

rollback;

-- ########## Employee boss relation ################

create table emp_boss ( empno number, empname varchar2(100), mgrno number);

insert into EMP_BOSS values (1, 'Hanu', 11);
insert into EMP_BOSS values (2, 'Rao', 9);
insert into EMP_BOSS values (3, 'Hanumanth', 8);
insert into EMP_BOSS values (4, 'Allada', 7);
insert into EMP_BOSS values (5, 'Keer', 8);
insert into EMP_BOSS values (6, 'Keerthana', 11);
insert into EMP_BOSS values (7, 'sajja', 9);
insert into EMP_BOSS values (8, 'devyanshi', NULL);
insert into EMP_BOSS values (9, 'anshu', 8);
insert into EMP_BOSS values (10, 'Skirthna', NULL);
insert into EMP_BOSS values (11, 'Skeer', 8);

commit;

select * from emp_boss;

delete from emp_boss;

select e1.EMPNO,e1.empname as emp_name, e2.empname as Mgr_name from emp_boss e1, emp_boss e2 where e1.mgrno = e2.EMPNo;

select e1.EMPNO,e1.empname from emp_boss e1 where e1.mgrno is null;

SELECT sysdate, TO_CHAR(sysdate, 'DD-MON-YYYY HH24:MI:SS'), TO_DATE('11-01-2024', 'MM-DD-YYYY') from dual;
select sysdate from dual;


select * from employee A where 1 = (select count(B.salary) from employee B where A.salary <= B.salary);