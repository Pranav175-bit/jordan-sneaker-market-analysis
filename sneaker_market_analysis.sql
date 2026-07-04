
--Sneaker Resale Market Analysis using SQL Server

--1. Project Overview
/*
This project analyzes 5,000 sneaker resale transactions using SQL Server to evaluate product performance, profitability,
sales channel efficiency, inventory turnover, and sales trends. The objective is to derive business insights that can support 
inventory management, pricing strategies, and sales channel optimization.*/

----------------------------------
/*2. Dataset Description
-----------------------------------

The dataset contains 5,000 sneaker resale transactions from 2023 to 2025. Each record represents a single resale transaction of
an Air Jordan sneaker and includes information about the product, pricing, sales channel, inventory duration, and profitability.

The dataset consists of 10 columns, including:

Transaction ID – Unique identifier for each sale
Sale Date – Date of the transaction
Shoe Model – Air Jordan model sold
Colorway – Color variation of the shoe
Condition – Product condition (e.g., New or Used)
Retail Price (USD) – Original retail price
Resale Price (USD) – Selling price in the resale market
Sales Channel – Platform where the shoe was sold
Days in Inventory – Number of days before the shoe was sold
Profit Margin (USD) – Profit earned from the transaction

This dataset is used to analyze product performance, profitability, sales channel efficiency, inventory turnover, and resale market trends.*/
/*| Column            | Description                                 |
| ----------------- | ------------------------------------------- |
| Transaction_ID    | Unique identifier for each transaction      |
| Sale_Date         | Date of the resale transaction              |
| Shoe_Model        | Air Jordan sneaker model                    |
| Colorway          | Color variation of the sneaker              |
| Condition         | Product condition (New/Used)                |
| Retail_Price_USD  | Original retail price in USD                |
| Resale_Price_USD  | Resale price in USD                         |
| Sales_Channel     | Platform where the sneaker was sold         |
| Days_in_Inventory | Number of days before the sale              |
| Profit_Margin_USD | Profit earned (Resale Price − Retail Price) |
*/


CREATE DATABASE sneaker_analysis;
GO

USE sneaker_analysis;
GO
------------------------------------------------------------
-- 3. Data Validation & Cleaning
------------------------------------------------------------

select Top 10* 
from jordan_market_dataset_2026;

SELECT COUNT(*) AS total_rows
FROM jordan_market_dataset_2026;

--Check missing values
SELECT
    SUM(CASE WHEN Transaction_ID IS NULL OR TRIM(Transaction_ID) = '' THEN 1 ELSE 0 END) AS missing_transaction_id,
    SUM(CASE WHEN Sale_Date IS NULL THEN 1 ELSE 0 END) AS missing_sale_date,
    SUM(CASE WHEN Shoe_Model IS NULL OR TRIM(Shoe_Model) = '' THEN 1 ELSE 0 END) AS missing_shoe_model,
    SUM(CASE WHEN Colorway IS NULL OR TRIM(Colorway) = '' THEN 1 ELSE 0 END) AS missing_colorway,
    SUM(CASE WHEN Condition IS NULL OR TRIM(Condition) = '' THEN 1 ELSE 0 END) AS missing_condition,
    SUM(CASE WHEN Retail_Price_USD IS NULL THEN 1 ELSE 0 END) AS missing_retail_price,
    SUM(CASE WHEN Resale_Price_USD IS NULL THEN 1 ELSE 0 END) AS missing_resale_price,
    SUM(CASE WHEN Sales_Channel IS NULL OR TRIM(Sales_Channel) = '' THEN 1 ELSE 0 END) AS missing_sales_channel,
    SUM(CASE WHEN Days_in_Inventory IS NULL THEN 1 ELSE 0 END) AS missing_days_inventory,
    SUM(CASE WHEN Profit_Margin_USD IS NULL THEN 1 ELSE 0 END) AS missing_profit_margin
FROM jordan_market_dataset_2026;

--Check duplicate transaction IDs
SELECT
    Transaction_ID,
    COUNT(*) AS duplicate_count
