# Data Analyst Job Postings Analysis in New York City

## Overview
This query tracks month-to-month trends in job postings for **Data Analyst** roles located in **New York, NY**. The focus is on analyzing the total number of job postings, average annual salaries, and trends over time, with results ordered by the most recent job postings.

---

## Query Explanation

### Key Objectives:
1. **Count Job Postings**: Calculate the total number of job postings for Data Analyst roles.
2. **Monthly Trends**: Group job postings by month and year to observe trends.
3. **Average Annual Salary**: Calculate the average annual salary for the filtered job postings.
4. **New York Area**: Focus on roles located in New York, NY, and exclude postings without salary data.
5. **Sorting**: Present the data in descending order by the number of job postings.

### SQL Query:
```sql
SELECT 
    COUNT(job_id) AS job_posted,
    TO_CHAR(job_posted_date, 'Month') AS month_name,
    EXTRACT(YEAR FROM job_posted_date) AS year_num,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM 
    job_postings_fact
WHERE 
    job_title = 'Data Analyst'
    AND job_location = 'New York, NY'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    EXTRACT(MONTH FROM job_posted_date),
    TO_CHAR(job_posted_date, 'Month'),
    EXTRACT(YEAR FROM job_posted_date)
ORDER BY 
    job_posted DESC;
