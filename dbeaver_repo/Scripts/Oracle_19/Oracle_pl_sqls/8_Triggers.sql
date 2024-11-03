-- ####################### Trigger Types #############################
-- Row Level Trigger
-- Statement Level Trigger
-- Before Trigger
-- After Trigger
-- Combining above 4, we get 12 types of combinations

-- Before Row Insert Trigger
-- Before Statement Insert Trigger

-- After Row Insert Trigger
-- After Statemetn Insert Trigger

-- Similalry the above 4 sub triggers repeats for update and delelte as well.

-- COMMIT is not allowed in Triggers

---select * from employee;

-- For ROW Level Triggers, use FOR EACH ROW after update or insert or delete on Table Name
-- Example:

/* create or replace trigger private_data
after insert or update or delete on employee
FOR EACH ROW --> */

-- For capturing updates when old value is equal to something then use WHEN OLD.VALUE = 'SOUTH'

/* create or replace trigger private_data
after insert or update or delete on employee
FOR EACH ROW 
WHEN OLD.REGION = 'SOUTH' --> */ -- Restricting the trigger when particular value is matched

-- For Restricting Trigger to a column Levels then use ON COLUMN_NAME after update or delete or insert

/* create or replace trigger private_data
after insert or update or delete 
OF CUSTOMER_ID -->
on employee
FOR EACH ROW */ -- Restricting the trigger when particular column is updated

-- ################ Statement Level Trigger for DML Operations #################
create or replace trigger private_data
after insert or update or delete on employee

DECLARE

v_username VARCHAR2(100);

BEGIN

    select user into v_username from dual;

If Inserting then
    insert into AUDIT_TABLE values('employee',v_username,SYSDATE,'Inserting rows');
elsif updating then
    insert into AUDIT_TABLE values('employee',v_username,SYSDATE,'Updating rows');
else
    insert into AUDIT_TABLE values('employee',v_username,SYSDATE,'Deleting rows');
end if;

END;

-- ################### Testing Insert Trigger annd validating the result ####################

Insert into EMPLOYEE values(6,'Hanuman','Rao','HR',10000,'31-Dec-2023');

select * from AUDIT_TABLE;