FROM jordan_market_dataset_2026
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

--Check column data types
EXEC sp_help jordan_market_dataset_2026;

--Check profit calculation
SELECT *
FROM jordan_market_dataset_2026
WHERE ABS((Resale_Price_USD - Retail_Price_USD) - Profit_Margin_USD) > 0.01;


--add primary key
ALTER TABLE jordan_market_dataset_2026
ALTER COLUMN Transaction_ID NVARCHAR(100) NOT NULL;
GO

ALTER TABLE jordan_market_dataset_2026
ADD CONSTRAINT PK_jordan_market_dataset_2026
PRIMARY KEY (Transaction_ID);
GO

select * from sys.key_constraints

SELECT *
INTO jordan_market_clean
FROM jordan_market_dataset_2026;
GO

/*
Validation Summary:After validating the dataset for missing values, duplicate transaction IDs, date formatting, and profit calculation accuracy,
no major cleaning issues were found. Therefore, I created a clean analysis table as a copy of the validated imported table.*/

------------------------------------------------------------
-- 4. Exploratory Data Analysis (EDA)
------------------------------------------------------------

SELECT TOP 10 *
FROM jordan_market_clean

--Total number of transactions
select count(Transaction_iD) as Total_transactions 
from jordan_market_clean

--Date range of the sales data
select  min(Sale_Date) as Earliest_Sale, max(Sale_Date) as Latest_Sale
from jordan_market_clean


--Number of unique shoe models
select  count(DISTINCT Shoe_Model) as Number_of_models
from jordan_market_clean

--Number of unique colorways
select  count(DISTINCT Colorway) as No_of_colorways
from jordan_market_clean

--Available sales channels
select  Sales_channel,count(Sales_channel) as no_of_transaction
from jordan_market_clean
group by Sales_channel;

--Distribution of product conditions

select Condition,count(Condition) no_of_transaction
from jordan_market_clean
group by Condition

/*
EDA Summary:

The dataset contains 5,000 sneaker resale transactions recorded between 2023-01-01 and 2025-09-27. It includes 5 unique shoe models and 9 colorways, with sales distributedacross 
five sales channels and three product conditions. The dataset provides sufficient coverage to support business analysis of sales performance, profitability, customer demand,
and inventory efficiency.
*/
--------------------------------------
--Basic statistics for numeric columns
--------------------------------------
--highest and lowest Retail price
select max(Retail_Price_USD) as highest_Retail_Price, min(Retail_Price_USD) as lowest_Retail_Price
from jordan_market_clean

--highest and lowest Resail price
select max(Resale_Price_USD) as highest_Resale_Price, min(Resale_Price_USD) as lowest_Resale_Price
from jordan_market_clean

--Lowest and highest profit
SELECT MIN(Profit_Margin_USD) AS lowest_Profit, MAX(Profit_Margin_USD) AS highest_Profit 
from jordan_market_clean

--Lowest and highest inventory days
SELECT MIN(Days_in_Inventory) as  Lowest_InventoryDays, MAX(Days_in_Inventory) AS highest_InventoryDays
from jordan_market_clean

/*
Summary Statistics:

Retail prices, resale prices, profit margins, and inventory days vary considerably across transactions, indicating a diverse range of products and market performance.
The wide spread of these values suggests the dataset is suitable for analyzing pricing strategies, profitability, and inventory efficiency.
*/

------------------------------------------------------------
--5. Business Analysis
------------------------------------------------------------
--5.1 Product Performance Analysis
--Business Goal: Understand which products customers buy the most.
------------------------------------------------------------------

--Which shoe models have the highest sales volume?
select Shoe_Model, count(*) as sales_volume
from jordan_market_clean
group by Shoe_Model
order by sales_volume desc;
/*
Business Insight:
Air Jordan 4 Retro recorded the highest sales volume in the dataset, indicating strong customer demand compared to the other shoe models.
*/

