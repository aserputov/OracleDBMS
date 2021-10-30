
SELECT last_name, hire_date
FROM employees
WHERE hire_date < (SELECT hire_date
                   FROM employees
                   WHERE employee_id = 107)
ORDER BY hire_date asc;

/*2*/
SELECT last_name, salary
FROM employees
WHERE salary = (SELECT MIN (salary)
                 FROM employees)
ORDER BY last_name;

/*3*/
SELECT 
    prod_no, 
    prod_name,
    prod_type, 
    prod_sell
FROM 
    products
WHERE (prod_type, prod_sell) IN
                            (SELECT prod_type, max(prod_sell)
                            FROM products
                            GROUP BY prod_type)
ORDER BY prod_type;


/*4*/
SELECT prod_line,prod_sell
FROM products
WHERE prod_sell = (SELECT MAX (prod_sell)
                 FROM products)
ORDER BY prod_type;


/*5*/

SELECT 
    prod_type,
    prod_sell
FROM
    products
WHERE prod_sell < ANY (SELECT MIN(prod_sell)
                  FROM products
                  GROUP BY prod_type)
ORDER BY prod_sell,prod_name;

/*6*/
SELECT prod_no,prod_name, prod_sell
FROM products
WHERE prod_type in (SELECT prod_type
                    FROM products
                    WHERE prod_sell = ANY (SELECT MIN(prod_sell)
                                      FROM products));


/*7*/

SELECT CONCAT(TO_CHAR(CURRENT_DATE+1,'MonthDD"th"" of year "YYYY'),' ') "Next Day"
from dual;

/*8*/
SELECT city,country_id,CONCAT(NVL(state_province,0),' ')"StateName"
FROM locations
WHERE (city LIKE 's%') and (LENGTH(city) > 8);