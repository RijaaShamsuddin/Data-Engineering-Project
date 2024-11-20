CREATE TABLE superstore_data (
    row_id SERIAL PRIMARY KEY,
    order_id TEXT,
    order_date DATE,
    ship_date DATE,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    country TEXT,
    city TEXT,
    state TEXT,
    postal_code NUMERIC,
    region TEXT,
    product_id TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    sales NUMERIC
);

--Import data from a csv file into pgAdmin interface for querying 

-- Create the Customers table
CREATE TABLE Customers (
    Customer_ID VARCHAR(255) PRIMARY KEY,
    Customer_Name VARCHAR(255),
    Segment VARCHAR(100),
    Country VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code NUMERIC
);

-- Insert unique customer records
INSERT INTO Customers (Customer_ID, Customer_Name, Segment, Country, City, State, Postal_Code)
SELECT DISTINCT 
    Customer_ID,
    Customer_Name,
    Segment,
    Country,
    City,
    State,
    Postal_Code
FROM 
    superstore_data
ON CONFLICT (customer_id) DO NOTHING;


-- Create the Sales table
CREATE TABLE Sales (
    Row_ID SERIAL PRIMARY KEY,
    Order_ID VARCHAR(255),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(100),
    Customer_ID VARCHAR(255) REFERENCES Customers(Customer_ID),
    Region VARCHAR(100),
    Product_ID VARCHAR(255),
    Category VARCHAR(100),
    Sub_Category VARCHAR(100),
    Product_Name VARCHAR(255),
    Sales NUMERIC
);

-- Insert data into the Sales table
INSERT INTO Sales (
    Order_ID, 
    Order_Date, 
    Ship_Date, 
    Ship_Mode, 
    Customer_ID, 
    Region, 
    Product_ID, 
    Category, 
    Sub_Category, 
    Product_Name, 
    Sales
)
SELECT 
    Order_ID,
    TO_DATE(Order_Date, 'DD/MM/YYYY'), -- Convert Order_Date to TIMESTAMP
    TO_DATE(Ship_Date, 'DD/MM/YYYY'),  -- Convert Ship_Date to TIMESTAMP
    Ship_Mode,
    Customer_ID,
    Region,
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    Sales
FROM 
    superstore_data;

--Customer Sales Aggregation with Grouping and Filtering Using the HAVING Clause
SELECT s.Customer_ID, c.Customer_Name, SUM(s.Sales) AS Total_Sales
FROM sales s
LEFT JOIN customers c on c.customer_id = s.customer_id	
GROUP BY s.Customer_ID, c.Customer_Name
HAVING SUM(s.Sales) > 1000
ORDER BY Total_Sales DESC;

--Ranking Customers Based on Total Sales Using Window Functions
SELECT s.Customer_ID, c.Customer_Name, SUM(s.Sales) AS Total_Sales,
RANK() OVER (ORDER BY SUM(s.Sales) DESC) AS Sales_Rank
FROM sales s
LEFT JOIN customers c on c.customer_id = s.customer_id	
GROUP BY s.Customer_ID, c.Customer_Name
ORDER BY Sales_Rank;

--Identifying Top-Selling Products with Common Table Expressions (CTEs)
WITH ProductSales AS (
    SELECT Product_ID, Product_Name, SUM(Sales) AS Total_Sales, COUNT(Product_ID) AS Total_Number_of_Products
    FROM sales
    GROUP BY Product_ID, Product_Name)

SELECT Product_ID, Product_Name, Total_Sales,Total_Number_of_Products
FROM ProductSales
ORDER BY Total_Number_of_Products,Total_Sales DESC
LIMIT 5;

--Comparing Sales Against Category Averages with Complex Joins and Subqueries
SELECT s.Order_ID, s.Product_Name, s.Sales, x.Avg_Category_Sales
FROM sales s
INNER JOIN (
    SELECT Category, AVG(Sales) AS Avg_Category_Sales
    FROM sales
    GROUP BY Category
) x 
ON 
    s.Category = x.Category
ORDER BY 
    s.Sales DESC;


--Sales Categorization by Region Using CASE Expressions
SELECT Region, SUM(Sales) AS Total_Sales,
   CASE WHEN SUM(Sales) > 10000 THEN 'High Sales'
        WHEN SUM(Sales) BETWEEN 5000 AND 10000 THEN 'Moderate Sales'
        ELSE 'Low Sales'
   END AS Sales_Category
FROM sales
GROUP BY Region
ORDER BY Total_Sales DESC;



