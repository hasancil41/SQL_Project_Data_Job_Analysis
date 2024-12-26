# README for Top-Paying Remote Senior Data Scientist Jobs Query

## Overview
This SQL query identifies the top 10 highest-paying Senior Data Scientist roles that are available remotely. It focuses on job postings with specified salaries, prioritizing those posted in the first quarter of the year.

## Purpose
The query aims to:
1. Highlight the highest-paying opportunities for Senior Data Scientist roles.
2. Provide insights into employment options with location flexibility.

## Query Breakdown
### **Tables Used**
- **`job_postings_fact`**: Contains details of job postings.
- **`company_dim`**: Contains company information, joined with `job_postings_fact` to retrieve company names.

### **Filters Applied**
1. **Salary**: Excludes jobs without a specified average annual salary.
   ```sql
   WHERE salary_year_avg IS NOT NULL
   ```

2. **Job Title**: Focuses on roles with the title "Senior Data Scientist."
   ```sql
   AND job_title_short = 'Senior Data Scientist'
   ```

3. **Remote Work**: Includes only jobs marked as remote with a location of "Anywhere."
   ```sql
   AND job_work_from_home IS TRUE
   AND job_location = 'Anywhere'
   ```

4. **Posted Date**: Targets jobs posted in the first quarter (January to March).
   ```sql
   AND EXTRACT(QUARTER FROM job_posted_date) = 1
   ```

5. **Sorting and Limiting**: Fetches the top 10 jobs with the highest average annual salary.
   ```sql
   ORDER BY salary_year_avg DESC
   LIMIT 10
   ```

### **Columns Selected**
- **`job_posted_date`**: Date when the job was posted.
- **`company_name`**: Name of the company offering the role (joined from `company_dim`).
- **`job_id`**: Unique identifier for the job posting.
- **`job_title_short`**: Job title (short form).
- **`job_location`**: Location, filtered to "Anywhere" for remote roles.
- **`salary_year_avg`**: Average annual salary offered.
- **`job_work_from_home`**: Indicates if the job is remote.

## Full Query
```sql
SELECT job_posted_date::DATE,
    name as company_name,
    job_id,
    job_title_short,
    job_location,
    salary_year_avg,
    job_work_from_home
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE salary_year_avg IS NOT NULL
    AND job_title_short = 'Senior Data Scientist'
    AND job_work_from_home IS TRUE
    AND job_location = 'Anywhere'
    AND EXTRACT(
        QUARTER
        FROM job_posted_date
    ) = 1
ORDER BY salary_year_avg DESC
LIMIT 10;
```

## Expected Output
A list of the top 10 highest-paying remote Senior Data Scientist roles posted in the first quarter. The output includes the following columns:
- **Posting Date**
- **Company Name**
- **Job ID**
- **Job Title**
- **Location** (Filtered to "Anywhere")
- **Average Annual Salary**
- **Remote Work Indicator**

## Use Case
This query can help:
1. Job seekers find lucrative remote Senior Data Scientist opportunities.
2. Employers benchmark salaries for remote Senior Data Scientist roles.

## Enhancements
To improve or customize this query:
- Adjust the `job_title_short` filter to include variations like "Lead Data Scientist."
- Modify the quarter filter to target other periods (e.g., `EXTRACT(QUARTER FROM job_posted_date) = 2`).
- Include additional columns, such as job descriptions or required skills, for more context.

