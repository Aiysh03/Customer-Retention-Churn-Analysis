-- What is the total customers, total transactions  and  total revenue?
SELECT 
    COUNT(DISTINCT user_id) AS total_customer,
    COUNT(transaction_id) AS total_transactions,
    SUM(amount) AS total_revenue
FROM
    transactions;

-- What is the average order value and average revenue per customer?
WITH calculations AS(SELECT 
    SUM(amount) AS total_revenue,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT user_id) AS total_customers
FROM
    transactions)
SELECT 
    total_revenue / total_orders AS avg_order_value,
    total_revenue / total_customers avg_revenue_per_cus
FROM
    calculations;

-- What percentage of customers are one-time buyers?
WITH frequent AS (SELECT 
    user_id, COUNT(*) AS frequency
FROM
    transactions
GROUP BY user_id)
SELECT 
    ROUND(COUNT(CASE
                WHEN frequency = 1 THEN 1
            END) * 100.00 / COUNT(*),
            2) AS onetime_percent
FROM
    frequent;

-- What is the distribution of orders per customer?
WITH frequent_user AS(SELECT 
    user_id, COUNT(*) AS frequency
FROM
    transactions
GROUP BY user_id)
SELECT 
    frequency, COUNT(*) AS num_of_cus
FROM
    frequent_user
GROUP BY frequency
ORDER BY frequency;

-- How does monthly revenue trend over time?
SELECT 
    DATE_FORMAT(transaction_date, '%Y,%m') AS years_month,
    SUM(amount) AS Revenue
FROM
    transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y,%m')
ORDER BY years_month;

-- What is the cumulative (running) revenue over time?
with daily as(select date(transaction_date) as dates, sum(amount) as revenue from transactions group by date(transaction_date))
select dates, revenue, sum(revenue) over(order by dates) as running_revenue from daily;

-- Who are the top 10 customers by revenue?
with ranking as(select user_id, sum(amount) as revenue_total from transactions group by user_id)
select * from (select user_id, revenue_total, dense_rank() over(order by revenue_total desc) as revenue_rank from ranking)
ranked where revenue_rank <=10 order by revenue_rank;

-- What percentage of total revenue is contributed by top 20% customers?
with sales as (SELECT 
    user_id, SUM(amount) AS totalrevenue
FROM
    transactions
GROUP BY user_id),
percent as (select totalrevenue, ntile(5) over(order by totalrevenue desc) as bucket from sales)
SELECT 
    SUM(CASE
        WHEN bucket = 1 THEN totalrevenue
        ELSE 0
    END) * 100 / SUM(totalrevenue) AS top_20
FROM
    percent;

-- What is the churn rate based on 90-day inactivity?
with activity as (select user_id, max(transaction_date) as last_purchase from transactions group by user_id)
select round(sum(case when datediff((select max(transaction_date) from transactions),last_purchase) > 90 then 1 else 0 end) * 100.0 / 
count(*),2) as churn_rate_percent from activity;

-- What is the average time gap between purchases per customer?
with gaps as (select user_id, transaction_date, lag(transaction_date) over(partition by user_id order by transaction_date) as prev_date from transactions)
select round(avg(datediff(transaction_date,prev_date)),2) as avg_days_bet_pur from gaps where prev_date is not null;

--  Perform RFM segmentation and classify customers into 4 segments.
with base_rfm as(select user_id, datediff((select max(transaction_date) from transactions),
max(transaction_date)) as recency, count(*) as frequency, sum(amount) as monetary from transactions group by user_id),
rfm_score as( select *,
						ntile(4) over(order by recency asc) as r_score,
						ntile(4) over(order by frequency desc) as f_score,
                        ntile(4) over(order by monetary desc) as m_score from base_rfm),
 rfm_segment as (select*, concat(r_score, f_score, m_score) as rfm_code,
 case
 when r_score >=3 and f_score >=3 then "Loyal Customers"
 when r_score>=3 and f_score <=2 then "Frequent Customers"
 when r_score<=2 and f_score >=3 then "Verge of Risk"
 else "Lost Customer" end as segments from rfm_score)
 SELECT segments, COUNT(*) AS customer_count, SUM(monetary) AS segment_revenue, ROUND(SUM(monetary) * 100.0 / SUM(SUM(monetary)) OVER (), 2) AS revenue_percent
FROM rfm_segment GROUP BY segments ORDER BY segment_revenue DESC;
