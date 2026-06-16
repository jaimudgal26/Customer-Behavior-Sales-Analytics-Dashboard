SELECT * FROM customer LIMIT 5;

--- Q1. Which customer segments contribute the highest revenue?
WITH customer_segments AS
(
    SELECT *,
           CASE
               WHEN previous_purchases <= 10 THEN 'New Customer'
               WHEN previous_purchases BETWEEN 11 AND 30 THEN 'Returning Customer'
               ELSE 'Loyal Customer'
           END AS customer_segment
    FROM customer
)

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(SUM(purchase_amount),2) AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_spending
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_revenue DESC;

--- Q2. Do subscribed customers spend more than non-subscribed customers?
SELECT
    subscription_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount),2) AS avg_purchase_amount,
    ROUND(SUM(purchase_amount),2) AS total_revenue,
    ROUND(AVG(previous_purchases),2) AS avg_previous_purchases
FROM customer
GROUP BY subscription_status;

--- Q3. Which product categories generate the highest revenue?
SELECT
    category,
    COUNT(*) AS total_orders,
    ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer
GROUP BY category
ORDER BY total_revenue DESC;

--- Q4. Which age groups contribute the most to revenue?
SELECT
    age_group,
    COUNT(*) AS total_customers,
    ROUND(SUM(purchase_amount),2) AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_spending
FROM customer
GROUP BY age_group
ORDER BY total_revenue DESC;

--- Q5. How does gender influence purchasing behavior?
SELECT
    gender,
    COUNT(*) AS total_customers,
    ROUND(SUM(purchase_amount),2) AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_spending,
    ROUND(AVG(previous_purchases),2) AS avg_previous_purchases
FROM customer
GROUP BY gender;

--- Q6. What impact do discounts have on customer spending?
SELECT
    discount_applied,
    COUNT(*) AS total_orders,
    ROUND(AVG(purchase_amount),2) AS avg_spending,
    ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer
GROUP BY discount_applied;

--- Q7. Which shipping options are preferred by higher-spending customers?
SELECT
    shipping_type,
    COUNT(*) AS total_orders,
    ROUND(SUM(purchase_amount),2) AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_order_value
FROM customer
GROUP BY shipping_type
ORDER BY total_revenue DESC;

--- Q8. Which season generates the highest sales and revenue?
SELECT
    season,
    COUNT(*) AS total_orders,
    ROUND(SUM(purchase_amount),2) AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_order_value
FROM customer
GROUP BY season
ORDER BY total_revenue DESC;

--- Q9. What is the relationship between customer satisfaction and spending behavior?
SELECT
    ROUND(review_rating::numeric, 1) AS rating,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount),2) AS avg_spending,
    ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer
GROUP BY rating
ORDER BY rating DESC
LIMIT 5;

--- Q10. Which combination of customer demographics and product categories generates the highest revenue?
SELECT
    age_group,
    gender,
    category,
    COUNT(*) AS total_orders,
    ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer
GROUP BY age_group, gender, category
ORDER BY total_revenue DESC
LIMIT 5;
