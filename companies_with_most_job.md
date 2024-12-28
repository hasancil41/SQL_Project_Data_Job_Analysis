# SQL Query to Identify Companies with the Most Job Openings

## Overview
This SQL query identifies companies with the highest number of job postings by aggregating and analyzing data from job posting records. It provides insights into the hiring trends and activity levels of companies, which can be valuable for job seekers, recruiters, and analysts.

## Purpose
The query aims to:
- Count the total number of job postings for each company.
- Return the total number of job postings along with the corresponding company names.
- Rank the companies based on the number of job postings in descending order.

## Query Logic
1. **CTE (Common Table Expression):**  
   - Calculates the total number of job postings (`total_jobs`) for each `company_id` by grouping the data from the `job_postings_fact` table.
   - The `COUNT(*)` function is used to aggregate the number of job postings.

2. **Main Query:**  
   - Joins the aggregated job counts from the CTE with the `company_dim` table using `company_id` as the key.
   - Retrieves the `company_name` and the total number of job postings (`total_jobs`) for each company.
   - Sorts the results in descending order by `total_jobs`.

## Query Code
```sql
WITH company_job_count AS (
    SELECT company_id,
        count(*) as total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
    LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC;
