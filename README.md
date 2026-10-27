# Jordan Sneaker Market Analysis | SQL Server & Power BI

## Project Summary

This project demonstrates end-to-end data analysis using SQL Server and Power BI. It covers data validation, exploratory data analysis (EDA), business analysis, and interactive dashboard development to generate actionable business insights for sneaker resale market performance.

---

## Business Problem

Businesses operating in the sneaker resale market must balance customer demand, profitability, inventory turnover, and sales channel performance when making product selection and inventory investment decisions.

Without data-driven analysis, it becomes difficult to identify which products deserve additional investment, which sales channels generate the greatest value, or how operational factors such as inventory turnover and product condition influence profitability.

This project addresses these challenges by analyzing historical transaction data to answer key business questions and provide actionable recommendations for improving business performance.

The analysis focuses on answering questions such as:

- Which shoe models generate the highest sales and profit?
- Which colorways show the strongest demand based on transaction volume?
- Which sales channels perform best?
- How does product condition affect resale price and profitability?
- Which shoe models sell the fastest based on inventory turnover?
- Which shoe model–colorway combinations should the business prioritize based on overall performance?
- Which shoe models are most associated with loss-making transactions?
- Which sales channels turn over inventory the fastest?

---

## Dataset Overview

The dataset contains **5,000 Air Jordan sneaker market transactions**, providing detailed information about product characteristics, pricing, inventory, and sales performance.

### Dataset Features

| Column | Description |
|---------|-------------|
| Transaction_ID | Unique identifier for each transaction |
| Sale_Date | Date of sale |
| Shoe_Model | Jordan sneaker model |
| Colorway | Product colorway |
| Condition | Product condition |
| Retail_Price_USD | Original retail price |
| Resale_Price_USD | Selling price |
| Sales_Channel | Sales platform where the product was sold |
| Days_in_Inventory | Number of days before the product was sold |
| Profit_Margin_USD | Resale price minus original retail price; fees and other expenses are not deducted |

**Metric Interpretation:** Throughout this project, the terms “profit” and “loss” refer to the dataset's `Profit_Margin_USD` measure, calculated as resale price minus original retail price. The measure does not account for fees or other expenses, so it should not be interpreted as actual net profit or confirmed financial loss.
---

## Dataset Source

This project uses the **Air Jordan Sneaker Market and Resale Data (2023–2026)** dataset from Kaggle, containing 5,000 sneaker resale records with information on pricing, inventory, sales channels, and the difference between resale and retail prices.

**Source:** Kaggle – https://www.kaggle.com/datasets/abdullahmeo/air-jordan-sneaker-market-and-resale-data2023-2026

*Note:* While the dataset is titled "2023–2026" on Kaggle, the actual transaction records analyzed in this project span January 2023 to September 2025.

*Note:* This dataset was used for educational and portfolio purposes. Its records have not been independently verified as actual marketplace transactions, so findings should be interpreted as patterns within the dataset rather than confirmed real-world market outcomes. All SQL analysis, business insights, and Power BI dashboards were independently developed.

---

## Tools & Technologies

| Category | Technology |
|----------|------------|
| Database | SQL Server |
| Query Language | SQL |
| Data Visualization | Power BI |
| Version Control | Git & GitHub |

---

## Project Workflow

The project follows a structured business analytics workflow, progressing from understanding the business problem to delivering actionable insights through SQL analysis and interactive Power BI dashboards.

```text
Business Problem
        │
        ▼
Data Validation & Preparation
        │
        ▼
Exploratory Data Analysis (EDA)
        │
        ▼
Business Analysis
        │
        ▼
Business Insights & Recommendations
        │
        ▼
Interactive Power BI Dashboard
```
---

## Business Analysis

The SQL analysis was organized into seven business-focused domains to answer real business questions and support data-driven decision-making.

The analysis covers:

1. **Product Performance** – Evaluates sales performance across shoe models and colorways.
2. **Profitability** – Compares the dataset's resale–retail price differences across products and analyzes records with negative differences.
3. **Sales Channel Performance** – Compares profitability, sales volume, and inventory efficiency across different sales channels.
4. **Inventory Analysis** – Evaluates inventory turnover and its relationship with profitability.
5. **Product Condition Analysis** – Compares resale prices and resale price differences across product conditions.
6. **Demand Analysis** – Identifies the most popular colorways and demand patterns across shoe models.
7. **Overall Product Performance** – Evaluates products by balancing sales volume, profitability, and inventory efficiency.

Each business domain was analyzed using SQL Server, followed by business insights and recommendations. The final findings were visualized through interactive Power BI dashboards.

---

## Power BI Dashboard

The SQL analysis was transformed into an interactive, 3-page Power BI dashboard to enable business stakeholders to monitor performance, compare products, and support data-driven decision-making. Each page includes a Key Insight and Action callout, translating the underlying data into clear business takeaways.

The dashboard tells a complete story across 3 pages: a high-level performance overview, a deeper operational and risk analysis, and a final view on which products to prioritize going forward.

### 1. Executive Dashboard

A high-level overview of overall business performance through key KPIs and summary visualizations.

Includes:
- Total Transactions, Total Profit, Average Profit, Average Inventory Days
- Monthly Profit Trend
- Sales Volume by Colorway
- Total Profit by Shoe Model
- Total Profit by Sales Channel
- Sales Volume by Shoe Model

