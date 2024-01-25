select * from supermarket_sales;

-- Customer Analysis --

# Exploring Top 5 customers by revenue
SELECT customer_type, 
       ROUND(SUM(revenue)) AS total_revenue
FROM supermarket_sales
GROUP BY customer_type
ORDER BY total_revenue DESC
LIMIT 5;

# Exploring customer with the average purchase quantity and rating
SELECT customer_type,
       ROUND(AVG(quantity)) AS avg_quantity,
       ROUND(AVG(rating)) AS avg_rating
FROM supermarket_sales
GROUP BY customer_type;

-- ----------------------------------------------

-- Producct Analysis --

# Exploring product line with Highest Gross Margin Percentage
SELECT product_line,
       ROUND(AVG(gm_pct)) AS avg_gm_pct
FROM supermarket_sales
GROUP BY product_line
ORDER BY avg_gm_pct DESC
LIMIT 1;

# Exploring cumulative Revenue Percentage by Product Line
SELECT product_line,
	  Round( SUM(revenue) / (SELECT SUM(revenue) FROM supermarket_sales) * 100) AS cumulative_percentage
FROM supermarket_sales
GROUP BY product_line
ORDER BY cumulative_percentage DESC;

# Exploring branches and their Average Rating for Each Product Line
WITH ranked_branches AS (
    SELECT 
        branch,
        product_line,
        ROUND(AVG(rating)) AS avg_rating,
        ROW_NUMBER() OVER (PARTITION BY product_line ORDER BY AVG(rating) DESC)
    FROM supermarket_sales
    GROUP BY branch, product_line
)
SELECT branch, product_line, avg_rating
FROM ranked_branches;

-- ----------------------------------------------

-- Financial Analysis --

# Exploring montlhy revenue
SELECT EXTRACT(MONTH FROM date) AS month,
	   EXTRACT(YEAR FROM date) AS year,
	   ROUND(SUM(revenue)) AS monthly_revenue
FROM supermarket_sales
GROUP BY year, month
ORDER BY year, month;

# Exploring Branch-wise Sales Analysis 
SELECT branch,
	   ROUND(SUM(revenue)) AS total_revenue,
       ROUND(AVG(gross_income)) AS avg_gross_income
FROM supermarket_sales
GROUP BY branch;

# Exploring Product Line-wise Quantity Sold Compared to Overall Average Quantity
SELECT product_line,
	   AVG(quantity) AS avg_quantity,
       MAX(quantity) AS max_quantity,
       MIN(quantity) AS min_quantity
FROM supermarket_sales
GROUP BY product_line;



