# Job Postings Salary Information Query

This repository contains an SQL query that categorizes job postings into two groups: those with and without salary information. The query focuses on specific job titles, such as "Data Analyst" and "Business Analyst," and outputs a structured result for further analysis.

---

## Query Overview

This SQL query performs the following operations:

1. **Categorizes Job Postings**:
   - Identifies whether a job posting includes salary information or not.
2. **Combines Results**:
   - Uses `UNION ALL` to combine two queries:
     - **First Query**: Selects job postings with salary information.
     - **Second Query**: Selects job postings without salary information.
3. **Sorting**:
   - Results are sorted by:
     - Salary information presence (`With salary info` first).
     - Job ID for consistent ordering.

---

## Query Details

### Input Table

- **`job_postings_fact`**:
  - Contains job posting details including:
    - `job_id`: Unique identifier for each job.
    - `job_title`: Title of the job (e.g., Data Analyst, Business Analyst).
    - `salary_hour_avg`: Average hourly salary (nullable).
    - `salary_year_avg`: Average yearly salary (nullable).

### Output Fields

| Field Name       | Description                                                   |
|------------------|---------------------------------------------------------------|
| `job_id`         | Unique identifier for the job posting.                        |
| `job_title`      | Title of the job (e.g., Data Analyst, Business Analyst).       |
| `salary_info`    | Indicator for salary information presence (`With`/`Without`). |

### Query Logic

1. **Filter by Job Titles**:
   - Focuses on the job titles "Data Analyst" and "Business Analyst."

2. **Check Salary Information**:
   - **With Salary Info**: At least one salary field (`salary_hour_avg` or `salary_year_avg`) is not null.
   - **Without Salary Info**: Both salary fields (`salary_hour_avg` and `salary_year_avg`) are null.

3. **Combine Results**:
   - `UNION ALL` merges the results from both queries.

4. **Sort Results**:
   - First by the presence of salary information (`With salary info` first).
   - Then by `job_id` for consistent ordering.

---

## Sample Query Output

| job_id | job_title         | salary_info          |
|--------|-------------------|----------------------|
| 101    | Data Analyst      | With salary info     |
| 102    | Business Analyst  | With salary info     |
| 201    | Data Analyst      | Without Salary info  |
| 202    | Business Analyst  | Without Salary info  |

---

## How to Use

1. **Copy the Query**:
   - Use the SQL script provided in the repository.
2. **Run in Your Database**:
   - Ensure the table `job_postings_fact` exists in your database.
   - Update the table or column names if necessary to match your schema.
3. **Analyze Results**:
   - Use the output to understand salary information availability for the specified job titles.

---

## Tools and Technologies

- **Database Management System**:
  - Compatible with SQL-based systems like MySQL, PostgreSQL, SQL Server, or Oracle.
- **Data Analysis**:
  - Designed for analyzing job postings datasets.

---




