
-- #################################################################### BASIC STRUCTURE #################################

BEGIN

DBMS_OUTPUT.PUT_LINE('welcome to the PL SQL World');

END;

-- #################################################################### DECLARATION ######################################

DECLARE

ordernumber number:=1001;
anothernumber NUMBER default 100;

BEGIN

DBMS_OUTPUT.PUT_LINE(ordernumber);
DBMS_OUTPUT.PUT_LINE(anothernumber);

END;

-- #################################################################### IF BLOCK #######################################

DECLARE

total_exp number := 50;
discount_perc FLOAT := 0.1;

BEGIN

if total_exp > 100 then 
    total_exp := total_exp - (total_exp * discount_perc);

else
    total_exp := total_exp;

end if;

DBMS_OUTPUT.PUT_LINE('total exp is ' || total_exp);

END;

-- #################################################################### CASE #######################################

DECLARE

total_exp number := 100;
total_disc float := 0.2;

BEGIN

    case 
        WHEN total_exp >= 300 then total_disc := 0.2;
        WHEN total_exp >= 200 then total_disc := 0.1;
        ELSE total_disc := 0.05;
    END case;

    DBMS_OUTPUT.PUT_LINE('Total discount percentage given was ' || total_disc);

END;

-- #################################################################### WHILE LOOP #######################################

DECLARE

cntr number := 10;

BEGIN

while cntr < 20
    LOOP
        DBMS_OUTPUT.PUT_LINE('Counter Value is '|| cntr);
        cntr := cntr + 1;
    END LOOP;
END;

-- #################################################################### FOR LOOP #######################################

DECLARE

cntr number := 10;

BEGIN

FOR cntr in reverse 10 .. 20
    LOOP
        DBMS_OUTPUT.PUT_LINE('Counter Value is '|| cntr);
    END LOOP;
END;