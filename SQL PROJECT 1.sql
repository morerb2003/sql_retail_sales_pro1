-- SQL Retail Sales Analysis - p1

create database sql_project_p1;
USE sql_project_p1;

-- Create TABLE 
CREATE TABLE retail_sales
         (
              trnsaction_id INT,
              sale_date DATE,
              sale_time TIME,
              customer_id INT,
              gender VARCHAR(100),
              age     INT,
              category  VARCHAR(15),
              quantiy INT, 
              price_per_unit FLOAT,
              cogs           FLOAT,
              total_sale       FLOAT
              )
              
SELECT * FROM retail_sales limit 10;            
SELECT COUNT(*) FROM retail_sales ; 
              
              --- CHECKING FOR NULL VALUES --
              
SELECT * FROM retail_sales 
		where  trnsaction_id IS NULL
                or
                sale_time IS NULL
                or
                gender IS NULL 
                OR 
                sale_date IS NULL
                or
                category IS NULL
                or
                quantiy IS NULL 
                OR 
                cogs IS NULL
                or  total_sale  IS NULL;
                       
			--- Data Exploration 
                           
            --- How many sales we havae ?               
	SELECT COUNT(*) AS total_sale FROM retail_sales;
    
    -- How many uniuque cosromer we have ?
    SELECT COUNT(DISTINCT costomer_id) AS total_sale FROM retail_sales;
    SELECT DISTINCT category FROM retail_sales;
    


--- Date Analysis & Business Key problems & Answeres--
 
 -- Q.1 Write a SQL quary to retrieve all colums for sales made on '2022-11-05
SELECT * FROM retail_sales where sale_date ='2022-11-05';


-- Q.2 write a sql quary to retrieve all trasactions where the category is 'Clothing' and the quntity sold is more than is in the month of nov-2022
SELECT * FROM retail_sales WHERE category = 'Clothing'AND sale_date AND "quantity" >= 4;
 SELECT * FROM retail_sales WHERE category = 'Clothing'AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'AND quantity >= 4;
 
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category,SUM(total_sale) as net_sale,COUNT(*) as total_orders FROM retail_sales GROUP BY 1;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT ROUND(AVG(age), 2) as avg_age FROM retail_sales WHERE category = 'Beauty';

--  Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales WHERE total_sale >1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category,gender, COUNT(*) AS total_transaction FROM retail_sales GROUP BY category , gender ORDER BY 1;


-- q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1 
WHERE t1.rank = 1;


-- q.8**Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT customer_id,SUM(total_sale) as total_sales FROM retail_sales GROUP BY 1 ORDER BY 2 DESC LIMIT 5


-- q.9Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category, COUNT(DISTINCT customer_id) as cnt_unique_cs FROM retail_sales GROUP BY category;

-- q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;


                                     ----- END OF PROJECT ---------