# Job Titles Cleaning Query

## Overview
This repository contains SQL queries and explanations for cleaning job titles by removing rows containing symbols or special characters. The example uses PostgreSQL, demonstrating how to ensure clean, symbol-free data in a job postings dataset.

## Query Description

### Objective
To retrieve distinct job titles from the `job_postings_fact` table while excluding any titles that contain symbols or special characters. The results are sorted in descending order.

### SQL Query
```sql
SELECT DISTINCT job_title
FROM job_postings_fact
WHERE job_title ~ '^[A-Za-z0-9 /&_-]+$'
ORDER BY job_title DESC;
```

### Breakdown
1. **`SELECT DISTINCT job_title`:**
   Retrieves unique job titles to ensure no duplicates in the result set.

2. **`FROM job_postings_fact`:**
   Specifies the table containing job postings data.

3. **`WHERE job_title ~ '^[A-Za-z0-9 /&_-]+$'`:**
   Filters out job titles containing any characters outside of:
   - Letters (`A-Za-z`)
   - Numbers (`0-9`)
   - Spaces (` `)
   - Common separators (`/`, `&`, `_`, `-`)

4. **`ORDER BY job_title DESC`:**
   Sorts the cleaned job titles in descending order.

### Additional Improvements
- **Exclude `NULL` values:** Add `job_title IS NOT NULL` to avoid null entries.
  ```sql
  WHERE job_title IS NOT NULL AND job_title ~ '^[A-Za-z0-9 /&_-]+$'
  ```

- **Case-insensitive matching:** Use `~*` instead of `~` for case-insensitive filtering.
  ```sql
  WHERE job_title ~* '^[A-Za-z0-9 /&_-]+$'
  ```


## Notes
- Adjust the regular expression pattern to allow or restrict additional characters based on your requirements.
- The query can be adapted for other SQL dialects with minor modifications:
  - For MySQL, replace `~` with `REGEXP`.
  - For SQL Server, use `NOT LIKE` with a pattern to exclude unwanted symbols.


