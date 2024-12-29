# Job Schedule Type Salary Analysis

## Overview

This project analyzes the average salary based on different job schedule types using data from the `job_postings_fact` table. The SQL query calculates the average salary for each job schedule type and provides a ranking based on the highest average salary.

## Purpose

The goal of this analysis is to identify the average salary for each job schedule type and compare them. The output helps to understand the salary distribution across various work schedule categories and can aid in making data-driven decisions regarding compensation strategies.

## SQL Query Breakdown

The SQL query consists of two parts:

1. **CTE (`avgsalarybyschedule`)**: 
    - This Common Table Expression (CTE) calculates the average salary for each job schedule type (`job_schedule_type`) where the `salary_year_avg` is not null.
    - The `ROUND()` function is used to limit the average salary to two decimal places.
    - The data is grouped by `job_schedule_type`, and the results are ordered by `avg_salary` in descending order.

2. **Final SELECT Statement**: 
    - This selects the `job_schedule_type` and `avg_salary` from the CTE, which presents the results of the salary analysis for each schedule type.

### SQL Query:

```sql
WITH avgsalarybyschedule AS (
    SELECT job_schedule_type,
           ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY job_schedule_type
    ORDER BY avg_salary DESC
)
SELECT job_schedule_type,
       avg_salary
FROM avgsalarybyschedule;