-- Which shoe model and colorway combinations have the highest sales volume?
select Shoe_Model,Colorway, count(*) as sales_volume
from jordan_market_clean
group by Shoe_Model,Colorway
order by sales_volume desc;
/*
Business Insight:
The combination of Air Jordan 1 Low – Pine Green recorded the highest sales volume in the dataset, indicating strong customer demand. Other top-selling shoe model–colorway 
combinations also demonstrate consistent customer interest and can be considered strong performers based on sales volume.

Business Recommendation:
Prioritize high-demand shoe model–colorway combinations when planning inventory and marketing strategies. Additionally, evaluate profitability and inventory turnover before
making final stocking decisions to ensure strong sales also generate strong business value.
*/

--Which colorways are most popular across all models?
select Colorway,count(Colorway) as sales_volume
from jordan_market_clean
group by Colorway
order by sales_volume desc;

/*
Business Insight:
Lost & Found recorded the highest sales volume among all colorways in the dataset, indicating strong overall customer demand across different shoe models.

Business Recommendation:
Prioritize inventory planning for high-demand colorways while continuing to monitor profitability and inventory turnover to prevent overstocking.
*/

----------------------------------------------------------------------
--5.2 Profitability Analysis
--Business Goal: Identify the products that contribute the most profit.
-----------------------------------------------------------------------

--Which shoe models generate the highest total profit?
select Shoe_Model,sum(Profit_Margin_USD) as total_profit
from jordan_market_clean
group by Shoe_Model
order by total_profit desc;

/*
Business Insight:
Air Jordan 4 Retro generated the highest total profit in the dataset, indicating that it contributed the most overall profit among all shoe models.


Business Recommendation:
Consider prioritizing high-profit shoe models such as Air Jordan 4 Retro for inventory planning and marketing campaigns. However, profitability should also be evaluated 
alongside sales volume and inventory turnover before making strategic decisions.
*/

--Which shoe models generate the highest average profit per transaction?
select Shoe_Model, avg(Profit_Margin_USD) as Avg_Profit
from jordan_market_clean
group by Shoe_Model
order by Avg_Profit desc;

/*
Business Insight:
Air Jordan 11 Retro recorded the highest average profit per transaction in the dataset, indicating that each sale of this model generates more profit on average than the other 
shoe models.

Business Recommendation:
Consider prioritizing high-margin shoe models such as Air Jordan 11 Retro to maximize profit per sale, while also evaluating their sales volume and inventory turnover to ensure
overall business performance.
*/


--Which shoe models record the highest number of loss-making transactions?
select Shoe_Model,count(*) as loss_transaction_count
from jordan_market_clean
where Profit_Margin_USD < 0
group by Shoe_Model
order by loss_transaction_count desc;

/*
Business Insight:
Air Jordan 3 Retro recorded the highest number of loss-making transactions (425), followed by Air Jordan 1 Low (410). This indicates that these models experienced losses more 
frequently than the other shoe models in the dataset.


Business Recommendation:
Investigate the pricing strategy, acquisition costs, and sales performance of shoe models with a high number of loss-making transactions. Reducing frequent losses on these models 
can improve overall profitability while maintaining sales performance.
*/





----------------------------------------------------------------------
--5.3 Sales Channel Analysis
--Business Goal: Evaluate the performance of different sales channels.
----------------------------------------------------------------------

--Which sales channel generates the highest total profit?
select Sales_Channel,sum(Profit_Margin_USD) as total_profit
from jordan_market_clean
group by Sales_Channel
order by total_profit desc;

/*
Business Insight:
Walk-in Retail generated the highest total profit among all sales channels, followed closely by GOAT. This suggests that Walk-in Retail is the strongest contributor to
overall profitability in the current dataset.

Business Recommendation:
Continue investing in high-performing sales channels such as Walk-in Retail while monitoring the performance of other channels. However, total profit should be evaluated
alongside sales volume and average profit per transaction before making strategic decisions.
*/

