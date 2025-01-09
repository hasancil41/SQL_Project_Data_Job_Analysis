# Remote Job Skills Analysis

## Overview
This SQL query analyzes the demand for skills in remote job postings specifically for the role of **Data Analyst**. It identifies the top 5 skills based on their demand, along with relevant salary information for each skill.

## Query Functionality
The query performs the following operations:

1. **Filter Remote Jobs**: Focuses on job postings where the position is remote (`job_work_from_home = TRUE`) and the job title is "Data Analyst".
2. **Skill Count**: Counts the number of job postings requiring each skill.
3. **Salary Insights**: Calculates the yearly minimum and maximum salary for each skill based on job postings.
4. **Top Skills**: Retrieves the top 5 skills by demand (number of postings).
5. **Skill Details**: Includes the skill ID, skill name, count of postings, and salary information.

## Query Structure
### Common Table Expression (CTE): `remote_job_skill`
- Aggregates the number of postings (`skill_count`) for each skill ID.
- Computes the minimum (`min_salary`) and maximum (`max_salary`) annual salary for postings requiring the skill.

### Final Query
- Joins the `remote_job_skill` CTE with the `skills_dim` table to include skill names.
- Orders results by skill demand in descending order.
- Limits the output to the top 5 skills.

## SQL Query
```sql
WITH remote_job_skill AS (
    SELECT 
        skill_job.skill_id,
        COUNT(*) AS skill_count,
        MIN(job_posting.salary_year_avg) AS min_salary,
        MAX(job_posting.salary_year_avg) AS max_salary
    FROM skills_job_dim AS skill_job
    INNER JOIN job_postings_fact AS job_posting 
        ON job_posting.job_id = skill_job.job_id
    WHERE job_posting.job_work_from_home = TRUE and job_posting.job_title_short='Data Analyst' 
        
    GROUP BY skill_job.skill_id
)
SELECT 
    skill.skill_id,
    skill.skills AS skill_name,
    remote_job_skill.skill_count,
    remote_job_skill.min_salary,
    remote_job_skill.max_salary
FROM remote_job_skill
INNER JOIN skills_dim AS skill 
    ON skill.skill_id = remote_job_skill.skill_id
ORDER BY remote_job_skill.skill_count DESC
LIMIT 5;
```

## Output Columns
- **skill_id**: Unique identifier for the skill.
- **skill_name**: Name of the skill.
- **skill_count**: Number of postings requiring the skill.
- **min_salary**: Minimum annual salary for postings requiring the skill.
- **max_salary**: Maximum annual salary for postings requiring the skill.

## Example Output
| skill_id | skill_name       | skill_count | min_salary | max_salary |
|----------|------------------|-------------|------------|------------|
| 101      | SQL              | 500         | 50000      | 120000     |
| 102      | Python           | 450         | 55000      | 115000     |
| 103      | Data Visualization | 400         | 52000      | 110000     |
| 104      | Machine Learning | 350         | 60000      | 130000     |
| 105      | Statistics       | 300         | 58000      | 125000     |

## How to Run
1. Ensure the following tables exist in your database:
   - **`skills_job_dim`**: Contains mappings between job postings and skills.
   - **`job_postings_fact`**: Contains job posting details, including salary and work location.
   - **`skills_dim`**: Contains skill details (ID and name).
2. The result will display the top 5 skills for Data Analyst remote jobs, along with demand and salary details.

