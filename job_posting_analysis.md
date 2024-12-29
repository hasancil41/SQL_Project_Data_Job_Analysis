# Job Postings Analysis

This project contains an SQL query to analyze job postings from a job postings database. The query retrieves data about job titles, locations, companies, and salaries for job postings of a specific role, in this case, "Data Analyst." Additionally, it compares the individual job postings' salaries to the overall average salary and displays relevant insights.

## Project Description

The SQL query performs the following:

- Retrieves job postings with the title "Data Analyst."
- Compares each job posting's salary to the average salary in the database.
- Displays the job title, location, company ID, salary, and the overall average salary for job postings.
- Filters out job postings where the salary is below the overall average salary.

### SQL Query Breakdown

```sql
WITH avg_salary AS (
    SELECT ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact
)
SELECT 
    job_title_short,
    job_location,
    company_id,
    salary_year_avg,
    (SELECT ROUND(AVG(salary_year_avg), 1)
     FROM job_postings_fact) AS avg_salary
FROM job_postings_fact, avg_salary
WHERE salary_year_avg > avg_salary.avg_salary
  AND job_title_short = 'Data Analyst';
