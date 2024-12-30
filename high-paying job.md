# Job Postings Analysis

## Overview
This SQL query extracts insights from a job postings dataset to provide monthly and yearly trends, identify high-paying jobs, and create a detailed view for further analysis and visualization. Specifically, it targets job postings with an average annual salary exceeding $150,000 and includes health insurance benefits.

## Query Explanation

### Input Tables
- **`job_postings_fact`**: Contains detailed job posting information such as posting dates, job attributes, and salaries.
- **`company_dim`**: Stores company-related information like company name and ID.

### Query Logic
1. **Extract Date Components**:
   - `job_posted_date::DATE`: Converts the job posting date into a standard date format.
   - `TO_CHAR(job_posted_date, 'Month')`: Extracts the name of the month from the posting date.
   - `EXTRACT(YEAR FROM job_posted_date)`: Extracts the year component for annual grouping.

2. **Filter Criteria**:
   - `job_health_insurance = TRUE`: Filters jobs where health insurance is provided.
   - `HAVING avg(salary_year_avg) > 150000`: Ensures the selected jobs have an average annual salary exceeding $150,000.

3. **Aggregation and Grouping**:
   - Groups data by relevant job attributes such as location, title, and company.
   - Calculates the average annual salary with `ROUND(AVG(salary_year_avg), 2)`.

4. **Sorting**:
   - Orders the results by `salary_year_avg` in descending order to prioritize high-paying jobs.

### Final Output Columns
- **`job_posted_date`**: The date the job was posted.
- **`month_name`**: The name of the month extracted from `job_posted_date`.
- **`year_num`**: The year extracted from `job_posted_date`.
- **`job_id`**: Unique identifier for each job posting.
- **`job_title`**: The title of the job.
- **`name`**: The name of the company.
- **`job_location`**: The location of the job posting.
- **`avg_salary`**: The average annual salary, rounded to 2 decimal places.
- **`job_health_insurance`**: Indicates whether health insurance is offered.
- **`link`**: The URL or link to the job posting for further reference.

## Query Code
```sql
SELECT job_posted_date::DATE,
    TO_CHAR (job_posted_date, 'Month')
     AS month_name,
    EXTRACT(
        YEAR
        FROM job_posted_date
    ) AS year_num,
    job_id,
    job_title,
    name,
    job_location,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary,
    job_health_insurance,
    link
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_health_insurance = TRUE
GROUP BY job_location,
    job_posted_date,
    job_title,
    link,
    job_id,
    name,
    salary_year_avg
HAVING AVG(salary_year_avg) > 150000
ORDER BY salary_year_avg DESC;
```

## How to Use
1. **Data Preparation**:
   - Ensure the `job_postings_fact` and `company_dim` tables are populated with relevant data.
   - Verify that salary data (`salary_year_avg`) and health insurance status (`job_health_insurance`) are correctly recorded.

2. **Run the Query**:
   - Use your SQL client or analytics tool to execute the query.
   - Review the output for insights about high-paying jobs.

3. **Analyze the Results**:
   - Use the monthly and yearly insights to identify trends.
   - Focus on jobs offering high salaries and health insurance to explore potential opportunities.
   - Export the results for further visualization in tools like Tableau or Power BI.

## Expected Output
The query will return a dataset with:
- High-paying job postings (average salary > $150,000).
- Monthly and yearly trends of job postings.
- Comprehensive details like job title, location, and company name.

## Use Cases
- **Recruitment Analysis**: Identify top job opportunities based on salary and benefits.
- **Trend Analysis**: Understand how job postings vary across months and years.
- **Company Benchmarking**: Compare company offerings to identify industry leaders.
- **Visualization**: Use the detailed dataset for creating dashboards and reports.

---

**Note**: Ensure appropriate indexing on `job_posted_date` and `company_id` columns for optimal query performance.
