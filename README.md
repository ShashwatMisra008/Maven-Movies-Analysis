# Maven Movies SQL Analytics

A production-grade SQL portfolio project showcasing advanced data analysis, database engineering, and business intelligence reporting using the Maven Movies relational database. 

## 💼 Overview
Designed to demonstrate proficiency in complex data manipulation and procedural programming for data analytics and database management roles. This project solves complex business intelligence requirements—ranging from customer lifetime value and rental cohort analysis to automated database routines and reporting views.

## 🛠️ Technical Stack & Skills Demonstrated
* **Advanced Querying:** Correlated subqueries, multi-table joins, and aggregate filtering.
* **Window Functions:** Cohort ranking (`RANK()`, `DENSE_RANK()`, `PERCENT_RANK()`) and cumulative calculations (`SUM() OVER`).
* **Common Table Expressions (CTEs):** Modularised data pipelines for actor co-appearance networks and category metrics.
* **Database Views:** Abstracted, secure layers for client status tracking and inventory analysis.
* **Stored Procedures & Functions:** Parameterised business logic (`IN`/`OUT` parameters) for automated catalogue and payment lookups.

## 📊 Core Business Problems Solved
* **Customer Behaviour Analysis:** Identified high-value customers renting above aggregate portfolio averages and segmented top-tier spending cohorts using per cent ranks.
* **Revenue & Performance Tracking:** Generated top-10 customer payment leaderboards and calculated category-wise running totals.
* **Network & Graph Analysis:** Built self-join CTE pipelines to map recurring actor collaborations within the same film library.
* **Database Automation:** Developed reusable stored procedures to fetch films by custom ratings, pull top-rented inventories, and compute customer payment totals dynamically.
