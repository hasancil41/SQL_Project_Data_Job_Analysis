WIth january_jobs as (SELECT*
FROM job_postings_fact
WHERE EXTRACT (MONTH FROM job_posted_date)=1 )

SELECT *
FROM january_jobs
