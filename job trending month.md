# Job Posting Analysis: Data Analyst in New York, NY

## Overview

This SQL query tracks month-to-month trends in job postings for the **Data Analyst** role in **New York, NY**. It focuses on the following key insights:
- The number of job postings each month.
- The average annual salary for Data Analyst positions.
- Data is sorted in descending order by the number of job postings.

---

## SQL Query

```sql
-- Count the number of job postings for Data Analyst positions by month and year
-- Include average salary information for jobs with non-null salary values
SELECT 
    COUNT(job_id) AS job_posted, -- Total number of job postings in the group
    TO_CHAR(job_posted_date, 'Month') AS month_name, -- Extracts the month name (e.g., January)
    EXTRACT(YEAR FROM job_posted_date) AS year_num, -- Extracts the year (e.g., 2023)
    ROUND(AVG(salary_year_avg), 2) AS avg_salary -- Computes the average annual salary, rounded to 2 decimal places
FROM 
    job_postings_fact -- Source table containing job posting information
WHERE 
    job_title = 'Data Analyst' -- Filters to include only Data Analyst roles
    AND job_location = 'New York, NY' -- Filters to jobs based in New York, NY
    AND salary_year_avg IS NOT NULL -- Ensures only jobs with salary data are included
GROUP BY 
    EXTRACT(MONTH FROM job_posted_date), -- Groups by month (numerical value)
    TO_CHAR(job_posted_date, 'Month'), -- Groups by month name (for display)
    EXTRACT(YEAR FROM job_posted_date) -- Groups by year
ORDER BY 
    job_posted DESC; -- Orders the results by the number of job postings in descending order
