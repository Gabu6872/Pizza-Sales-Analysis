-- Total Revenue
SELECT SUM(total_price) AS 'Total Revenue' FROM pizza_sales

-- Average Order Value
SET QUERY_GOVERNOR_COST_LIMIT 15000
SELECT SUM(total_price) / COUNT(DISTINCT pizza_sales.order_id) AS 'Avg Order Value' FROM pizza_sales 

-- Overall Pizza Sold
SELECT SUM(pizza_sales.quantity) AS 'Total Pizza Sold' FROM pizza_sales

-- Total Orders
SELECT COUNT(DISTINCT pizza_sales.order_id) AS 'Total Orders' FROM pizza_sales

-- Avg. Pizza per Order
SELECT CAST(CAST(SUM(pizza_sales.quantity) AS DECIMAL(10,2)) / 
COUNT(DISTINCT pizza_sales.order_id) AS DECIMAL(10,2)) AS 'Avg. Pizza per Order' FROM pizza_sales

-- Daily Trend for Total Orders
SELECT DATENAME(dw, pizza_sales.order_date) AS 'Order Day', COUNT(DISTINCT pizza_sales.order_id) AS 'No. of Orders'
FROM pizza_sales
GROUP BY DATENAME(dw, pizza_sales.order_date)
ORDER BY 'No. of Orders'DESC

-- Monthly Trend for Total Orders
SELECT DATENAME(month, pizza_sales.order_date) as 'Month', COUNT(DISTINCT pizza_sales.order_id) AS 'No. of Orders'
FROM pizza_sales
GROUP BY DATENAME(month, pizza_sales.order_date)
ORDER BY 'No. of Orders' desc

-- Percentage of Sales by Pizza Category
SELECT DISTINCT pizza_sales.pizza_category, CAST(SUM(total_price) AS DECIMAL (10,2)) AS 'Total Sales',
CAST(CAST(SUM(total_price) AS DECIMAL (18,2)) * 100 / 
(SELECT CAST(SUM(total_price) AS DECIMAL (18,2)) FROM pizza_sales WHERE MONTH(order_date) = 12) AS DECIMAL (18,2)) as '% Sales'
FROM pizza_sales
WHERE MONTH(order_date) = 1  -- Performs a filter based on the month
GROUP BY  pizza_sales.pizza_category
ORDER BY '% Sales' DESC

-- Percentage of Sales by Pizza Size
SELECT DISTINCT pizza_sales.pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS 'Total Sales',
CAST(CAST(SUM(total_price) AS DECIMAL (18,2)) * 100 / 
(SELECT CAST(SUM(total_price) AS DECIMAL (18,2)) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 2) AS DECIMAL (18,2)) as '% Sales'
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 2  -- Performs a filter based on the firstquarter
GROUP BY  pizza_sales.pizza_size
ORDER BY '% Sales' DESC

-- Top 5 Best Sellers by Revenue
SELECT TOP 5 pizza_sales.pizza_name, CAST(SUM(pizza_sales.total_price) AS DECIMAL(10,2)) AS 'Total Revenue'
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY 'Total Revenue' DESC

-- Worst Sellers by Revenue 
SELECT TOP 5 pizza_sales.pizza_name, CAST(SUM(pizza_sales.total_price) AS DECIMAL(10,2)) AS 'Total Revenue'
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY 'Total Revenue' ASC

-- Top 5 Sellers by Quantity 
SELECT TOP 5 pizza_sales.pizza_name, SUM(pizza_sales.quantity) AS 'Total Quantity'
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY 'Total Quantity' Desc

-- Worst 5 Sellers by Quantity 
SELECT TOP 5 pizza_sales.pizza_name, SUM(pizza_sales.quantity) AS 'Total Quantity'
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY 'Total Quantity' ASC

-- Top 5 Sellers by Total Orders
SELECT TOP 5 pizza_sales.pizza_name, COUNT(DISTINCT order_date) AS 'Total Orders'
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY 'Total Orders' Desc

-- Worst 5 Sellers by Total Orders
SELECT TOP 5 pizza_sales.pizza_name,  COUNT(DISTINCT order_date) AS 'Total Orders'
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY 'Total Orders' ASC