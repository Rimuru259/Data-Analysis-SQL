/*
What are the most optimal skills to learn(i.e. the most in demand and highest paying skills)
-Identify the most in demand skills for high average salary data analyst positions
-Concentrates on remote roles with specified salary
-Offers insights into the skills that are currently sought after in the job market for data analysts
*/


WITH skill_demand AS (
    SELECT 
        skills_dim.skill_id, -- Changed to match skills_dim table
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count -- Count job_id for clarity
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = true 
    GROUP BY 
        skills_dim.skill_id, 
        skills -- Added skills here
),
average_salary AS ( -- Removed the 'WITH' keyword
    SELECT 
        skills_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg)) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id,
        skills -- Removed trailing comma and added skills
)

SELECT
    skill_demand.skill_id,
    skill_demand.skills,
    demand_count,
    avg_salary
FROM
    skill_demand
INNER JOIN average_salary ON skill_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC 
   
LIMIT 50;    