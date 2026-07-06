Create database retail;
SELECT * FROM Superstore;

SELECT Customer_Name, City, Sales
FROM Superstore;

-- Data where sales greater than 500
SELECT *
FROM Superstore
WHERE Sales > 500;

-- Data for California State
SELECT *
FROM Superstore
WHERE State = 'California';

-- Orders placed in west region
SELECT *
FROM Superstore
WHERE Region = 'West';

-- Technology Category Products
SELECT *
FROM Superstore
WHERE Category = 'Technology';

-- Sort Products by Sales
SELECT Product_Name, Sales
FROM Superstore
ORDER BY Sales DESC;

-- Top 10 highest sales orders
SELECT *
FROM Superstore
ORDER BY Sales DESC
LIMIT 10;

-- Total orders
SELECT COUNT(*) AS TotalOrders
FROM Superstore;

-- Total Sales
SELECT SUM(Sales) AS TotalSales
FROM Superstore;

-- Average Sales
SELECT AVG(Sales) AS AverageSales
FROM Superstore;

-- Maximum Sales
SELECT MAX(Sales) AS HighestSale
FROM Superstore;

-- Minimum Sales
SELECT MIN(Sales) AS LowestSale
FROM Superstore;

-- Total Sales by Region
SELECT Region,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Region
ORDER BY TotalSales DESC;

-- Total Sales by State
SELECT State,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY State
ORDER BY TotalSales DESC;

-- Total Sales by Category
SELECT Category,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Category;

-- Total Sales by Sub Category
SELECT Sub_Category,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Sub_Category
ORDER BY TotalSales DESC;

-- Number of Customers in each Segment
SELECT Segment,
       COUNT(DISTINCT Customer_ID) AS Customers
FROM Superstore
GROUP BY Segment;

-- Top 5 customers by Sales
SELECT Customer_Name,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Customer_Name
ORDER BY TotalSales DESC
LIMIT 5;

-- Top 10 cities by Sales
SELECT City,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY City
ORDER BY TotalSales DESC
LIMIT 10;

-- Numbers of orders per ship mode
SELECT Ship_Mode,
       COUNT(*) AS Orders
FROM Superstore
GROUP BY Ship_Mode;

-- Customers who placed more than 5 orders
SELECT Customer_Name,
       COUNT(Order_ID) AS Orders
FROM Superstore
GROUP BY Customer_Name
HAVING COUNT(Order_ID) > 5;

-- States with sales greater than 50,000
SELECT State,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY State
HAVING SUM(Sales) > 50000;

-- Duplicate order ids
SELECT Order_ID,
       COUNT(*) AS Frequency
FROM Superstore
GROUP BY Order_ID
HAVING COUNT(*) > 1;

-- Highest Selling Product
SELECT Product_Name,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY Product_Name
ORDER BY TotalSales DESC
LIMIT 1;

-- Sales by Year
SELECT YEAR(Order_Date) AS Year,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY YEAR(Order_Date);

-- Sales by Month
SELECT MONTH(Order_Date) AS Month,
       SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY MONTH(Order_Date)
ORDER BY Month;

-- Each region highest's sales
SELECT Region,
       MAX(Sales) AS HighestSale
FROM Superstore
GROUP BY Region;

Top 3 products in each category
SELECT *
FROM (
    SELECT Category,
           Product_Name,
           SUM(Sales) AS TotalSales,
           DENSE_RANK() OVER(
               PARTITION BY Category
               ORDER BY SUM(Sales) DESC
           ) AS rnk
    FROM Superstore
    GROUP BY Category, Product_Name
) t
WHERE rnk <= 3;