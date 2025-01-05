# README

## Overview
This SQL query retrieves a unique `job_id` for each distinct average hourly salary (`salary_hour_avg`) from the `job_postings_fact` dataset. The approach ensures that each unique salary value is represented by exactly one job ID.

## Key Components

### Common Table Expression (CTE): `RankedSalaries`
The query uses a CTE to rank job postings based on their average hourly salary. The `ROW_NUMBER()` function assigns a unique rank to each job posting within groups of identical `salary_hour_avg` values:

- **Partition By**: Divides the data into groups based on `salary_hour_avg`.
- **Order By**: Orders each group by `job_id`, ensuring a consistent selection of `job_id` when there are ties.

### Filtering and Output
1. **Filter by `rn = 1`**: Ensures only the first-ranked entry for each salary group is included in the final result.
2. **Exclude NULL Salaries**: The condition `salary_hour_avg IS NOT NULL` removes rows with undefined salary values.
3. **Order By Salary**: The final result is sorted in descending order of `salary_hour_avg`.

## Query
```sql
WITH RankedSalaries AS (
    SELECT 
        job_id,
        ROUND(salary_hour_avg, 2) AS salary_hour_avg,
        ROW_NUMBER() OVER (PARTITION BY ROUND(salary_hour_avg, 2) ORDER BY job_id) AS rn
    FROM job_postings_fact
)
SELECT 
    job_id,
    salary_hour_avg
FROM RankedSalaries
WHERE rn = 1 AND salary_hour_avg IS NOT NULL
ORDER BY salary_hour_avg DESC;
```

## How It Works
1. **CTE Creation**: The `RankedSalaries` CTE computes ranks for each job posting grouped by `salary_hour_avg` rounded to 2 decimal places.
2. **Final Selection**: The main query filters out all but the top-ranked `job_id` for each salary group, ensuring that only unique `salary_hour_avg` values are represented.
3. **Sorting**: The output is presented in descending order of `salary_hour_avg` for easy interpretation.

## Use Cases
- **Data Cleaning**: Deduplicates entries by selecting a single representative record for each unique salary value.
- **Reporting**: Provides a concise summary of unique average salaries along with associated job IDs.
- **Analysis**: Facilitates salary distribution analysis by isolating distinct salary levels.

## Prerequisites
- A dataset named `job_postings_fact` containing at least the following fields:
  - `job_id`: Unique identifier for job postings.
  - `salary_hour_avg`: Average hourly salary for each job posting.

## Notes
- The `ROW_NUMBER()` function ensures consistent and deterministic results when there are ties in `salary_hour_avg` values.
- Excluding `NULL` salary values prevents the inclusion of incomplete data in the analysis.

## Output Example
| job_id | salary_hour_avg |
|--------|-----------------|
| 10234  | 120.50          |
| 11342  | 115.75          |
| 12894  | 110.00          |
