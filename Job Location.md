# Job Postings Analysis - Data Scientist

This repository contains an SQL query to analyze job postings for the position of "Data Scientist." The query categorizes job locations and calculates salary metrics (minimum, maximum, and average salaries) based on the dataset.

---

## SQL Query

```sql
/* 
 Number of jobs listed for location category:
 - 'Anywhere' jobs are categorized as 'Remote'
 - 'New York, NY' jobs are categorized as 'Local'
 - All other locations are categorized as 'On-Site'
 Also calculates:
 - Min, Max, and Avg salary for 'Data Scientist' roles
*/
SELECT count(job_id) as number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'On-Site'
    END AS location_category,
    min(salary_year_avg) as min_salary,
    max(salary_year_avg) as max_salary,
    round(avg(salary_year_avg), 2) as avg_salary
FROM job_postings_fact
WHERE job_title_short = 'Data Scientist'
GROUP BY location_category
ORDER BY number_of_jobs DESC;
```

---

## Key Insights

### 1. **Job Location Categorization**
Jobs are classified into three categories:
- **Remote**: Jobs with a location of "Anywhere."
- **Local**: Jobs located in "New York, NY."
- **On-Site**: Jobs in all other locations.

### 2. **Salary Metrics**
- **Minimum Salary**: The lowest annual salary offered for "Data Scientist" roles.
- **Maximum Salary**: The highest annual salary offered for "Data Scientist" roles.
- **Average Salary**: The average annual salary offered, rounded to two decimal places.

---

## Tools Used

- **Database**: SQL-based job postings database
- **Query Language**: SQL

---

## Usage

1. Copy and paste the SQL query into your database query editor.
2. Run the query to generate insights on job postings and salary metrics for "Data Scientist" roles.

---

## Example Output

| Number of Jobs | Location Category | Min Salary | Max Salary | Avg Salary |
|----------------|-------------------|------------|------------|------------|
| 150            | Remote            | $90,000    | $150,000   | $120,000   |
| 120            | Local             | $95,000    | $180,000   | $130,000   |
| 100            | On-Site           | $85,000    | $170,000   | $115,000   |

---





