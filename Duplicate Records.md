# Job Postings Analysis SQL Queries

## Overview
This repository contains SQL queries used to analyze job postings data. The queries help extract insights about job titles, posting frequencies, and other key metrics from a database containing job-related information.

## Dataset Structure
The database consists of the following tables:

- **`job_postings_fact`**: Contains detailed information about job postings such as job titles, company IDs, job locations, and posting dates.

## Featured Query: Job Title Frequency Analysis
This query identifies job titles that appear more than once in the `job_postings_fact` table and orders them by frequency in descending order.

### SQL Query
```sql
SELECT job_title,
       count(*) AS job_count
FROM job_postings_fact
GROUP BY job_title
HAVING count(*) > 1
ORDER BY job_count DESC;
```

### Query Breakdown
1. **`SELECT job_title, count(*)`**:
   - Selects the job title and counts the number of occurrences for each title.

2. **`GROUP BY job_title`**:
   - Groups the results by `job_title` to aggregate counts per title.

3. **`HAVING count(*) > 1`**:
   - Filters out job titles that appear only once.

4. **`ORDER BY job_count DESC`**:
   - Sorts the results by the count of job titles in descending order.

### Example Output
| Job Title            | Job Count |
|----------------------|-----------|
| Data Analyst         | 50        |
| Business Analyst     | 45        |
| Software Engineer    | 40        |







