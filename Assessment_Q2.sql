-- Creating a CTE to calculate the number of transactions each user made every month
WITH monthly_transactions AS (
    SELECT 
        s.owner_id,
        YEAR(s.transaction_date) AS year,
        MONTH(s.transaction_date) AS month,
        COUNT(*) AS transactions_in_month
    FROM my_database.savings_savingsaccount s
    WHERE s.transaction_status = 'success'
    GROUP BY s.owner_id, YEAR(s.transaction_date), MONTH(s.transaction_date)
),

-- Creating another CTE to calculate the average transactions per month for each user
average_transactions AS (
    SELECT
        owner_id,
        AVG(transactions_in_month) AS avg_transactions_per_month
    FROM monthly_transactions
    GROUP BY owner_id
)

-- Categorizing users based on their average transactions per month, counting how many users are in each category and calculating the average transactions per category
SELECT
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency' --  for 10 or more transactions/month
        WHEN avg_transactions_per_month >=3 THEN 'Medium Frequency' --  for 3 to 9 or more transactions/month
        ELSE 'Low Frequency' --  for 2 or less transactions/month
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month -- Average transactions for category, rounded
FROM average_transactions
GROUP BY frequency_category;