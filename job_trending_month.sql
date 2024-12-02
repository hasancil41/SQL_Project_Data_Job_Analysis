/* -track month to month trends in job posting,
 Focusing Data Analayst and New Yok area on-site job
 -also focusing average anual salary
 -Order by date desc
 */
SELECT count(job_id) as job_posted,
    TO_CHAR(job_posted_date, 'Month') AS month_name,
    EXTRACT(
        YEAR
        FROM job_posted_date
    ) AS year_num,
    ROUND(avg(salary_year_avg), 2) as avg_salary
FROM job_postings_fact
WHERE job_title = 'Data Analyst'
    AND job_location = 'New York, NY'
    AND salary_year_avg is NOT NULL
GROUP BY EXTRACT(
        MONTH
        FROM job_posted_date
    ),
    TO_CHAR(job_posted_date, 'Month'),
    EXTRACT(
        YEAR
        FROM job_posted_date
    )
ORDER BY job_posted DESC