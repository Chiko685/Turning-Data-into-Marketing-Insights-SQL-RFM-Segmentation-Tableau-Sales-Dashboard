# 🚗 Sales Analytics & RFM Customer Segmentation

An end-to-end sales analytics project combining **PostgreSQL** for data analysis and **Tableau** for interactive dashboards. The project analyzes sales performance across product lines, countries, and customer segments using RFM (Recency, Frequency, Monetary) analysis.

---

## 📌 Table of Contents

- [Project Overview](#project-overview)
- [Dashboards](#dashboards)
- [RFM Analysis](#rfm-analysis)
- [SQL Queries](#sql-queries)
- [Tech Stack](#tech-stack)
- [Dataset](#dataset)
- [How to Run](#how-to-run)
- [Project Structure](#project-structure)

---

## 🗂️ Project Overview

This project answers key business questions:

- 📦 Which **product lines** generate the most revenue?
- 🌍 Which **countries** contribute the most to sales?
- 📅 What was the **best month/year** for sales?
- 👤 Who are the **best customers**? (via RFM Analysis)
- 🔄 What is the **deal size distribution** across sales?

---

## 📊 Dashboards

### Dashboard 1 — Sales Overview

| Chart | Description |
|---|---|
| **Revenue by Product Line** | Bubble chart showing revenue contribution per product category |
| **Dealsize by Sales** | Bar chart comparing Large / Medium / Small deal sizes |
| **Revenue by Status** | Bubble chart breaking down order status (Shipped, Cancelled, etc.) |
| **Sales by Productline** | Line chart showing yearly trend per product line (2003–2005) |
| **Monthly Sales by Country** | Area chart showing monthly revenue trend per year |

**Filters:** Country, Product Line, Revenue Status

![Sales Dashboard 1](images/Sales_Dashboard_1.png)

---

### Dashboard 2 — Sales Distribution

| Chart | Description |
|---|---|
| **Sales by Country** | Treemap showing revenue proportion per country |
| **Quantity Distribution** | Line chart showing distribution of quantity ordered |
| **Customer Distribution by Country** | Bar chart of top customers by sales value |
| **Sales Distribution** | Histogram of sales value frequency |

**Filters:** Country

![Sales Dashboard 2](images/Sales_Dashboard_2.png)

---

## 👥 RFM Analysis

RFM segmentation was performed using **PostgreSQL** with `NTILE(4)` window functions to score customers across 3 dimensions:

| Dimension | Description |
|---|---|
| **R — Recency** | How recently did the customer purchase? |
| **F — Frequency** | How often do they purchase? |
| **M — Monetary** | How much do they spend in total? |

### Customer Segments (8 Segments)

| # | Segment | RFM Criteria |
|---|---|---|
| 1 | 🏆 **Champions** | R=1, F≥3, M≥3 |
| 2 | 💛 **Loyal** | R=1, F≥3, M≤2 OR F=2, M≥3 |
| 3 | 🌱 **Potential Loyalists** | R=1, F=2, M=2–3 |
| 4 | 🌟 **Promising** | R=2 |
| 5 | ⚠️ **Need Attention** | R=3, F≤2 |
| 6 | 🔴 **At Risk** | R=3, F≥3 |
| 7 | 😴 **Hibernating** | R=4, F≤2 |
| 8 | ❌ **Lost** | R=4, F≥3 |

### Sample Output

| Customer | RFM Recency | RFM Frequency | RFM Monetary | Segment |
|---|---|---|---|---|
| Australian Collectables, Ltd | 1 | 2 | 1 | CHAMPIONS |
| Gifts4AllAges.com | 1 | 3 | 2 | CHAMPIONS |
| Mini Gifts Distributors Ltd | 1 | 4 | 4 | POTENTIAL_LOYALIST |

---

## 🛢️ SQL Queries

### Best Sales Month

```sql
SELECT DISTINCT "MONTH_ID" AS MONTH,
  SUM("SALES") AS REVENUE,
  COUNT("ORDERNUMBER") AS TOTAL_NUMBER_ORDER,
  "PRODUCTLINE"
FROM sales_data_sample
WHERE "YEAR_ID" = 2004 AND "MONTH_ID" = 11
GROUP BY 1, 4
ORDER BY 2 DESC, 1 ASC;
```

### RFM Segmentation

```sql
DROP TABLE IF EXISTS RFM_TEMP;

CREATE TEMP TABLE RFM_TEMP AS
WITH RFM AS (
  SELECT
    "CUSTOMERNAME",
    SUM("SALES")        AS TOTAL_MONETARY,
    AVG("SALES")        AS AVG_MONETARY,
    COUNT("ORDERNUMBER") AS FREQUENCY,
    MAX("ORDERDATE")    AS LAST_ORDER_DATE,
    (SELECT MAX("ORDERDATE"::DATE) FROM sales_data_sample)
      - MAX("ORDERDATE"::DATE) AS RECENCY
  FROM sales_data_sample
  GROUP BY 1
  ORDER BY RECENCY DESC
),
RFM_CALC AS (
  SELECT *,
    NTILE(4) OVER (ORDER BY RECENCY)        AS RFM_RECENCY,
    NTILE(4) OVER (ORDER BY FREQUENCY)      AS RFM_FREQUENCY,
    NTILE(4) OVER (ORDER BY TOTAL_MONETARY) AS RFM_MONETARY
  FROM RFM
)
SELECT *,
  RFM_RECENCY + RFM_FREQUENCY + RFM_MONETARY AS RFM_TOTAL,
  CAST(RFM_RECENCY  AS VARCHAR)
    || CAST(RFM_FREQUENCY AS VARCHAR)
    || CAST(RFM_MONETARY  AS VARCHAR) AS RFM_CELL
FROM RFM_CALC;
```

### Customer Segment Assignment

```sql
SELECT "CUSTOMERNAME", "rfm_cell",
  CASE
    WHEN rfm_cell IN ('131','132','133','134','141','142','143','144') THEN 'CHAMPIONS'
    WHEN rfm_cell IN ('121','122','123','124','111','112','113','114') THEN 'LOYAL'
    WHEN rfm_cell IN ('231','232','233','234')                         THEN 'POTENTIAL_LOYALISTS'
    WHEN rfm_cell IN ('211','212','213','214','221','222','223','224') THEN 'PROMISING'
    WHEN rfm_cell IN ('311','312','313','314','321','322','323','324') THEN 'NEED_ATTENTION'
    WHEN rfm_cell IN ('331','332','333','334','341','342','343','344') THEN 'AT_RISK'
    WHEN rfm_cell IN ('411','412','413','414','421','422','423','424') THEN 'HIBERNATING'
    WHEN rfm_cell IN ('431','432','433','434','441','442','443','444') THEN 'LOST'
  END AS rfm_segment
FROM RFM_TEMP;
```

---

## 🛠️ Tech Stack

| Tool | Usage |
|---|---|
| **PostgreSQL** | Data storage & SQL analysis |
| **DBeaver** | SQL IDE for query development |
| **Tableau Public** | Interactive dashboard visualization |

---

## 📁 Dataset

- **Table:** `sales_data_sample`
- **Database:** PostgreSQL (`RFM analysis` schema)
- **Key Columns:**

| Column | Description |
|---|---|
| `CUSTOMERNAME` | Customer name |
| `SALES` | Order value |
| `ORDERNUMBER` | Unique order ID |
| `ORDERDATE` | Date of order |
| `PRODUCTLINE` | Product category |
| `COUNTRY` | Customer country |
| `MONTH_ID` | Month of order |
| `YEAR_ID` | Year of order |
| `DEALSIZE` | Deal size (Small / Medium / Large) |
| `STATUS` | Order status |

---

## ▶️ How to Run

### 1. Setup Database

```bash
# Create database in PostgreSQL
createdb "RFM analysis"

# Import dataset
psql -d "RFM analysis" -f sales_data_sample.sql
```

### 2. Run SQL Analysis

Open **DBeaver** and connect to:

```
Host     : localhost
Port     : 5433
Database : RFM analysis
Schema   : public
```

Run queries in this order:
1. `exploratory_analysis.sql` — Basic sales exploration
2. `rfm_analysis.sql` — RFM segmentation

### 3. View Dashboards

Open Tableau Public and connect the workbook to your PostgreSQL database,  
or view the published dashboards via the Tableau Public link below.

> 🔗 [View on Tableau Public](#) ← *(https://public.tableau.com/views/RFMAnalysis_17732423993690/SalesDash2?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)*

---

## 📬 Contact

Feel free to connect if you have questions or feedback about this project!
