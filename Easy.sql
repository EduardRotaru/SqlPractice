
-- Retrieve data from tables

-- 1
SELECT * 
FROM salesman

-- 2
SELECT 'This is SQL Exercise, Practice and Solution' AS displayString

-- 3
SELECT 1,2,3

-- 4
SELECT 10+125

-- 5
SELECT 50*4/100

-- 6
SELECT name, commission
FROM salesman

-- 7
SELECT ord_date, salesman_id, ord_no, purch_amt
FROM orders

-- 8
SELECT DISTINCT * 
FROM ORDERS
WHERE salesman_id IN (SELECT salesman_id
FROM salesman)

-- 8 website version
SELECT DISTINCT * FROM salesman

-- 9
SELECT name, city
FROM salesman
WHERE city = 'Paris'

-- 10
SELECT *
FROM customer
WHERE grade = 200

-- 11
SELECT ord_no, ord_date, purch_amt
FROM orders
WHERE salesman_id = 5001

-- 12
SELECT *
FROM nobel_win
WHERE year = 1970

-- 13
SELECT * 
FROM nobel_win
WHERE subject = 'Literature' AND year = 1971

-- 14
SELECT year, subject
FROM nobel_win
WHERE winner = 'Dennis Gabor'

-- 15
SELECT winner
FROM nobel_win
WHERE subject = 'Physics' AND year >= 1950

-- 16
SELECT year, subject, winner, country
FROM nobel_win
WHERE year BETWEEN 1965 AND 1975 AND subject = 'Chemistry'

-- 17
SELECT * 
FROM nobel_win
WHERE category = 'Prime Minister' AND year > 1972 AND winner IN('Menachem Begin', 'Yitzhak Rabin')

-- 18
SELECT * 
FROM nobel_win
WHERE winner LIKE 'Louis%'

-- 19
 SELECT * 
 FROM nobel_win
 WHERE year IN(1970, 1971) AND subject IN('Physics', 'Economics')
 
 --19 v2
 SELECT *
 FROM nobel_win
 WHERE (year = 1970 AND subject = 'Physics') OR (year = 1971 AND subject = 'Economics')
 
 -- 19 website version
 SELECT * 
 FROM nobel_win
 WHERE year = 1970 AND subject = 'Physics' 
 UNION (SELECT * 
	   FROM nobel_win
	   WHERE year = 1971 AND subject = 'Economics')
	   
-- 20
SELECT * 
FROM nobel_win
WHERE year = 1970 AND subject NOT IN ('Physiology', 'Economics')

-- 20 v2
SELECT * 
FROM nobel_win
WHERE year = 1970 AND subject <> 'Physiology' AND subject <> 'Economics'

-- 21  
-- Write a SQL query to show the winners of a 'Physiology' prize in an early year before 1971 together with winners of a 'Peace' prize in a later year on and after the 1974.
SELECT * 
FROM nobel_win
WHERE subject = 'Physiology' AND year < 1971
UNION (SELECT *
	  FROM nobel_win
	  WHERE subject = 'Peace' AND year >= 1974)
	  
-- 22
SELECT * 
FROM nobel_win
WHERE winner = 'Johannes Georg Bednorz'

-- 23
SELECT * 
FROM nobel_win
WHERE winner NOT LIKE 'P%'
ORDER BY year DESC, winner

-- 24
SELECT *
FROM nobel_win
WHERE subject NOT IN('Economics', 'Chemistry')
UNION(SELECT * 
	 FROM nobel_win
	 WHERE subject IN('Economics', 'Chemistry'))
ORDER BY subject, winner

-- 24 With Cases
SELECT * 
FROM nobel_win
ORDER BY (CASE 
	WHEN subject IN('Economics', 'Chemistry') THEN 1
	ELSE 0
END)

-- 24 With Cases v2
SELECT * 
FROM nobel_win
ORDER BY (CASE 
	WHEN subject IN('Economics') THEN 1
	WHEN subject IN('Chemistry') THEN 2
	WHEN subject IN('Literature') THEN 3
	ELSE 0
END)
 
-- 24 Little experiment
SELECT * 
FROM nobel_win
ORDER BY (CASE 
	WHEN subject NOT LIKE 'P%' THEN 0
	ELSE 1
END)

-- 25 
SELECT *
FROM item_mast
WHERE pro_price BETWEEN 200 AND 600

--26
SELECT AVG(pro_price)
FROM item_mast
WHERE pro_com = 16

-- 27
SELECT pro_name AS name, pro_price AS Price
FROM item_mast

-- 28
SELECT pro_price, pro_name
FROM item_mast
WHERE pro_price >= 250
ORDER BY pro_price DESC, pro_name

-- 29
SELECT AVG(pro_price), pro_com
FROM item_mast
GROUP BY pro_com

-- 30
SELECT pro_name, pro_price
FROM item_mast
WHERE pro_price = (SELECT MIN(pro_price) 
				   FROM item_mast)

-- 31
SELECT DISTINCT emp_lname
FROM emp_details

-- 32
SELECT DISTINCT *
FROM emp_details
WHERE emp_lname = 'Snares'

-- 33
SELECT DISTINCT *
FROM emp_details
WHERE emp_dept = 57

-- SUMMARY
-- Basics covered on first chapter:
-- SELECT, WHERE, BETWEEN, IN, UNION, ORDER BY, CASE, DISTINCT
-- GROUP BY, MIN AVG

-- UNCOVERED
-- ROUNDING, CASTING, 

-----------------------------------------------------  END OF FIRST PROBLEMS --------------------------------------------------
