/*Вывести профессии клиентов: из сферы IT, чья профессия начинается с Senior;
из сферы Financial Services, чья профессия начинается с Lead.
Для обеих групп учитывать только клиентов старше 35 лет.
Объединить выборки с помощью UNION ALL.*/

SELECT
	c1.job_title
FROM
	customer c1
WHERE
	c1.job_title ILIKE 'Senior%'
	AND c1.job_industry_category = 'IT'
	AND EXTRACT(YEAR FROM AGE(now(), c1.dob)) > 35
	
UNION ALL 

SELECT
	c2.job_title
FROM
	customer c2
WHERE
	c2.job_title ILIKE 'Lead%'
	AND c2.job_industry_category = 'Financial Services'
	AND EXTRACT(YEAR FROM AGE(now(), c2.dob)) > 35;
