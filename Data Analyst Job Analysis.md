# Data Analyst Job Analysis for [Company Name]

## Overview
This project analyzes job postings data to provide insights into the **Data Analyst** job market in the United States. The analysis focuses on the following key areas:
1. **Experience Levels:** Classification of job postings by seniority.
2. **Remote Work Options:** Identification of remote-friendly roles.
3. **Salary Categorization:** Segmentation of salaries into High, Average, and Lower categories.
4. **Skills Requirements:** Aggregated list of desired skills for Data Analyst positions.

---
## SQL Code
```sql
SELECT job_postings_fact.job_id,
    company_dim.NAME AS company_name,
    STRING_AGG(skills_dim.skills, ', ') AS skills,  -- Aggregating skills into a single string
    ROUND(job_postings_fact.salary_year_avg, 1) AS rounded_salary,
    CASE
        WHEN job_postings_fact.job_title ILIKE '%Senior%' THEN 'Senior'
        WHEN job_postings_fact.job_title ILIKE '%Manager%' OR job_postings_fact.job_title ILIKE '%Lead%' THEN 'Lead/Manager'
        WHEN job_postings_fact.job_title ILIKE '%Junior%' OR job_postings_fact.job_title ILIKE '%Entry%' THEN 'Junior/Entry'
        ELSE 'Not specific'
    END AS experience_level,
    CASE
        WHEN job_postings_fact.job_work_from_home THEN 'Yes'
        ELSE 'No'
    END AS remote_option,
    CASE
        WHEN job_postings_fact.salary_year_avg > 150000 THEN 'High_Salary'
        WHEN job_postings_fact.salary_year_avg BETWEEN 125001 AND 150000 THEN 'Avg_Salary'
        ELSE 'Lower_salary'
    END AS salary_option
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_country = 'United States'
    AND job_postings_fact.job_title = 'Data Analyst'
    AND skills_dim.skills IS NOT NULL
GROUP BY job_postings_fact.job_id, company_dim.NAME, job_postings_fact.salary_year_avg, job_postings_fact.job_title, job_postings_fact.job_work_from_home
ORDER BY job_postings_fact.salary_year_avg DESC;
## Query Breakdown

### Selected Columns
1. **Job ID:** Unique identifier for each job posting.
2. **Company Name:** The name of the company offering the job.
3. **Skills:** Aggregated list of required skills for the job posting.
4. **Rounded Salary:** Average annual salary rounded to one decimal place.
5. **Experience Level:** Categorization of experience based on job title keywords:
   - **Senior:** Titles containing "Senior."
   - **Lead/Manager:** Titles containing "Manager" or "Lead."
   - **Junior/Entry:** Titles containing "Junior" or "Entry."
   - **Not Specific:** Titles without specific experience indicators.
6. **Remote Option:** Indicates whether the job offers work-from-home opportunities ("Yes" or "No").
7. **Salary Category:** Salary segmentation:
   - **High_Salary:** Salaries above $150,000.
   - **Avg_Salary:** Salaries between $125,001 and $150,000.
   - **Lower_salary:** Salaries $125,000 and below.

---

### Data Sources
The query joins the following tables:
1. **job_postings_fact:** Main fact table containing job postings data.
2. **company_dim:** Dimension table providing company details.
3. **skills_job_dim:** Bridge table linking jobs to required skills.
4. **skills_dim:** Dimension table listing individual skills.

---

### Filtering Criteria
1. Only jobs with:
   - **Non-null salaries.**
   - **"United States"** as the job location.
   - The **job title "Data Analyst."**
   - Non-null skills.

---

### Sorting and Grouping
- **Grouped By:** Job ID, company name, salary, job title, and remote work option.
- **Ordered By:** Annual salary (descending).

---

## Sample Output

| Job ID  | Company Name    | Skills                         | Salary ($) | Experience Level | Remote Option | Salary Category |
|---------|-----------------|--------------------------------|------------|------------------|---------------|-----------------|
| 101     | DataTech Inc.   | SQL, Python, Tableau          | 160,000    | Senior           | Yes           | High_Salary     |
| 102     | Insights Corp.  | Excel, R, Power BI            | 140,000    | Lead/Manager     | No            | Avg_Salary      |
| 103     | Analytics LLC   | SQL, Python, Statistics       | 115,000    | Junior/Entry     | Yes           | Lower_salary    |

---

## Use Cases
- **Job Seekers:** Identify Data Analyst roles based on experience level, salary, and remote options.
- **HR Professionals:** Benchmark salaries and skills for competitive job postings.
- **Employers:** Analyze competitor offerings in the Data Analyst job market.

---

## Potential Enhancements
1. **Visualization:** Create interactive dashboards to visualize experience levels, salary ranges, and required skills.
2. **Location Analysis:** Add geographic distribution to analyze job postings by state or city.
3. **Time Trends:** Analyze how salaries and remote opportunities change over time.

---

This analysis provides actionable insights into the Data Analyst job market, helping companies and job seekers make informed decisions.
