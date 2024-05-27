-- -----------------------------------------------------------------------------------
	# Final answer code is in SECTION 4  
-- -----------------------------------------------------------------------------------
	-- Cohort analysis for Retention of customers
		-- I'm going to present in a step-by-step walk-through to get more clarity of my SQL Code
        -- Understanding Each Section is very important to understand and get the final code in SECTION 4.  
        -- RUN each section seperately or it gives an Error.

-- -----------------------------------------------------------------------------------
	# SECTION 1. Bucketing 
-- -----------------------------------------------------------------------------------

-- First we bucket them into different cohorts by their sign up month, and store into "cohort_items"

-- output: (user_id, cohort_month), each
WITH cohort_items AS ( 
SELECT 
user_id,
EXTRACT( MONTH FROM first_purchase_date) AS cohort_month,
product_line
FROM 
  first_purchase 
  WHERE product_line = 'Restaurant' -- change this to "Retail store" to get Retail store cohort month table
  ORDER BY 2
   
)
SELECT C.user_id, C.cohort_month, C.product_line
FROM cohort_items C
	JOIN first_purchase fp ON fp.user_id = C.user_id
ORDER BY 2
 
-- -----------------------------------------------------------------------------------
	# SECTION 2. user_acticity 
-- -----------------------------------------------------------------------------------

-- output - (user_id, month_number): user X has activity in month number X
-- that indicates if a user is active in that month after their original signup date.

WITH cohort_items AS ( 
SELECT 
user_id,
EXTRACT(MONTH FROM first_purchase_date) AS cohort_month,
product_line
FROM 
  first_purchase 
   WHERE product_line = 'Restaurant' -- change this to "Retail store" to get Retail store user_activity table
),
user_activities AS (
SELECT
    p.user_id,
    PERIOD_DIFF(
      EXTRACT( MONTH FROM p.purchase_date),
      C.cohort_month
    ) AS month_number
  FROM purchase p
  LEFT JOIN cohort_items C ON p.user_id = C.user_id
  GROUP BY 1, 2
  ORDER BY 2
)
SELECT A.user_id, A.month_number, C.product_line
FROM user_activities A 
LEFT JOIN cohort_items C ON A.user_id = C.user_id

-- The above would return all the pairs of (user_id, month_number) 
	-- that indicates if a user is active in that month after their original signup date.
    
-- The PERIOD_DIFF is a user-defined function that takes in 2 dates, 
	-- and return the number of months between them.
    
-- -----------------------------------------------------------------------------------
	# SECTION 3. Cohort Size 
-- -----------------------------------------------------------------------------------
-- Cohort Size: is simply how many users are in each group

-- output : (cohort_month, size)

WITH cohort_items AS ( 
SELECT 
user_id,
EXTRACT( MONTH FROM first_purchase_date) AS cohort_month,
product_line
FROM 
  first_purchase 
  WHERE product_line = 'Restaurant' -- change this to "Retail store" to get Retail store cohort size table
  ORDER BY 2
),
user_activities AS (
SELECT
    p.user_id,
    PERIOD_DIFF(
      EXTRACT( MONTH FROM p.purchase_date),
      C.cohort_month
    ) AS month_number
  FROM purchase p
  LEFT JOIN cohort_items C ON p.user_id = C.user_id
  GROUP BY 1, 2
  ORDER BY 2
),
cohort_size AS (
  SELECT cohort_month, count(2) AS num_users
  FROM cohort_items
  GROUP BY 1
  ORDER BY 1
)
SELECT C.cohort_month, S.num_users, C.product_line
FROM  cohort_size S
LEFT JOIN cohort_items C ON S.cohort_month = C.cohort_month 

-- And finally, putting them together with the below:

-- -----------------------------------------------------------------------------------
	# SECTION 4. Final Table for Cohort Retention
-- -----------------------------------------------------------------------------------

-- This sql code gives all the requirement fields the we need to perform cohort analysis.
-- (cohort_month, month_number, cnt)
WITH cohort_items AS ( 
SELECT 
user_id,
EXTRACT( MONTH FROM first_purchase_date) AS cohort_month,
product_line
FROM 
  first_purchase 
  WHERE product_line = 'Retail store' -- change this to "Retail store" to get Retail store retention table
  ORDER BY 2
   
),
user_activities AS (
SELECT
    p.user_id,
     PERIOD_DIFF(
      EXTRACT(MONTH FROM p.purchase_date),
      C.cohort_month
    ) AS month_number
  FROM purchase p
  LEFT JOIN cohort_items C ON p.user_id = C.user_id
  GROUP BY 1, 2
  ORDER BY 2
),
cohort_size AS (
  SELECT cohort_month, count(1) AS num_users
  FROM cohort_items
  GROUP BY 1
  ORDER BY 1
),
retention_table AS (
  SELECT
    C.cohort_month,
    A.month_number,
    count(1) AS num_users,
    C.product_line
  FROM user_activities A
  LEFT JOIN cohort_items C ON A.user_id = C.user_id
  WHERE product_line = 'Retail store'    -- change this to "Retail store" to get Retail store retention table
  GROUP BY 1, 2
)
SELECT 
B.cohort_month,
S.num_users AS cohort_size,
B.month_number,
ROUND(CAST(B.num_users AS FLOAT)* 100 / S.num_users,3) AS percentage,
B.product_line
FROM  retention_table B
LEFT JOIN cohort_size S 
ON B.cohort_month = S.cohort_month
WHERE B.cohort_month IS NOT NULL 
ORDER BY 1,3

-- I achieved Cohort Analysis using SQL Code
-- I took this output to vizualise using Tableau to understand user behaviour after their first purchase.
-- -----------------------------------------------------------------------------------
	-- END --
-- -----------------------------------------------------------------------------------