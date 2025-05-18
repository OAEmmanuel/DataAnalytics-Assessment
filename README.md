# DataAnalytics-Assessment
This repository contains SQL queries used for Cowrywise Data Analyst Assessment. This queries analysed the customers transactions, their savings and investment plans. Specifically, this repository contains the following queries: 
- Assessment_Q1: This query returned customers with at least one funded savings plan and one funded investment plan, sorted by total deposits.
- Assessment_Q2: This query calculated and returned the average number of transactions per customer per month and with categorizations into 'Low frequency', 'Medium frequency' and 'High frequency'.
- Assessment_Q3: This query returned all active accounts (savings or investments) with no transactions in the last 1 year or 365 days.
- Assessment_Q4: This query returned customers account tenure (in months) since signup, cusomters total transactions count and estimated CLV, sorted by estimated CLV in descending order.

# Assessment_Q1: Valuable Customers - with at least at least one funded savings plan and one funded investment plan.
Explanation:
- The first part of the query is to get all users info from the users table.
- The second part is to join the savings data (only regular savings with successful transactions) to calculate how many savings plans each user has and how much they have deposited in total.
- The third part is to join the investment data (only funded investment plans) to calculate how many investments each user has.
- The next part was to filter the data to show only customers who have at least one savings and one investment.
- Finally, the data was sorted based on how much these users have deposited (in descending order). These deposit values are formatted in naira (total deposits in kobo / 100) and with comma separators.

This allows the business team to easily spot users who are using multiple products (which is ideal for cross-selling opportunities) and contributing significant value to their business.

