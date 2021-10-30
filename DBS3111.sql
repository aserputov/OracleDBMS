SELECT employee_id, first_name ||' '|| last_name AS "Employee Name",hire_date
FROM employees 
WHERE hire_date between '01-july-2016' and '17-december-2016'
ORDER BY hire_date DESC, last_name;

SELECT SYSDATE+1 as "Next Day"
FROM dual;

SELECT prod_no,prod_name,prod_sell,FLOOR(prod_sell*0.02 + prod_sell)
FROM products 
WHERE prod_no between 50000 and 60000 and prod_name like 'G%' or prod_name like 'AS%' ;

/*YES*/

SELECT job_id AS "Job Title", first_name ||' '|| last_name AS "Full Name"
FROM employees 
WHERE (first_name like '%e%' or first_name like '%E%') and (first_name like '%a%' or first_name like '%g%');

SELECT  UPPER(first_name) ||','|| UPPER(last_name) || ' is a ' || job_id 
FROM employees
WHERE manager_id = 124;

SELECT last_name,hire_date,TRUNC((SYSDATE-hire_date)/365,1) as "YEARS"
FROM employees 
WHERE hire_date < '01-october-2016'
ORDER BY TRUNC((SYSDATE-hire_date)/365,1);

SELECT last_name,hire_date, to_char(next_day(hire_date,'TUESDAY'),'DAY", "Month"the "Ddspth " of year "YYYY') as "Review Day"
FROM employees 
WHERE hire_date > '01-january-2016'
ORDER BY next_day(hire_date,'TUESDAY');

