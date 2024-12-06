/*Extract monthly and yearly insights about job postings.
Identify high-paying jobs (average salary > $150,000) where health insurance is provided.
Group data by job attributes and calculate key metrics like average salary.
Provide a detailed view of job postings for further analysis and visualization
*/


SELECT job_posted_date::DATE,
    TO_CHAR (job_posted_date, 'Month')
     AS month_nanme,
    EXTRACT(
        YEAR
        FROM job_posted_date
    ) AS year_num,
    job_id,
    job_title,
    name,
    job_location,
    round(avg(salary_year_avg), 2),
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
HAVING avg(salary_year_avg) > 150000
ORDER BY  salary_year_avg
