/*1*/
set pagesize 200

set linesize 200
SELECT country_id,country_name
FROM countries 
WHERE country_name LIKE 'g%';

/*2*/
SELECT city
FROM   locations
MINUS
SELECT city
FROM   customers
ORDER BY city asc;

/*3*/
SELECT distinct prod_type,count(prod_no)
FROM   products
WHERE prod_type = 'Sleeping Bags'
GROUP BY prod_type
union all
SELECT distinct prod_type,count(prod_no)
FROM   products
WHERE prod_type = 'Tents'
GROUP BY prod_type
union all
SELECT distinct prod_type,count(prod_no)
FROM   products
WHERE prod_type = 'Sunblock'
GROUP BY prod_type
union all
SELECT distinct prod_type,count(prod_no)
FROM   products
WHERE prod_type NOT IN ('Sunblock','Tents','Sleeping Bags')
GROUP BY prod_type;
/*4*/

SELECT employee_id, job_id
FROM   employees
UNION ALL
SELECT employee_id, job_id
FROM   job_history
ORDER BY employee_id;



