SELECT
COUNT(job_id) AS number_of_job,
       job_location,
       CASE
            WHEN job_location = 'ANYWHERE' THEN 'REMOTE'
            WHEN job_location = 'NEW YORK, NY' THEN 'LOCAL'
            ELSE 'OTHER'
            END AS location_type
           FROM job_postings_fact
GROUP BY job_title_short, job_location, 
         CASE
            WHEN job_location = 'ANYWHERE' THEN 'REMOTE'
            WHEN job_location = 'NEW YORK, NY' THEN 'LOCAL'
            ELSE 'OTHER'
         END;