# 📊 A/B Testing Campaign Analysis — Tableau Dashboard

A Tableau-based A/B testing analysis comparing two ad campaigns (**Campaign A: Control** vs **Campaign B: Test**) across spend, conversions, funnel performance, and cost efficiency.

---

## 🗂️ Project Overview

This project analyzes marketing campaign performance using A/B testing methodology. The dashboard was built in Tableau and covers:

- Total spend & purchase comparison
- Cost efficiency metrics (CPM, CPC, CTR)
- Conversion rate breakdown across the funnel
- Daily spend trends
- Full funnel analysis (Impressions → Purchases)

---

## 📈 Key Findings

### 🏆 Winner: Campaign B (Test Campaign)

| Metric | Campaign A (Control) | Campaign B (Test) |
|---|---|---|
| Total Spend | $68,653 | $76,892 |
| Total Purchases | 15,161 | 15,637 |
| Cost per Purchase | $4.53 | $4.92 |
| Overall Conversion Rate | 0.48% | **0.70%** |

> **Campaign B achieved a 46% higher overall conversion rate** despite a slightly higher cost per purchase.

---

## 💰 Cost Analysis

| Metric | Campaign A | Campaign B |
|---|---|---|
| CPM | $22 | $34 |
| CPC | $0.44 | $0.42 |
| CTR | 4.86% | **8.09%** |

- Campaign B's CTR is nearly **double** that of Campaign A, indicating its content was significantly more engaging.
- Despite a higher CPM, Campaign B's lower CPC shows it attracted higher-quality clicks.

---

## 🔄 Conversion Rate Breakdown

| Metric | Campaign A | Campaign B |
|---|---|---|
| Content View Rate | 36.53% | 30.80% |
| Cost per Add to Cart | $1.82 | $2.91 |
| Search Rate | 41.75% | 40.10% |
| Add to Cart Rate | **66.88%** | 47.45% |
| Purchase Rate | 40.21% | **59.13%** |

**Key Insight:** While Campaign A drove more users to add items to cart, Campaign B converted those users into buyers at a much higher rate (59.13% vs 40.21%). Campaign B traffic was more **"ready to buy."**

---

## 🔽 Funnel Analysis

| Funnel Stage | Campaign A | Campaign B |
|---|---|---|
| Impressions/Reach | 3,177,233 | 2,237,544 |
| Content Views | 2,576,503 | 1,604,747 |
| Searches | 154,303 | 180,970 |
| Add to Cart | 64,418 | 72,569 |
| Initiated Checkout | 56,370 | 55,740 |
| Purchases | 37,700 | 26,446 |

- Campaign A had broader **top-of-funnel reach** but suffered from high drop-off, suggesting lower audience quality.
- Campaign B reached **fewer people but with higher intent**, resulting in more searches and add-to-cart actions relative to its audience size.

---

## 📅 Daily Spend Trends

Both campaigns showed fluctuating daily spend patterns throughout the campaign period:

- **Campaign A** daily spend ranged from ~$1,757 to ~$3,083
- **Campaign B** daily spend ranged from ~$1,968 to ~$3,112

---

## 🛠️ Tools Used

- **Tableau** — Dashboard design and data visualization
- **Data Source** — Ad campaign performance metrics

---

## 📁 Repository Structure

```
├── README.md
├── /dashboard
│   ├── Cost_Conversion_Analysis.png
│   └── Funnel_Comparison.png
└── /data
    └── campaign_data.csv       # (if applicable)
```

---

## 🚀 How to Use

1. Clone this repository
2. Open the Tableau workbook (`.twbx`) in Tableau Desktop or Tableau Public
3. Connect to your data source or use the sample data provided
4. Explore the dashboard filters to drill down by campaign, date range, or funnel stage

---

## 📌 Conclusions & Recommendations

1. **Scale Campaign B** — Its higher conversion rate and lower CPC make it the more efficient campaign for driving purchases.
2. **Investigate Cart Drop-off in Campaign B** — Despite a lower Add to Cart rate, purchase conversion is strong. Optimizing the cart experience could further boost results.
3. **Audience Quality > Audience Size** — Campaign B's smaller but more targeted audience outperformed Campaign A's broader reach, reinforcing the value of precise targeting.
