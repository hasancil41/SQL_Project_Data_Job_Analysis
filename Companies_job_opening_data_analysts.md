# README for Query: Companies with Most Job Openings for Data Analysts

## Overview
This SQL query identifies companies with the most job openings for "Data Analyst" positions in the United States, focusing on companies with more than 100 job postings. Additionally, it calculates the average salary for these roles, excluding rows with null values for salary.

## Purpose
The query is designed to:
1. Highlight companies with significant hiring activity for Data Analysts.
2. Provide insights into average salaries for these roles.
3. Focus on opportunities in the United States, enabling location-specific analysis.

## Query Breakdown
### **Step 1: Subquery (CTE) - `company_job_count`**
The Common Table Expression (CTE) calculates the total number of job postings per company and job title, along with the average salary, filtered by:
- Companies with more than 100 job postings.
- Grouping by `company_id`, `job_title_short`, and `job_country`.

#### Columns in `company_job_count`:
- **`company_id`**: Identifier for the company.
- **`job_title_short`**: Job title (e.g., "Data Analyst").
- **`total_jobs`**: Total number of job postings for the company and job title.
- **`job_country`**: Country of the job postings (filtered to "United States").
- **`avg_salary`**: Average annual salary for the job postings (rounded to two decimal places).

### **Step 2: Main Query**
The main query joins the `company_dim` table with the CTE `company_job_count` to fetch company names. It filters the results to include:
1. Only "Data Analyst" roles.
2. Jobs in the United States.
3. Rows with non-null `avg_salary` values.
4. Companies with more than 100 job postings (pre-filtered in the CTE).

#### Selected Columns:
- **`company_name`**: Name of the company.
- **`total_jobs`**: Total job postings for "Data Analyst" roles.
- **`job_country`**: Country of the job postings (restricted to "United States").
- **`avg_salary`**: Average annual salary for the role.

### **Sorting**
The query sorts the results by `total_jobs` in descending order, highlighting companies with the highest hiring activity.

## Full Query
```sql
WITH company_job_count AS (
    SELECT company_id,
        job_title_short,
        COUNT(*) AS total_jobs,
        job_country,
        round(avg(salary_year_avg), 2) as avg_salary
    FROM job_postings_fact
    GROUP BY company_id,
        job_title_short,
        job_country
    HAVING COUNT(*) > 100
)
SELECT company_dim.name AS company_name,
    company_job_count.total_jobs,
    company_job_count.job_country,
    company_job_count.avg_salary
FROM company_dim
    LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
WHERE company_job_count.total_jobs IS NOT NULL
    AND company_job_count.job_title_short = 'Data Analyst'
    AND company_job_count.job_country = 'United States'
    AND company_job_count.avg_salary IS NOT NULL
ORDER BY total_jobs DESC;
```

## Expected Output
A table listing the following details for companies with significant hiring activity for Data Analysts:
- **Company Name**: The name of the company.
- **Total Jobs**: Total number of job postings for Data Analyst roles.
- **Job Country**: Restricted to "United States."
- **Average Salary**: The average annual salary for these roles.

## Use Case
This query is beneficial for:
1. Job seekers looking for companies actively hiring Data Analysts in the United States.
2. Employers benchmarking their hiring activity and salaries against competitors.
3. Analysts identifying trends in the Data Analyst job market.

## Enhancements
To customize or extend this query:
- Adjust the job title filter (`job_title_short`) to include variations like "Senior Data Analyst."
- Expand the geographic scope by removing or altering the `job_country` filter.
- Include additional metrics, such as job posting dates or required experience levels, for more detailed analysis.

