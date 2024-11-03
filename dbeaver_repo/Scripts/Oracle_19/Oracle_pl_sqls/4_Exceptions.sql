-- ######################################## System Defined Exception example ######################################

-- select * from customer;

create or replace procedure fetch_customer(c_id IN number )
AS

c_name customer.FIRST_NAME%TYPE;
c_addr customer.ADDRESS_LINE1%TYPE;

BEGIN

    select first_name, address_Line1 into c_name, c_addr from customer where CUSTOMER_ID = c_id;

    dbms_output.put_line('First Name ' || c_name);
    dbms_output.put_line('Address_line1 Details ' || c_addr);

    EXCEPTION
        when NO_DATA_FOUND then
            DBMS_OUTPUT.PUT_LINE('There are No records for the customer_id '|| c_id);
        when TOO_MANY_ROWS then
            DBMS_OUTPUT.PUT_LINE('There are Many rows associated with this customer_id '|| c_id);
        when OTHERS then
            DBMS_OUTPUT.PUT_LINE('Some other Error');
            
END;


-- ######################################## User Defined Exception example ######################################

create or replace procedure fetch_customer(c_id IN number )
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

-- ######################################## Execution of above procedures to test exceptions ######################################

execute FETCH_CUSTOMER(16);
EXECUTE FETCH_CUSTOMER(100);
EXECUTE FETCH_CUSTOMER(0);