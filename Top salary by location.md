# Average Salary by Job Location Query

## Overview

This SQL query calculates the average salary by job location from the `job_postings_fact` table. It returns the top 10 job locations with the highest average salaries, excluding any locations with a `NULL` average salary.

## Query Description

The query is broken down into two main parts:

1. **Common Table Expression (CTE):**  
   The `avg_salary_by_location` CTE calculates the average salary per job location by grouping the data based on the `job_location` column and rounding the average salary (`salary_year_avg`) to two decimal places.

2. **Main Query:**  
   The main query selects the `job_location` and `avg_salary` from the CTE. It filters out any locations where the average salary is `NULL`, sorts the results by `avg_salary` in descending order, and limits the results to the top 10 job locations.

## SQL Query

```sql
WITH avg_salary_by_location AS (
    SELECT job_location,
        round(avg(salary_year_avg), 2) as avg_salary
    FROM job_postings_fact
    GROUP BY job_location
)
SELECT job_location,
    avg_salary
FROM avg_salary_by_location
WHERE avg_salary IS NOT NULL
ORDER BY avg_salary DESC
LIMIT 10;
