# DataAnalytics-Assessment
This repository contains SQL queries used for Cowrywise Data Analyst Assessment. This queries analysed the customers transactions, their savings and investment plans. Specifically, this repository contains the following queries: 
- Assessment_Q1: This query returned customers with at least one funded savings plan and one funded investment plan, sorted by total deposits.
- Assessment_Q2: This query calculated and returned the average number of transactions per customer per month and with categorizations into 'Low frequency', 'Medium frequency' and 'High frequency'.
- Assessment_Q3: This query returned all active accounts (savings or investments) with no transactions in the last 1 year or 365 days.
- Assessment_Q4: This query returned customers account tenure (in months) since signup, cusomters total transactions count and estimated CLV, sorted by estimated CLV in descending order.

# Assessment_Q1: High Value Customers with Multiple Products
Explanation:
- The first part of the query is to get all users info from the users table.
- The second part is to join the savings data (only regular savings with successful transactions) to calculate how many savings plans each user has and how much they have deposited in total.
- The third part is to join the investment data (only funded investment plans) to calculate how many investments each user has.
- The next part was to filter the data to show only customers who have at least one savings and one investment.
- Finally, the data was sorted based on how much these users have deposited (in descending order). These deposit values are formatted in naira (total deposits in kobo / 100) and with comma separators.

This allows the business team to easily spot users who are using multiple products (which is ideal for cross-selling opportunities) and contributing significant value to their business.

# Assessment_Q2: Transaction Frequency Analysis
Explanation:
- The first part of the query groups all transactions by user in every month, counting how many transactions each user made in that month.
- The second part of the query calculates the average number of transactions per month for each user by averaging the monthly counts.
- The third part groups users into three categories based on their average monthly transactions — High, Medium, or Low frequency.
- Finally, the query returns the number of users each category and finds the average transactions per user in those categories.