**Key Insight:** Air Jordan 4 Retro recorded the highest total resale price difference, while Air Jordan 11 Retro had the highest average resale price difference per transaction. Walk-in Retail recorded the highest total and average resale price differences among sales channels.
**Action:** Consider these results alongside transaction volume and inventory duration when making product selection and inventory allocation decisions.

![Executive Dashboard](Dashboard/Executive_Dashboard.png)

---

### 2. Business Performance Analysis

Detailed operational insights into profitability, inventory turnover, and loss-making transactions.

Includes:
- Total Loss Amount, Count of Loss-Making Transactions
- Average Profit and Resale Price by Product Condition
- Average Profit by Inventory Category
- Average Profit by Sales Channel
- Average Inventory Days by Shoe Model
- Inventory Turnover by Sales Channel
- Loss-Making Transactions by Shoe Model

**Key Insight:** Deadstock-condition items had the highest average resale prices and resale price differences. Of the 5,000 records, 1,933 had negative resale price differences, with a combined negative difference of approximately $98.2K.
**Action:** Prioritize sourcing and stocking Deadstock-condition inventory based on its observed resale-price performance, and investigate patterns in negative resale price differences to inform inventory decisions.

![Business Dashboard](Dashboard/Business_Performance_Dashboard.png)

---
### 3. Product Prioritization Analysis

Combines resale price performance, transaction volume, and inventory efficiency to guide product prioritization decisions.

Includes:
- Profit by Colorway
- Shoe Model × Colorway Profit Matrix
- Overall Performance comparison (Profit vs. Sales Volume vs. Inventory Turnover) by Shoe Model

**Key Insight:** No single shoe model leads across every metric. Resale price differences, transaction volume, and inventory turnover favour different models.
**Action:** Prioritize products according to the selected business goal, considering resale price differences, transaction volume, and inventory turnover.

![Product Prioritization Analysis](Dashboard/Product_Prioritization_Analysis.png)

---
## Key Insights

- Air Jordan 4 Retro generated the highest total resale price difference; Air Jordan 11 Retro had the highest average resale price difference per transaction.
- Walk-in Retail generated the highest total and average resale price differences among all sales channels, though it also has the slowest inventory turnover.
- GOAT and StockX turn over inventory the fastest (~7 days average), compared to Walk-in Retail (~33 days) — a significant efficiency gap across channels.
- Deadstock sneakers achieved the highest resale prices and resale price differences among all product conditions.
- Of 5,000 records, 1,933 had negative resale price differences, totalling approximately $98.2K. Used records accounted for 1,655 (~$95.4K), while VNDS accounted for 278 (~$2.75K). No records with negative resale price differences were observed for Deadstock (Brand New). In the condition-filtered model analysis, Air Jordan 3 Retro and Air Jordan 1 Low had the highest counts for Used, while Air Jordan 4 Retro led for VNDS.
- No single shoe model outperformed across every metric simultaneously. Resale price differences, transaction volume, and inventory turnover favoured different models, highlighting why product prioritisation should align with specific business goals rather than a single “best” product.

---

## Business Recommendations

Based on the analysis, the following recommendations are proposed:

- Prioritize high-performing shoe model–colorway combinations that consistently balance demand, profitability, and inventory efficiency.
- Consider transaction volume, positive resale price differences, and inventory duration when allocating inventory.
- Continue leveraging high-performing sales channels while investigating opportunities to improve lower-performing channels.
- Compare resale prices and resale price differences across product conditions when making sourcing decisions.
- Consider profitability alongside inventory turnover when making stocking decisions rather than relying on sales speed alone.

---

## Skills Demonstrated

- SQL
- Data Cleaning
- Data Validation
- Exploratory Data Analysis (EDA)
- Aggregate Functions
- CASE Expressions
- GROUP BY
- KPI Development
- Business Analytics
- Business Insight Generation
- Power BI Dashboard Design
- DAX (Measures, CALCULATE, DISTINCTCOUNT)
- Matrix & Scatter Chart Visualization
- Data Storytelling & Insight Communication

---

## Repository Structure

```text
Jordan-Sneaker-Market-Analysis/
│
├── Dataset/
│   └── jordan_market_dataset_2026.csv
│
├── SQL/
│   └── jordan_sneaker_market_analysis.sql
│
├── Power BI/
│   └── jordan_sneaker_market_analysis.pbix
│
├── Dashboard/
│   ├── Executive_Dashboard.png
│   ├── Business_Performance_Dashboard.png
│   └── Product_Prioritization_Analysis.png
│
└── README.md
```
---

## How to Run the Project

1. Import the dataset into SQL Server.
2. Execute the SQL script (`jordan_sneaker_market_analysis.sql`).
3. Open the Power BI dashboard (`jordan_sneaker_market_analysis.pbix`).
4. Refresh the Power BI data connection if prompted.
5. Explore the interactive dashboards using the available filters and slicers.

---

## Author

**Pranav P A**

- GitHub: https://github.com/Pranav175-bit
- LinkedIn: https://www.linkedin.com/in/pranav-p-a-8b3a57350/
 
---

## License

This project is licensed under the MIT License.
