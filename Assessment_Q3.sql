-- Creating a CTE to get the most recent successful transaction date for each plan
WITH last_transactions AS (
    SELECT 
        plan_id,  -- The unique plan identifier
        MAX(transaction_date) AS last_transaction_date  -- Latest transaction date per plan
    FROM my_database.savings_savingsaccount
    WHERE transaction_status = 'success'  -- Only consider successful transactions
    GROUP BY plan_id
),

-- Creating another CTE to get details of each plan (like categorizing the plan type) with its last transaction date
plans_with_last_txn AS (
    SELECT
        p.id AS plan_id,  -- Plan ID
        p.owner_id,  -- user ID of the plan
        CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'  -- Identify plan type as Savings
            ELSE 'Investment'  -- Otherwise, it's an Investment plan
        END AS type,
        lt.last_transaction_date  -- Last transaction date for the plan
    FROM my_database.plans_plan p
    LEFT JOIN last_transactions lt ON p.id = lt.plan_id
)

-- Select plans with transactions older than 1 year
SELECT
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATEDIFF(CURRENT_DATE, last_transaction_date) AS inactivity_days  -- Days since last transaction
FROM plans_with_last_txn
WHERE last_transaction_date IS NOT NULL  -- Only plans with at least one transaction
  AND last_transaction_date < DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)  -- Older than 1 year
ORDER BY inactivity_days DESC;  -- Sort by longest inactivity first