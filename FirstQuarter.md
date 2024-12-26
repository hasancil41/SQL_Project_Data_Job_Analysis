# Job Postings Analysis - First Quarter 2023

## 📋 Overview
This repository contains an SQL query designed to analyze job postings from the first quarter of 2023 (January to March). The query filters job postings based on specific criteria to identify high-paying positions for Data Engineers in New York, NY.

---

## 🛠 Features
- Combines job postings from January, February, and March 2023.
- Filters for:
  - **Full-time** jobs.
  - **Data Engineer** positions.
  - Jobs located in **New York, NY**.
  - Jobs with an average yearly salary **greater than $100,000**.
  - Jobs offering **health insurance**.

---

## 📁 Files
- **`job_postings_query.sql`**: The SQL script for extracting the job postings based on the defined criteria.
- **`README.md`**: This documentation file explaining the project and its usage.

---

## 🚀 Usage
### 1. **Database Setup**
Ensure your database contains the following tables with job postings:
- `january_jobs`
- `february_jobs`
- `march_jobs`

### 2. **Run the Query**
1. Import the `job_postings_query.sql` file into your SQL editor.
2. Execute the query against the database.
3. Review the output to analyze job postings.

---

## 📊 Query Logic
The query:
1. Merges job postings from the three monthly tables using `UNION ALL`.
2. Applies filters for job title, location, salary, job type, and benefits.
3. Outputs a sorted list of matching job postings by the date they were posted.

---

### SQL Query:
```sql
-- Query to find Full-time Data Engineer job postings in New York, NY with a salary > $100k
SELECT 
    job_posted_date::DATE AS job_date,
    job_title_short AS title,
    job_location AS location,
    salary_year_avg AS salary,
    job_health_insurance AS health_insurance,
    job_schedule_type AS type
FROM (
    -- Combine job postings from January, February, and March
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
) AS quarter1_job_posting
WHERE 
    salary_year_avg > 100000
    AND job_title_short = 'Data Engineer'
    AND job_location = 'New York, NY'
    AND job_schedule_type = 'Full-time'
    AND job_health_insurance IS TRUE -- Ensure health insurance is provided
ORDER BY 
    job_posted_date;
