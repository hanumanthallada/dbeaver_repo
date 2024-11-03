-- ################################## Cursors with Row Types/ Record Types #############################

create or replace procedure fetch_customer_record_cursor ( cust_num IN customer.customer_id%type)
AS
cust_record customer%rowtype;
cursor c is select * from customer where customer_id > cust_num; -- Cursor Declaration
BEGIN
open c; -- Opening Cursor
LOOP
fetch c into cust_record;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(cust_record.FIRST_NAME || ',' || cust_record.LAST_NAME  || ',' ||  cust_record.Address_line1);
END LOOP;
close c; -- Closing the cursor
END;

-- ################################## Passing rows as parameters to procedures #############################

create or replace procedure fetch_customer_record_cursor_main ( cust_num_rec IN customer.customer_id%type)
AS
cust_record customer%rowtype;
cursor c is select * from customer where customer_id > cust_num_rec; -- Cursor Declaration
BEGIN
open c; -- Opening Cursor
LOOP
fetch c into cust_record;
EXIT WHEN c%NOTFOUND;
fetch_customer_record_cursor_child(cust_record);
END LOOP;
close c; -- Closing the cursor
END;

 -- ############## CHILD Proceudre to be called by main procedure ##############
create or replace procedure fetch_customer_record_cursor_child ( cust_rec IN customer%rowtype)
AS
BEGIN
DBMS_OUTPUT.PUT_LINE(cust_rec.FIRST_NAME || ',' || cust_rec.LAST_NAME  || ',' ||  cust_rec.Address_line1);
END;

-- ################### Main: Inserting records into table using record/row types ################

create or replace PROCEDURE insert_customer_records_main ( cust_id IN customer.customer_id%TYPE)
AS
cust_rec customer%rowtype;
BEGIN
    select * into cust_rec from customer where customer_id = cust_id;
    insert_customer_records_child(cust_rec);
END;

-- ################### Child: Inserting records into table using record/row types ################

create or replace PROCEDURE insert_customer_records_child ( cust_rec IN customer%rowtype )
AS
BEGIN
    Insert into customer values cust_rec;
END;

-- ################### Main: Updating records into table using record/row types ################

create or replace PROCEDURE update_customer_records_main ( cust_id IN customer.customer_id%TYPE)
AS
cust_rec customer%rowtype;
BEGIN
    select * into cust_rec from customer where customer_id = cust_id;
    cust_rec.first_name := 'Updated Name';
    update_customer_records_child(cust_rec);
END;

-- ################### Child: Updating records into table using record/row types ################

create or replace PROCEDURE update_customer_records_child ( cust_rec IN customer%rowtype )
AS
BEGIN
        update customer set row = cust_rec where customer_id = cust_rec.customer_id;
END;

-- ################### Main: User defined records display ################

create or replace PROCEDURE udf_customer_records_main ( cust_id IN customer.customer_id%TYPE)
AS
type TABLE_REC is record
(
    my_first_name varchar2(200),
    my_last_name varchar2(200)
);

c_rec TABLE_REC;

BEGIN
    select FIRST_NAME, LAST_NAME into c_rec from customer where customer_id = cust_id;

    DBMS_OUTPUT.PUT_LINE('First Name ' || c_rec.my_first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name ' || c_rec.my_last_name);

END;

-- ################################## Testing rows found in this Implicit Cursors #############################

EXECUTE fetch_customer_record_cursor(10);
Execute fetch_customer_record_cursor_main(10)
execute insert_customer_records_main(10);

select * from customer where customer_id = 11;

execute update_customer_records_main(11);

execute udf_customer_records_main(12);