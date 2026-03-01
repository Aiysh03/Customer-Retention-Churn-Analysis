# Customer-Retention-Churn-Analysis
## Project Objective
The objective of this project is to analyze customer purchasing behavior, measure churn rate, identify revenue concentration patterns, and perform RFM segmentation to derive actionable business insights.

## Dataset Overview
1. Total Customers: 500
2. Total Transactions: 4,000
3. Total Revenue: ₹10,276,416
4. Date Range: 2022-01-01 to 2023-12-31

## Key Business Questions Solved
1. Total customers, transactions, and revenue
2. Average order value and revenue per customer
3. Percentage of one-time buyers
4. Distribution of orders per customer
5. Monthly revenue trend
6. Cumulative revenue growth
7. Top 10 customers by revenue
8. Revenue contribution of top 20% customers
9. Average time gap between purchases
10. RFM segmentation and segment revenue contribution

## Key Insights
1. Revenue is moderately concentrated, with the top 20% contributing 32.6%, reducing dependency risk on a small customer base.
2. Only 0.2% customers are one-time buyers, showing strong repeat behavior.
3. Revenue trend is seasonal but stable without drastic decline.
4. A churn rate of 36.6% suggests significant reactivation opportunity, particularly among high-monetary lost customers.
5. Lost Customers segment contributes the highest revenue, suggesting reactivation opportunities.

## Business Recommendations
- Implement targeted reactivation campaigns for high-value lost customers.
- Introduce tier-based loyalty program to retain premium customers.
- Monitor purchase gap trends as early churn signals.
- Implement value-based retention strategies to protect margins while re-engaging high-risk customers.

## Project Workflow
1. Data Preparation (MySQL)
- Imported raw transaction dataset into MySQL.
- Cleaned date formats and handled null values.
- Created structured transactions table.
- Performed aggregations and window function analysis.
- Built RFM segmentation logic.
- Calculated churn rate using last purchase date logic.

2. KPI Extraction
- Exported SQL outputs:
1. Monthly revenue
2. Customer frequency distribution
3. Top 10 customers
4. RFM segment summary
5. Churn rate
- Imported results into Excel using Power Query.

3. Dashboard Development (Excel)
- Designed interactive KPI dashboard
- Created:
* Revenue trend line chart
* RFM revenue distribution
* Top 10 customers bar chart
* Customer frequency histogram
- Added business insight summary panel

## Technical Skills Demonstrated
1. MySQL (Data Analysis, CTEs, Window Functions)
2. Excel (Power Query, Charts, KPI Cards)
3. Data Modeling (RFM Segmentation)
4. Business Insight Generation

## Conclusion
This analysis highlights revenue concentration patterns, repeat purchase behavior, and customer churn risk using advanced SQL techniques. The findings provide a foundation for targeted retention strategies and data-driven customer lifecycle management.
