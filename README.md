# 📊 Turning Data into Marketing Insights -- SQL RFM Segmentation + Tableau Sales Dashboard

## 📁 Project Overview

This Marketing Analytics project integrates SQL-based customer segmentation (RFM Analysis) with an interactive Tableau Sales Dashboard to unlock insights into customer behavior, sales trends, product performance, and market dynamics.

The goal is to transform raw transactional data into actionable insights that support data-driven marketing decisions.

## 📌 Objectives

1. Identify high-value customers using RFM (Recency, Frequency, Monetary) segmentation.

2. Analyze sales performance across countries, product lines, and years.

3. Evaluate order fulfillment efficiency through order status breakdown.

4. Build an interactive Tableau dashboard for monitoring sales KPIs.

| Category         | Technology                                                  |
| ---------------- | ----------------------------------------------------------- |
| Database & Query | **SQL**                                                     |
| Analytics Model  | **RFM Analysis**                                            |
| Visualization    | **Tableau**                                                 |
| Skills           | Data Prep, Segmentation, Trend Analysis, Marketing Insights |


## 🧹 Data Preparation (SQL)

SQL was used to:

      1. Clean and transform raw data
      2. Aggregate sales by country, product, and year
      3. Calculate Recency, Frequency, and Monetary value
      4. Create the RFM segmentation table
      5. Join, filter, and optimize data for Tableau

Example operations include:

<img width="781" height="386" alt="Screenshot 2026-03-12 at 23 55 22" src="https://github.com/user-attachments/assets/37e19898-e9c6-4aa0-bb09-e42976368b4e" />

<img width="781" height="540" alt="Screenshot 2026-03-12 at 23 56 40" src="https://github.com/user-attachments/assets/66f5c24c-0685-4c0b-b064-417c0de46472" />

<img width="781" height="483" alt="Screenshot 2026-03-12 at 23 57 06" src="https://github.com/user-attachments/assets/c934292c-ae2e-4683-ae15-eba43cfdb5a8" />

<img width="990" height="625" alt="Screenshot 2026-03-13 at 00 03 49" src="https://github.com/user-attachments/assets/7d7f6aec-14f7-4a87-a0f5-8428635036be" />

## 🎯 RFM Segmentation

Using SQL, customers were assigned into segments:

    1. Champions
    2. Loyal Customers
    3. Potential Loyalists
    4. Need Attention
    5. At Risk
    6. Hibernating
    7. Lost Customers

These segments help marketers tailor retention strategies and optimize customer lifetime value (CLV).

### 📈 Sales Trend Analysis (2003–2005)
### ⭐ Strong Growth in 2004

Almost all product lines experienced significant growth:

| Product Line   | 2003   | 2004   | Growth %    |
| -------------- | ------ | ------ | ----------- |
| Classic Cars   | $1.48M | $1.76M | **+18.69%** |
| Motorcycles    | $370K  | $560K  | **+51.13%** |
| Planes         | $272K  | $502K  | **+84.63%** |
| Ships          | $244K  | $341K  | **+39.46%** |
| Trucks & Buses | $420K  | $529K  | **+25.90%** |
| Vintage Cars   | $650K  | $911K  | **+40.01%** |
| Trains         | $72K   | $116K  | **+59.75%** |


# ➡️ 2004 was the peak revenue year, indicating strong demand and effective sales strategy.

📉 Drop in 2005

Revenue decreases across all product lines (~58–68%) are due to partial-year data (only first 5 months), confirmed via the monthly sales chart in Tableau.

## 📊 Dashboard Insights
1. Country-Level Sales

        * The United States is the top revenue contributor.

        * Helps prioritize high-performing markets and allocate marketing resources.

2. Order Status Efficiency

       * Shipped orders dominate → strong operational performance.

        * On Hold, Cancelled, and Disputed orders indicate areas for process improvement.

3. Product Line Performance

        * Classic Cars is the best-selling category.

        * Medium-sized deals generate the highest revenue.
   
        * We should also pay attention to Productline = "Planes", knowing that those also contributed to a high percentage of sales from 2003-2004

5. Revenue Trend Over Time

        * Strong growth in 2004

        * Lower revenue in 2005 due to partial data

        * Useful for forecasting and KPI tracking


## 📊 Tableau Dashboards
<img width="1402" height="590" alt="Screenshot 2026-03-13 at 00 06 35" src="https://github.com/user-attachments/assets/bb26f2f8-4a7d-4e5c-8bdc-8ada8bdc0a00" />

<img width="1402" height="590" alt="Screenshot 2026-03-13 at 00 07 10" src="https://github.com/user-attachments/assets/5dbaa1e6-7212-4582-a207-7022cefc7f62" />
