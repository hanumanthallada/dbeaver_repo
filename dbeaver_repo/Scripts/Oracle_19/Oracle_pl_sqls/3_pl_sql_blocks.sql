-- ###################################### Package Creation #######################################

create or replace procedure add_customer (c_id IN NUMBER, f_name IN VARCHAR2, l_name IN VARCHAR2, m_name IN VARCHAR2, add_line1 IN VARCHAR2
, add_line2 IN VARCHAR2, c_city IN VARCHAR2, c_country IN VARCHAR2, c_date_added IN DATE, c_region IN VARCHAR2)   

as

BEGIN

INSERT INTO CUSTOMER

   (CUSTOMER_ID,    FIRST_NAME,    LAST_NAME,    MIDDLE_NAME,    ADDRESS_LINE1,    ADDRESS_LINE2,    CITY,    COUNTRY,    DATE_ADDED,    REGION   ) 
   VALUES (c_id, f_name, l_name, m_name, add_line1, add_line2, c_city, c_country, c_date_added, c_region);

END add_customer;

-- ###################################### Package Execution for IN variables/Mode #######################################

BEGIN

 -- Static way of passing parameters

    ADD_CUSTOMER(15,'Hanu','Allada','Rao','Nort Street','Illinois','Aurora', 'USA','31-Jan-2024','Mid-West');

END;

--- SELECT * FROM CUSTOMER;

BEGIN

 --dynamic way of passing parameters by interchanging those positions

    ADD_CUSTOMER
    (
        c_id => 16,
        f_name => 'Hanumanth',
        l_name => 'Allada',
        m_name => 'Rao',
        
        add_line2 => 'Illinois',
        c_city => 'Aurora', 
        c_country => 'USA',
        c_date_added => '31-Jan-2024',
        c_region => 'Mid-West',
        add_line1 => 'North G Street'
    );

END;

-- ###################################### New Package Creation for OUT variables/Mode #######################################

create or replace procedure add_new_customer (c_id IN NUMBER, f_name IN VARCHAR2, l_name IN VARCHAR2, m_name IN VARCHAR2, add_line1 IN VARCHAR2
, add_line2 IN VARCHAR2, c_city IN VARCHAR2, c_country IN VARCHAR2, c_date_added IN DATE, c_region IN VARCHAR2, total_count OUT NUMBER)   

as

BEGIN

INSERT INTO CUSTOMER

   (CUSTOMER_ID,    FIRST_NAME,    LAST_NAME,    MIDDLE_NAME,    ADDRESS_LINE1,    ADDRESS_LINE2,    CITY,    COUNTRY,    DATE_ADDED,    REGION   ) 
   VALUES (c_id, f_name, l_name, m_name, add_line1, add_line2, c_city, c_country, c_date_added, c_region);

select count(1) into total_count from CUSTOMER;

END add_new_customer;

-- ###################################### Package Execution for OUT variables/Mode #######################################

DECLARE

tot_count number(10);

BEGIN

 -- Static way of passing parameters

    ADD_NEW_CUSTOMER(17,'Hanumantha','Allada','Rao','162 North Street','Illinois','Aurora', 'USA','31-Jan-2024','Mid-West',tot_count);

    DBMS_OUTPUT.PUT_LINE('Total number of record in the table are ' || tot_count);

END;

-- select * from customer;

-- ###################################### Fucntion Creation for IN Or OUT variables/Mode #######################################

create or replace  function my_table_count(my_tab_name IN VARCHAR2)
return number
AS

ret_count number := 0;
sql_stmt VARCHAR2(1000);

BEGIN

sql_stmt := 'select count(1) from ' || my_tab_name;

EXECUTE IMMEDIATE sql_stmt into ret_count;

return ret_count;

END my_table_count;

-- ###################################### Function Execution for OUT variables/Mode #######################################

select my_table_count('customer') from dual;