-- Select user details and their savings or investment info
SELECT 
    ut.id AS owner_id,  -- User ID
    CONCAT(ut.first_name, ' ', ut.last_name) AS name,  -- User Full name
    sp.savings_count,  -- Number of funded savings plans
    ip.investment_count,  -- Number of funded investment plans
    FORMAT(sp.total_deposits / 100, 0) AS total_deposits_naira  -- Total confirmed savings deposits in naira, formatted with a seperator
FROM my_database.users_customuser ut

-- Select the number of savings plans and total deposits for each user
JOIN (
    SELECT 
        s.owner_id,
        COUNT(DISTINCT s.plan_id) AS savings_count,
        SUM(s.confirmed_amount) AS total_deposits
    FROM my_database.savings_savingsaccount s
    JOIN my_database.plans_plan p ON s.plan_id = p.id
    WHERE s.transaction_status = 'success'
      AND p.is_regular_savings = 1
    GROUP BY s.owner_id
) sp ON ut.id = sp.owner_id

-- Select the number of funded investment plans for each user
JOIN (
    SELECT 
        owner_id,
        COUNT(*) AS investment_count
    FROM my_database.plans_plan
    WHERE is_a_fund = 1 AND amount > 0
    GROUP BY owner_id
) ip ON ut.id = ip.owner_id

ORDER BY sp.total_deposits DESC;