# Unique Average Hourly Salary Query

This repository contains an SQL query that retrieves a unique `job_id` for each distinct average hourly salary (`salary_hour_avg`) from a dataset of job postings. The query ensures that only one representative `job_id` is returned for each unique salary value, using a Common Table Expression (CTE) and the `ROW_NUMBER()` function.

---

## Query Overview

### Purpose
- To retrieve unique `job_id`s for each distinct `salary_hour_avg` in the dataset, ensuring there are no duplicate salary values in the output.

### Key Features
- **Use of Common Table Expression (CTE)**: Simplifies the query by creating a temporary result set (`RankedSalaries`) for easier filtering.
- **Ranking with `ROW_NUMBER()`**: Assigns a unique rank to each `job_id` within the same `salary_hour_avg` group.
- **Filtering**: Returns only the top-ranked `job_id` (`rn = 1`) for each `salary_hour_avg` value.
- **Excludes Null Salaries**: Filters out rows where `salary_hour_avg` is `NULL`.
- **Sorted Results**: Outputs the data in descending order of `salary_hour_avg`.

---

## SQL Query

```sql


WITH RankedSalaries AS (
    SELECT 
        job_id,
        salary_hour_avg,
        ROW_NUMBER() OVER (PARTITION BY salary_hour_avg ORDER BY job_id) AS rn
    FROM job_postings_fact
)
SELECT 
    job_id,
    salary_hour_avg
FROM RankedSalaries
WHERE rn = 1 AND salary_hour_avg IS NOT NULL
ORDER BY salary_hour_avg DESC;
