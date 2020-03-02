

-- Using Boolean and Relational operators

-- 1
SELECT *
FROM customer
WHERE grade > 100

-- 2
SELECT * 
FROM customer
WHERE city = 'New York' AND grade > 100

-- 3
SELECT * 
FROM customer
WHERE city = 'New York' OR grade > 100

-- 5
SELECT * 
FROM customer
WHERE city = 'New York' OR grade <= 100

SELECT * 
FROM customer
WHERE city = 'New York' OR NOT grade > 100

-- 6
SELECT * 
FROM orders
WHERE NOT ((ord_date = '2012-09-10' AND salesman_id >= 505) OR purch_amt >= 1000)

-- 7
SELECT * 
FROM salesman
WHERE commission > .10 AND commission < .12

-- 8 
SELECT * 
FROM orders
WHERE purch_amt < 200 OR NOT(ord_date >= '2012-02-10' AND customer_id < 3009)

-- 9
SELECT * 
FROM orders
WHERE NOT ((ord_date = '2012-08-17' OR purch_amt > 1000) AND customer_id > 3005)

-- 10 which exceeds the 50% of the target value of 6000.
SELECT * 
FROM orders
WHERE (100 * purch_amt)/6000 > 50

-- 11 Write a query in SQL to find the data of employees whose last name is Dosni or Mardy.
SELECT * 
FROM emp_details
WHERE emp_lname = 'Dosni' OR emp_lname = 'Mardy'

- 12
SELECT * 
FROM emp_details
WHERE emp_dept = 47 OR emp_dept = 63

-----------------------------------------------------  END OF FOURTH PROBLEMS --------------------------------------------------