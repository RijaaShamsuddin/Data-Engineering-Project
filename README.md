# E-Commerce Data Pipeline and Visualization Project

## Project Overview
This project involves building an end-to-end data pipeline for an e-commerce sales dataset using AWS RDS, Python, and pgAdmin. The project focuses on data cleaning, ETL (Extract, Transform, Load) operations, data normalization, and data visualization using Power BI. The goal is to derive meaningful insights from the data and demonstrate proficiency in database and data analysis tools.

## Tools and Technologies
- **AWS RDS**: Used to host a PostgreSQL database for data storage and transformation.
- **Python**: Utilized for data extraction, cleaning, and transformations.
- **pgAdmin**: Employed as a graphical interface for managing the PostgreSQL database and performing ETL tasks.
- **SQL**: Used for data transformation, normalization, and querying.
- **Power BI**: Used for creating data visualizations and generating insights.

## Project Steps

### 1. AWS RDS Setup
Created an AWS RDS instance to host a PostgreSQL database and configured it with the necessary security settings for external access.

### 2. Data Extraction and Cleaning (Python)
- Loaded and cleaned the dataset using Python and Pandas, handling missing values and converting data types where necessary.

### 3. Database and ETL Using pgAdmin
- Transferred the cleaned data into the RDS PostgreSQL database using Python and `psycopg2`.
- Normalized the data into two tables: `customers` and `orders`.
- Inserted transformed data and verified its integrity using pgAdmin.

### 4. Data Transformation and Analysis (SQL)
Performed data transformations and generated insights using SQL queries in pgAdmin's Query Tool.

### 5. Data Visualization Using Power BI
Connected Power BI to the AWS RDS database and created visualizations to showcase key insights such as total orders by customer, sales trends, and top-selling products.

## Conclusion
This project highlights the implementation of a full data pipeline, showcasing skills in data extraction, transformation, loading, and visualization using industry-standard tools.
