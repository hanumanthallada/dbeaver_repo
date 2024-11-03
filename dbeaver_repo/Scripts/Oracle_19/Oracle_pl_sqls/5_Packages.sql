-- ##################################################### Package Specifications #############################################

create or replace PACKAGE combo_package_test
AS

procedure fetch_customer(c_id IN number);

function my_table_count (my_tab_name IN VARCHAR2) return number;

END combo_package_test;

-- ##################################################### Package Body #############################################

create or replace PACKAGE body combo_package_test 
AS

procedure fetch_customer(c_id IN number )
AS

c_name customer.FIRST_NAME%TYPE;
c_addr customer.ADDRESS_LINE1%TYPE;
c_id_exception EXCEPTION;

BEGIN

    if c_id <= 0 THEN
        raise c_id_exception;
    end if;

    select first_name, address_Line1 into c_name, c_addr from customer where CUSTOMER_ID = c_id;

    dbms_output.put_line('First Name ' || c_name);
    dbms_output.put_line('Address_line1 Details ' || c_addr);

    EXCEPTION
        when c_id_exception THEN
            DBMS_OUTPUT.PUT_LINE('Customer id value should be greater than zero');
        when NO_DATA_FOUND then
            DBMS_OUTPUT.PUT_LINE('There are No records for the customer_id '|| c_id);
        when TOO_MANY_ROWS then
            DBMS_OUTPUT.PUT_LINE('There are Many rows associated with this customer_id '|| c_id);
        when OTHERS then
            DBMS_OUTPUT.PUT_LINE('Some other Error');
            
END;

function my_table_count(my_tab_name IN VARCHAR2) return number
AS

ret_count number := 0;
sql_stmt VARCHAR2(1000);

BEGIN

sql_stmt := 'select count(1) from ' || my_tab_name;

EXECUTE IMMEDIATE sql_stmt into ret_count;

return ret_count;

END my_table_count;

END combo_package_test;

-- ##################################################### Executing the packages #############################################

BEGIN
DBMS_OUTPUT.PUT_LINE(COMBO_PACKAGE_TEST.MY_TABLE_COUNT('customer')); -- Not working while passing parameter to the function implemented in package body
END;

EXECUTE COMBO_PACKAGE_TEST.FETCH_CUSTOMER(16);