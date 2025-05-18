# DataAnalytics-Assessment
This repository contains SQL queries used for Cowrywise Data Analyst Assessment. This queries analysed the customers transactions, their savings and investment plans. Specifically, this repository contains the following queries: 
- Assessment_Q1: This query returned customers with at least one funded savings plan and one funded investment plan, sorted by total deposits.
- Assessment_Q2: This query calculated and returned the average number of transactions per customer per month and with categorizations into 'Low frequency', 'Medium frequency' and 'High frequency'.
- Assessment_Q3: This query returned all active accounts (savings or investments) with no transactions in the last 1 year or 365 days.
- Assessment_Q4: This query returned customers account tenure (in months) since signup, cusomters total transactions count and estimated CLV, sorted by estimated CLV in descending order.
- Challenges faced during this assessment.

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
- The first part of the query groups all transactions by user in every month, counting how many transactions each user made in that month (with a CTE).
- The second part of the query calculates the average number of transactions per month for each user by averaging the monthly counts (with a CTE).
- The third part groups users into three categories based on their average monthly transactions — High, Medium, or Low frequency.
- Finally, the query returns the number of users each category and finds the average transactions per user in those categories.

# Assessment_Q3:  Account Inactivity Alert
Explanation:
- The first part of the query considers transaction records to find the most recent (latest) transaction date for only successful transactions for each plan (with a CTE).
- The second part of the query matches this latest transaction date with each plan and categorizes the plan to either "Savings" or "Investment" type (with a CTE).
- Finally, the query filters only plans where the last transaction happened over 365 days ago, and showing how many days it has been since the last transaction. Then, it is sorted so the longest inactive accounts come first.

The operations team can easily identify accounts that needs attention or follow-up with this query due to inactiveness.

# Assessment_Q4:  Customer Lifetime Value (CLV) Estimation
Explanation:
- The first part of the query calculates how long each user has had their account - in months (with a CTE).
- The second part of the query returns the total successful transactions and their value for each user (with a CTE).
- Finally, the query combines  the tenure and transaction information to estimate CLV in Naira, sorted by the estimated CLV from highest to the lowest.

The marketing team can easily identify customers with the most lifetime value, which can enable them develop strategies to retain such customers.

# Challenges faced during this assessment
1. Importing the Database from the Dump File:
My initial challenge was creating the database using the provided SQL dump file. Attempting to run the dump directly in MySQL Workbench didn't work as expected. To resolve this, I first created the database manually using the command prompt. After that, I successfully ran the dump query (which I had downloaded to my local machine) to populate and structure the database, naming it my_database.

2. Categorizing the Plans for Analysis:
Another challenge I encountered was in categorizing the plans. The plans_plan table contained only four unique plan IDs, along with two key binary columns: is_regular_savings and is_a_fund. However, there were additional plans that did not clearly fall under either of these flags. I initially expected each unique plan ID to have a descriptive name, which would have made classification easier but the description column had over 40 unique values. Since the task specifically required grouping plans into just two categories — Savings and Investment — I decided to classify all plans not marked as is_regular_savings as Investment for the purpose of answering question 3.
