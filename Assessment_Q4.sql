-- Creating a CTE to calculate account tenure in months for each user
WITH user_tenure AS (
    SELECT
        ut.id AS customer_id,  -- User ID
        CONCAT(ut.first_name, ' ', ut.last_name) AS name,  -- Full name
        TIMESTAMPDIFF(MONTH, ut.date_joined, CURRENT_DATE) AS tenure_months  -- number of months since signup
    FROM my_database.users_customuser ut
),

-- Creating another CTE to calculate total transactions and total value (in kobo) for each user
user_transactions AS (
    SELECT
        s.owner_id AS customer_id,  -- User ID
        COUNT(*) AS total_transactions,  -- Number of successful transactions
        SUM(s.confirmed_amount) AS total_transaction_value_kobo  -- Total value in kobo
    FROM my_database.savings_savingsaccount s
    WHERE s.transaction_status = 'success'
    GROUP BY s.owner_id
)

-- Combining tenure and transaction info to estimate Customer Lifetime Value (CLV) in Naira
SELECT
    ute.customer_id,  -- User ID
    ute.name,  -- Full name
    ute.tenure_months,  -- Account tenure in months
    utx.total_transactions AS total_transactions,  -- Total transactions
    FORMAT(
        CASE
            WHEN ute.tenure_months > 0 AND utx.total_transactions > 0 THEN
                -- Calculate average transactions per month * 12 * average transaction value (converted to Naira)
                (utx.total_transactions / ute.tenure_months) * 12 *
                ((utx.total_transaction_value_kobo / utx.total_transactions) / 100)  -- divide by 100 to convert kobo to naira
            ELSE 0  -- If tenure or transactions are zero, estimated CLV is 0
        END, 2) AS estimated_clv_naira
FROM user_tenure ute
LEFT JOIN user_transactions utx ON ute.customer_id = utx.customer_id
ORDER BY 
    CASE 	
        WHEN ute.tenure_months > 0 AND utx.total_transactions > 0 THEN
            (utx.total_transactions / ute.tenure_months) * 12 *
            ((utx.total_transaction_value_kobo / utx.total_transactions) / 100)
        ELSE 0
    END DESC;