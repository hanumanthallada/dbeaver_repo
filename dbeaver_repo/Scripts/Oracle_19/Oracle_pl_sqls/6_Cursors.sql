-- ################################## Implicit Cursors #############################

create or replace procedure fetch_customer_cursor ( cust_num IN NUMBER)
AS

cust_name customer.FIRST_NAME%TYPE;
cust_addr1 customer.ADDRESS_LINE1%TYPE;

cursor c is select FIRST_NAME, ADDRESS_LINE1 from customer where customer_id > cust_num; -- Cursor Declaration

BEGIN


open c; -- Opening Cursor

LOOP
fetch c into cust_name, cust_addr1;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Customer Name is : ' || cust_name );
DBMS_OUTPUT.PUT_LINE('Customer Address is : ' || cust_addr1 );

END LOOp;
close c; -- Closing the cursor

END;

-- ################################## Cursors with Records combo #############################

create or replace procedure fetch_customer_recods_combo ( cust_num IN NUMBER)
AS

cursor c is select FIRST_NAME, LAST_NAME, ADDRESS_LINE1, COUNTRY from customer where customer_id > cust_num; -- Cursor Declaration
c_rec c%rowtype;

BEGIN

open c; -- Opening Cursor

LOOP
fetch c into c_rec;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Customer Name is : ' || c_rec.FIRST_NAME );
DBMS_OUTPUT.PUT_LINE('Customer Address is : ' || c_rec.LAST_NAME );
DBMS_OUTPUT.PUT_LINE('Customer Name is : ' || c_rec.ADDRESS_LINE1 );
DBMS_OUTPUT.PUT_LINE('Customer Address is : ' || c_rec.COUNTRY );

END LOOP;
close c; -- Closing the cursor

END;

-- ################################## Latest Cursors For Loop with Records combo #############################

create or replace procedure fetch_customer_for_recods_combo ( cust_num IN NUMBER)
AS

BEGIN
for c_rec in (select * from customer where customer_id = cust_num)
Loop
DBMS_OUTPUT.PUT_LINE('Customer Name is : ' || c_rec.FIRST_NAME );
DBMS_OUTPUT.PUT_LINE('Customer Address is : ' || c_rec.LAST_NAME );
DBMS_OUTPUT.PUT_LINE('Customer Name is : ' || c_rec.ADDRESS_LINE1 );
DBMS_OUTPUT.PUT_LINE('Customer Address is : ' || c_rec.COUNTRY );
END LOOP;

END;

--- ########################### Cursor REFERNECE Function (SYS_REFCURSOR) ##########################

create or replace function cursor_set_func (cust_no IN NUMBER) return SYS_REFCURSOR
as
cur_return SYS_REFCURSOR;

BEGIN

OPEN cur_return FOR select first_name, last_name from CUSTOMER where CUSTOMER_ID > cust_no;
    return cur_return;

END cursor_set_func;

--- ########################### Cursor REFERNECE Procedure (SYS_REFCURSOR) ##########################

create or replace procedure cursor_set_proc(cust_num IN NUMBER)
as
c_rec SYS_REFCURSOR;
cust_first_name varchar2(100);
cust_last_name varchar2(100);

BEGIN

    c_rec := cursor_set_func(cust_num); -- #Declare

-- open c_rec; -- # Open cursor will not be part of the code during these SYS_REF CURSORS parameter passing

LOOP
    fetch c_rec into cust_first_name, cust_last_name; -- #Fetching

    exit when c_rec%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(cust_first_name);
    DBMS_OUTPUT.PUT_LINE(cust_last_name);
END LOOP;

close c_rec; -- # Close

END cursor_set_proc;

-- ################################## Testing rows found in this Implicit Cursors #############################

EXECUTE FETCH_CUSTOMER_CURSOR(10);
EXECUTE fetch_customer_recods_combo(11);
-- select * from customer
EXECUTE fetch_customer_for_recods_combo(16)

execute cursor_set_proc(16);