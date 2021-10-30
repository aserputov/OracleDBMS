
SELECT cust_no, cname, SUM(price * qty), COUNT(order_no) 
FROM customers c 
LEFT JOIN orders o  USING (cust_no) 
LEFT JOIN orderlines ol  USING (order_no) 
WHERE cname LIKE 'A%'
GROUP BY cust_no, cname
ORDER BY 4;

SELECT c.cust_no, c.cname, SUM(ol.price * ol.qty) as "Total Amount", COUNT(o.order_no) as "Number of Orders"
FROM orderlines ol 
JOIN orders o  ON (ol.order_no = o.order_no ) 
RIGHT JOIN customers c  ON (c.cust_no = o.cust_no) 
GROUP BY c.cust_no, c.cname
HAVING c.cname LIKE 'A%'
ORDER BY 4;




