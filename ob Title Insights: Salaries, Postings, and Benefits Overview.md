# Job Postings Analysis by Job Title

## Overview
This query provides an analysis of job postings grouped by job title, focusing on key metrics such as:
- Average annual salary
- Total number of job postings
- Number of postings offering health insurance
- Number of postings offering work-from-home options  

The results are sorted by **average annual salary** in descending order to highlight the most lucrative roles.

---

## Query Explanation

### Key Objectives:
1. **Average Salary by Job Title**: Calculate the average annual salary for each job title.
2. **Job Count by Title**: Count the total number of job postings for each job title.
3. **Health Insurance Availability**: Count the number of job postings offering health insurance for each job title.
4. **Work-from-Home Options**: Count the number of job postings offering work-from-home options for each job title.
5. **Combining Results**: Use Common Table Expressions (CTEs) to calculate these metrics separately and join them into a single, cohesive table.

---

## Query Breakdown

### CTEs (Common Table Expressions):
1. **`avg_salary_title`**:
    - Calculates the average annual salary for each job title using the `salary_year_avg` field.
    - Rounded to two decimal places for clarity.

2. **`job_count`**:
    - Counts the total number of job postings for each job title.
    - 
3. **`insurance_count`**:
    - Counts the number of postings offering health insurance (`job_health_insurance = TRUE`).
   
4. **`work_home`**:
    - Counts the number of postings offering work-from-home options (`job_work_from_home = TRUE`).
____________________________________________________________________________________________________   


Combines all CTEs using `JOIN` to generate a single table with all metrics:
```sql

WITH avg_salary_title AS (
    SELECT 
        job_title_short,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM 
        job_postings_fact
    GROUP BY 
        job_title_short
),
job_count AS (
    SELECT 
        job_title_short,
        COUNT(*) AS job_title_count
    FROM 
        job_postings_fact
    GROUP BY 
        job_title_short
),
insurance_count AS (
    SELECT 
        job_title_short,
        COUNT(
            CASE
                WHEN job_health_insurance = TRUE THEN 1
            END
        ) AS health_insurance
    FROM 
        job_postings_fact
    GROUP BY 
        job_title_short
),
work_home AS (
    SELECT 
        job_title_short,
        COUNT(
            CASE
                WHEN job_work_from_home = TRUE THEN 1
            END
        ) AS home_work
    FROM 
        job_postings_fact
    GROUP BY 
        job_title_short
)
SELECT 
    avg_salary_title.job_title_short,
    avg_salary,
    job_title_count,
    health_insurance,
    home_work
FROM 
    avg_salary_title
    JOIN job_count ON avg_salary_title.job_title_short = job_count.job_title_short
    JOIN insurance_count ON insurance_count.job_title_short = job_count.job_title_short
    JOIN work_home ON work_home.job_title_short = insurance_count.job_title_short
ORDER BY 
    avg_salary DESC;
