# High-Paying Job Postings Analysis (Q2)

This project analyzes trends in high-paying job postings in the United States for Q2, focusing on roles offering health insurance and requiring specific skills like Python, SQL, and Tableau. The dataset explores key features such as filtering by skills and aggregating data to identify top companies and their required skill sets.

## Objectives
- Identify the top 10 companies with the most job postings for high-paying roles (>$125,000 annual salary).
- Aggregate data to highlight the required skill sets for these roles.
- Focus on job postings that include health insurance benefits.

## Query Details
The SQL query used for the analysis:

```sql
SELECT
    COUNT(job_postings_fact.job_id) AS job_count,
    company_dim.name AS company_name,
    STRING_AGG(DISTINCT skills_dim.skills, ', ') AS skills
FROM job_postings_fact
    INNER JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    LEFT JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_health_insurance IS TRUE
    AND EXTRACT(QUARTER FROM job_postings_fact.job_posted_date) = 2
    AND job_postings_fact.job_country = 'United States' AND skills in ('python', 'sql', 'tableau')
GROUP BY company_dim.name
HAVING COUNT(job_postings_fact.job_id) > 1
   AND AVG(job_postings_fact.salary_year_avg) >= 125000
ORDER BY job_count DESC
LIMIT 10;
```

### Key Features of the Query
1. **Filters**:
   - Job postings offering health insurance (`job_health_insurance IS TRUE`).
   - Job postings in the United States.
   - Roles requiring specific skills: Python, SQL, and Tableau.
   - Job postings made in Q2 (second quarter).

2. **Aggregations**:
   - `COUNT(job_postings_fact.job_id)`: Counts the number of job postings per company.
   - `STRING_AGG(DISTINCT skills_dim.skills, ', ')`: Aggregates distinct skill sets for each company.

3. **Conditions**:
   - Average salary (`AVG(job_postings_fact.salary_year_avg)`) is at least $125,000 annually.
   - Companies with more than one qualifying job posting (`HAVING COUNT(job_postings_fact.job_id) > 1`).

4. **Ordering and Limiting**:
   - Results are ordered by the number of job postings (`job_count DESC`).
   - Top 10 companies are displayed (`LIMIT 10`).

## Expected Output
The query will return the following columns:
- **job_count**: The number of qualifying job postings for each company.
- **company_name**: The name of the company.
- **skills**: A comma-separated list of distinct skills required for these roles.

