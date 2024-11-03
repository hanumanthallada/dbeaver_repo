-- ########################################## Reading data from Database ###################################

-- select * from CUSTOMER;

DECLARE

c_id number := 10;
f_name VARCHAR2(20);
c_addr VARCHAR2(100);

BEGIN

    SELECT first_name, address_Line1 into f_name, c_addr from CUSTOMER where CUSTOMER_ID = c_id;

    DBMS_OUTPUT.PUT_LINE('First name of the employee is ' || f_name);
    DBMS_OUTPUT.PUT_LINE('Address of the employee is ' || c_addr);

END; 

-- ##########################################  % TYPE use ###################################

-- select * from CUSTOMER;

DECLARE

c_id CUSTOMER.CUSTOMER_ID%TYPE :=  11;
f_name CUSTOMER.FIRST_NAME%TYPE;
c_addr CUSTOMER.ADDRESS_LINE1%TYPE;

BEGIN

    SELECT first_name, address_Line1 into f_name, c_addr from CUSTOMER where CUSTOMER_ID = c_id;

    DBMS_OUTPUT.PUT_LINE('First name of the employee is ' || f_name);
    DBMS_OUTPUT.PUT_LINE('Address of the employee is ' || c_addr);

END;