--Which sales channel generates the highest average profit?
select Sales_Channel,avg(Profit_Margin_USD) as avg_profit
from jordan_market_clean
group by Sales_Channel
order by avg_profit desc;
/*
Business Insight:
Walk-in Retail recorded the highest average profit per transaction among all sales channels, indicating that each sale through this channel generated more profit on average 
than the other channels.

Business Recommendation:
Consider prioritizing Walk-in Retail for high-margin products while continuing to evaluate sales volume and inventory turnover to ensure it delivers strong overall business
performance.
*/

--Which sales channel has the highest sales volume?
select Sales_Channel,count(*) as sales_volume
from jordan_market_clean
group by Sales_Channel
/*
Business Insight:
GOAT recorded the highest sales volume in the dataset with 1,032 transactions, closely followed by StockX with 1,027 transactions. This indicates that customer demand is relatively
evenly distributed across the leading sales channels.

Business Recommendation:
Continue supporting high-performing sales channels such as GOAT and StockX while evaluating profitability and inventory turnover alongside sales volume to identify the most effective 
overall sales strategy.
*/

--Which sales channel sells products the fastest?
select Sales_Channel,AVG(Days_in_Inventory) as avg_inventory_days
from jordan_market_clean
group by Sales_Channel
order by avg_inventory_days asc;
/*
Business Insight:
GOAT and StockX recorded the lowest average inventory time (7 days), indicating the fastest inventory turnover among all sales channels. In contrast, Walk-in Retail showed the 
longest average inventory period (33 days), suggesting products remain in inventory longer before being sold.

Business Recommendation:
Consider using GOAT and StockX for products where fast inventory turnover is a priority. For Walk-in Retail, review inventory management and sales strategies to reduce holding
time while maintaining profitability.
*/


-------------------------------------------
--5.4 Inventory Analysis
--Business Goal: Improve inventory turnover.
-------------------------------------------

--Which shoe models sell the fastest based on average inventory days?
select Shoe_Model,avg(Days_in_Inventory) as avg_inventory_days
from jordan_market_clean
group by Shoe_Model
order by avg_inventory_days asc;
/*
Business Insight:
Air Jordan 11 Retro recorded the lowest average inventory time (21 days), making it the fastest-selling shoe model in the dataset. However, the average inventory days across all
shoe models range from 21 to 23 days, indicating that inventory turnover is relatively consistent across the product lineup.

Business Recommendation:
Continue maintaining efficient inventory management for fast-selling models such as Air Jordan 11 Retro. Since inventory turnover is similar across all shoe models, stocking 
decisions should also consider profitability and customer demand to maximize overall business performance.
*/

--Is there a relationship between inventory turnover and profitability?
SELECT 
    CASE
    WHEN Days_in_Inventory BETWEEN 0 AND 10 THEN '0-10 Days'
    WHEN Days_in_Inventory BETWEEN 11 AND 20 THEN '11-20 Days'
    WHEN Days_in_Inventory BETWEEN 21 AND 30 THEN '21-30 Days'
    ELSE '31+ Days'
END AS Inventory_Category,AVG(Profit_Margin_USD) AS Average_Profit,COUNT(*) as no_of_transaction 
FROM jordan_market_clean
GROUP BY
    CASE
    WHEN Days_in_Inventory BETWEEN 0 AND 10 THEN '0-10 Days'
    WHEN Days_in_Inventory BETWEEN 11 AND 20 THEN '11-20 Days'
    WHEN Days_in_Inventory BETWEEN 21 AND 30 THEN '21-30 Days'
    ELSE '31+ Days'
END
ORDER BY Inventory_Category;

/*
Business Insight:
Average profit does not consistently decrease as inventory days increase. Products in the 31+ day inventory category recorded the highest average profit, 
indicating that slower inventory turnover does not necessarily reduce profitability.
*/

/*
Business Recommendation:
Evaluate products using both inventory turnover and profitability rather than selling speed alone to make better inventory and pricing decisions.
*/


