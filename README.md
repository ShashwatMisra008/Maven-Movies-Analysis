# 🎬 Maven Movies: Advanced SQL Analytics & Database Engineering

A production-grade SQL portfolio project showcasing advanced data analysis, database engineering, and business intelligence reporting using the Maven Movies relational database. 

---

## 💼 Overview

Designed to demonstrate technical mastery in complex relational database management, multi-table querying, and procedural programming. This project solves critical business intelligence requirements—ranging from customer lifetime value and rental cohort analysis to automated database routines and reporting views.

---

## 🛠️ Technical Stack & Skills Demonstrated

* **Advanced Querying:** Correlated subqueries, multi-table joins, and aggregate filtering.
* **Window Functions:** Cohort ranking (`RANK()`, `DENSE_RANK()`, `PERCENT_RANK()`) and cumulative calculations (`SUM() OVER`).
* **Common Table Expressions (CTEs):** Modularised data pipelines for actor co-appearance networks and category metrics.
* **Database Views:** Abstracted, secure layers for client status tracking and inventory analysis.
* **Stored Procedures & Functions:** Parameterised business logic (`IN` / `OUT` parameters) for automated catalogue and payment lookups.

---

## 📊 Core Business Problems Solved & Technical Implementation

* **Customer Behaviour Analysis:** Identified high-value customers renting above aggregate portfolio averages using nested subqueries, and segmented top-tier spending cohorts using `PERCENT_RANK()`.
* **Revenue & Performance Tracking:** Generated top-10 customer payment leaderboards via aggregate groupings and computed category-wise running totals using window frames.
* **Network & Graph Analysis:** Built optimised self-join CTE pipelines to map recurring actor collaborations within the same film library.
* **Database Automation:** Developed reusable stored procedures featuring transactional parameters (`IN` / `OUT`) to fetch films by custom ratings, pull top-rented inventories, and compute customer payment totals dynamically.

---

## 📂 Repository Structure

```text
├── database/
│   └── maven_movies_schema.sql    # Relational schema and dataset
├── scripts/
│   └── maven_movies_solutions.sql # Production-ready SQL queries & routines
└── README.md                      # Comprehensive project documentation
