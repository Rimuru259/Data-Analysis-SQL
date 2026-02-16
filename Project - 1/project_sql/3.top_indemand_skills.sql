/*
Question: What are the most in-demand skills for data analysts ?
- List of the skills that are most frequently mentioned in job postings for data analysts
-provide insights into the specific skills that employers are looking for when hiring data analysts
*/


SELECT 
        skills,
    COUNT(skills_job_dim.skill_id) AS demand_count
FROM  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
       job_title_short = 'Data Analyst'
       AND job_work_from_home = true 
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10;


Project - 1/project_sql/market_demand_data_skills.png
