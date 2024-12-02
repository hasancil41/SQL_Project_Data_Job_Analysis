/*
 Question: What are the top-paying Senior Data Scientist remote jobs?
 - Identify the top 10 highest-paying Senior Data Scientist roles that are available remotely
 - Focuses on job postings with specified salaries (remove nulls)
 -Also focus job posted date for first QUARTER
 -  Include company names of top 10 roles
 - Why? Highlight the top-paying opportunities for Senior Data Scientist, offering insights into employment options and location flexibility.
 */
SELECT job_posted_date::DATE,
    name as company_name,
    job_id,
    job_title_short,
    job_location,
    salary_year_avg,
    job_work_from_home
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE salary_year_avg is NOT NULL
    AND job_title_short = 'Senior Data Scientist'
    AND job_work_from_home IS TRUE
    AND job_location = 'Anywhere'
    AND EXTRACT(
        QUARTER
        FROM job_posted_date
    ) = 1
ORDER BY salary_year_avg DESC
LIMIT 10