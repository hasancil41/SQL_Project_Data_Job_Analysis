# Query: Top 10 Highest Salaries by Job Title

This repository contains an SQL query that identifies the highest annual salaries for each job title and outputs the top 10 highest salaries among them. The query ensures that only the best-paid postings are considered for each unique job title.

---

## Query Overview

This SQL script achieves the following:

1. **Filters Job Postings**:
   - Identifies job postings with non-null yearly salary information.
2. **Ranks Job Postings by Salary**:
   - Uses `ROW_NUMBER()` to rank job postings within each job title based on salary in descending order.
3. **Filters for the Highest Salary**:
   - Keeps only the top-ranked job posting (highest salary) for each job title.
4. **Outputs Top 10 Salaries**:
   - Retrieves the top 10 job postings with the highest salaries across all job titles.

---

## Full Query

```sql
WITH main AS (
    SELECT *
    FROM job_postings_fact
),
ranked_jobs AS (
    SELECT 
        job_id,
        job_title_short,
        salary_year_avg,
        job_posted_date,
        ROW_NUMBER() OVER (
            PARTITION BY job_title_short 
            ORDER BY salary_year_avg DESC
        ) AS rank
    FROM 
        main
    WHERE 
        salary_year_avg IS NOT NULL
),
filtered_jobs AS (
    SELECT 
        job_id,
        job_title_short,
        salary_year_avg,
        job_posted_date
    FROM 
        ranked_jobs
    WHERE 
        rank = 1 -- Keep only the highest salary for each job_title_short
)
SELECT 
    job_id,
    job_title_short,
    salary_year_avg,
    job_posted_date
FROM 
    filtered_jobs
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