--------------------------------------------------------
--5.5 Product Condition Analysis
--Business Goal: Understand how condition affects pricing.
---------------------------------------------------------
--How does product condition affect resale price?
select Condition,avg(Resale_Price_USD) as avg_resale_price,COUNT(*) no_of_transaction
from jordan_market_clean 
group by Condition
order by avg_resale_price desc;

/*
Business Insight:
Deadstock sneakers recorded the highest average resale price, indicating that product condition has a strong influence on resale value.

Recommendation:
Prioritize acquiring and preserving sneakers in excellent condition to maximize resale value.
*/

--How does product condition affect profit?
select Condition,AVG(Profit_Margin_USD) as avg_Profit, count(*) as no_of_transactions
from jordan_market_clean
group by Condition
order by avg_Profit desc;
/*
Business Insight:
Product condition has a significant impact on profitability. Deadstock (Brand New) sneakers generate the highest average profit,
while Used sneakers result in an average loss. Similar transaction counts across conditions make this comparison reliable.

Business Recommendation:
Prioritize sourcing and selling Deadstock sneakers to maximize profitability, and review the pricing or sourcing strategy for Used sneakers
to reduce losses.
*/

-------------------------------------------
--5.6 Demand Analysis
--Business Goal: Understand customer demand.
-------------------------------------------
--Which colorways have the highest demand?
select Colorway,count(*) as no_of_transaction
from jordan_market_clean
group by Colorway
order by no_of_transaction desc;
/*
Business Insight:
Lost & Found recorded the highest number of transactions, making it the most in-demand colorway in the dataset. Pine Green, Chicago, Black Cat, 
and Military Blue also show consistently strong customer demand.

Business Recommendation:
Prioritize inventory and marketing efforts for high-demand colorways while monitoring their profitability to ensure strong sales also translate
into strong business returns.
*/


--Do popular colorways remain popular across different shoe models?
select Shoe_Model,Colorway, count(*) as no_of_transaction
from jordan_market_clean
group by Shoe_Model,Colorway
order by no_of_transaction desc;

/*
Business Insight:
Several colorways, including Lost & Found, Chicago, Pine Green, and Black Cat, appear among the top-selling shoe model–colorway combinations.
This suggests that these colorways maintain strong customer demand across multiple shoe models.

Business Recommendation:
Prioritize high-demand colorways across multiple shoe models when planning inventory and product releases. Continue monitoring their profitability
and sales performance to ensure strong demand translates into strong business returns.
*/

-----------------------
--5.7 Overall Product Performance
-----------------------
--Which shoe model and colorway combinations provide the best balance of sales volume, profitability, and inventory turnover?
SELECT
    Shoe_Model,
    Colorway,
    COUNT(*) AS Sales_Volume,
    AVG(Profit_Margin_USD) AS Avg_Profit,
    AVG(Days_in_Inventory) AS Avg_Inventory_Days
FROM jordan_market_clean
GROUP BY Shoe_Model, Colorway;
/*
Business Insight:

The analysis shows that no single shoe model–colorway combination outperforms all others across sales volume, profitability, and inventory turnover.
Instead, several combinations perform well across different metrics, indicating that product performance should be evaluated based on business priorities rather than a single KPI.


Business Recommendation:
Prioritize inventory, marketing, and restocking efforts for shoe model–colorway combinations that consistently perform well across sales volume,
profitability, and inventory turnover rather than focusing on a single performance metric.
*/



----------------------
--6. Executive Summary
----------------------

--• Analyzed 5,000 sneaker resale transactions using SQL Server.
--• Evaluated product performance, profitability, demand, inventory turnover, and sales channels.
--• Found that product condition was strongly associated with both resale price and profitability.
--• Identified high-demand colorways and product combinations that consistently perform well across key business metrics.
--• Provided recommendations to improve inventory planning and maximize profitability.

--------------
--7.Conclusion
---------------
/*
This project demonstrates how SQL can be used to clean, validate, and analyze business data to support decision-making. By examining sales performance, profitability,
inventory turnover, and customer demand, the analysis provides actionable insights that can help optimize inventory planning and improve business performance.
*/

