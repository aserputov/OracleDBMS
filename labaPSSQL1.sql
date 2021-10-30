
SET SERVEROUTPUT ON
-- *********************** 
-- Name: Anatoliy Serputov
-- Student ID: 167389188 
-- Date: 11/09/2020
-- Purpose: Lab 5 DBS311 
-- *********************** 


-- Question 1 –  
--Write a stored procedure that get an integer number and prints
--The number is even.

-- Q1 SOLUTION –
CREATE OR REPLACE PROCEDURE  evenodd  (instuff in number)
as

BEGIN

if mod(instuff, 2) = 0 
	then dbms_output.put_line('The number is even!');
else 
	dbms_output.put_line('The number is odd!');
end if;
EXCEPTION
WHEN NO_DATA_FOUND  		 -- caught by this error handling
  THEN
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
WHEN TOO_MANY_ROWS
  	THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
WHEN OTHERS						-- WHEN OTHERS must be last
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');

END evenodd;
/
--execution statement taking an input from user and passing it to the procedure
BEGIN
evenodd(&input);  -- asks for input from user
end;


-- Question 2 – 
--Create a stored procedure named find_employee. This procedure gets an employee number and prints the following employee information:
-- Q2 SOLUTION –
CREATE OR REPLACE PROCEDURE find_employee (employeeId in number) AS  -- gave procedure a name

  emplLName VARCHAR2(20 BYTE);
  emplFName VARCHAR2(25 BYTE);
  emplEmail VARCHAR2(25 BYTE);
  emplPhone VARCHAR2(20 BYTE);
  emplDate  DATE;
  emplJobId VARCHAR2(10 BYTE);
  
BEGIN
    
  	SELECT first_name,last_name,email,phone_number,hire_date,job_id INTO emplLName,emplFName,emplEmail,emplPhone,emplDate,emplJobId
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = employeeId;
    DBMS_OUTPUT.PUT_LINE ('First name: ' || emplLName);
    DBMS_OUTPUT.PUT_LINE ('Last name: ' || emplFName);
    DBMS_OUTPUT.PUT_LINE ('Email: ' || lower(emplEmail) || '@example.com');
    DBMS_OUTPUT.PUT_LINE ('Phone: ' || emplPhone);
    DBMS_OUTPUT.PUT_LINE ('Hire date: ' || emplDate);
    DBMS_OUTPUT.PUT_LINE ('Job title: ' || emplJobId);
EXCEPTION
WHEN NO_DATA_FOUND  		 -- caught by this error handling
  THEN
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
WHEN TOO_MANY_ROWS
  	THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
WHEN OTHERS
  	THEN 
      		DBMS_OUTPUT.PUT_LINE ('Error!');
END;

BEGIN
find_employee(&input);  -- asks for input from user
end;
-- Question 3 – 
-- Write a procedure named update_price_tents to update the price of all products in a given type and the given amount to be added to the current selling price if the price is greater than 0. 
-- Q3 SOLUTION –

CREATE OR REPLACE PROCEDURE update_price_tents(pro_type IN products.prod_type%type,amount IN products.prod_type%type)  AS  -- gave procedure a name
     Rows_updated Number; 
BEGIN
    IF(amount > 0) THEN
         UPDATE products SET prod_sell = prod_sell+amount
         WHERE lower(prod_type) = lower(pro_type);
         Rows_updated := sql%rowcount; -- count number of rows
         DBMS_OUTPUT.PUT_LINE('Rows updated ' || Rows_updated);
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Amount added must be > 0');
    END IF;
EXCEPTION
WHEN NO_DATA_FOUND  		 -- caught by this error handling
  THEN
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
WHEN TOO_MANY_ROWS
  	THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
WHEN OTHERS
  	THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');
END;
/
BEGIN
update_price_tents('&input',&put);  -- asks for input from user
end;
ROLLBACK;
-- Question 4 – 
-- Write a stored procedure named update_low_prices_123456789 where 123456789 is replace by your student number.
-- Q4 SOLUTION –
CREATE OR REPLACE PROCEDURE update_low_prices_167389188  AS  -- gave procedure a name
     Rows_updat Number; 
     avg_price products.prod_sell%type;
     prc Number;
     pr_sell number;
BEGIN
   SELECT avg(prod_sell) INTO prc
   FROM products;
   avg_price:=prc;
   if avg_price <= 1000 
   then 
   UPDATE products SET prod_sell = prod_sell*1.02
   WHERE prod_sell < avg_price;
  -- dbms_output.put_line('<1000');
   Rows_updat := sql%rowcount;
   DBMS_OUTPUT.PUT_LINE('Increased number of rows for 2% ' || Rows_updat);
   elsif avg_price > 1000 THEN
   UPDATE products SET prod_sell = prod_sell*1.01
   WHERE prod_sell < avg_price;
   Rows_updat := sql%rowcount;
   DBMS_OUTPUT.PUT_LINE('Increased number of rows for 1%  ' || Rows_updat);
 --  dbms_output.put_line('>1000');
   end if;
   
EXCEPTION
WHEN NO_DATA_FOUND  		 -- caught by this error handling
  THEN
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
WHEN TOO_MANY_ROWS
  	THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
WHEN OTHERS
  	THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');
END;
/
BEGIN
update_low_prices_167389188();  -- asks for input from user
end;
ROLLBACK;

-- Question 5 – 
-- Write a procedure named price_report_123456789  to show the number of products in each price category
-- Q5 SOLUTION –
CREATE OR REPLACE PROCEDURE price_report_167389188  AS  -- gave procedure a name
     Rows_updat Number; 
     avg_price products.prod_sell%type;
     min_price products.prod_sell%type;
     max_price products.prod_sell%type;
     l products.prod_sell%type;
     h products.prod_sell%type;
     b products.prod_sell%type;
     av_prc products.prod_sell%type;
     min_prc products.prod_sell%type;
     max_prc products.prod_sell%type; 
BEGIN
     SELECT avg(prod_sell) INTO av_prc
     FROM products;
     avg_price:= av_prc;
   
     SELECT min(prod_sell) INTO min_prc
     FROM products;
     min_price:= min_prc;
   
     SELECT max(prod_sell) INTO max_prc
     FROM products;
     max_price:=max_prc;
    
    select count(prod_sell) into l
    from products
    where prod_sell < (select (avg(prod_sell)-min(prod_sell))/2
                       from products);
    select count(prod_sell) into h
    from products
    where prod_sell < (select (max(prod_sell) - avg(prod_sell))/2
                       from products);  
    select count(prod_sell) into b
    from products
    where prod_sell between (select (avg(prod_sell)-min(prod_sell))/2
                       from products) and (select (max(prod_sell) - avg(prod_sell))/2
                       from products);
    DBMS_OUTPUT.PUT_LINE ('Low: '|| l);
    DBMS_OUTPUT.PUT_LINE ('High: ' || h);
    DBMS_OUTPUT.PUT_LINE ('High: ' || b);

EXCEPTION
WHEN NO_DATA_FOUND  		 -- caught by this error handling
  THEN
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
WHEN TOO_MANY_ROWS
  	THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
WHEN OTHERS
  	THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');
END;
/
BEGIN
price_report_167389188();  -- asks for input from user
end;
ROLLBACK;

