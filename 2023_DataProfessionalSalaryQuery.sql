SELECT TOP (1000) [work_year]
      ,[experience_level]
      ,[employment_type]
      ,[job_title]
      ,[salary]
      ,[salary_currency]
      ,[salary_in_usd]
      ,[employee_residence]
      ,[remote_ratio]
      ,[company_location]
      ,[company_size]
  FROM [DataProfessionalSalary].[dbo].[ds_salaries]

--selecting the required columns

Select experience_level, employment_type, job_title, salary_in_usd, employee_residence, company_size
From DataProfessionalSalary.dbo.ds_salaries

--Number of respondent by experience level

Select distinct(experience_level), COUNT(experience_level) as count_of_experience_level
From DataProfessionalSalary.dbo.ds_salaries
Group by experience_level
order by count_of_experience_level desc

--Average Salary By Experience Level

Select distinct(experience_level), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Group by experience_level
--order by count_of_experience_level desc


--Calculating for average salary by job_title

Select distinct(job_title), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Group by job_title
order by average_salary Desc

--Calculating for average salary by job_title for SMALL SIZE companies

Select distinct(experience_level), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Where company_size = 'Small size'
Group by experience_level
order by average_salary Desc

--Calculating for average salary by job_title for Mid Size Companies
Select distinct(experience_level), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Where company_size = 'Mid size'
Group by experience_level
order by average_salary Desc

--Calculating for average salary by job_title for "Large Size" companies
Select distinct(experience_level), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Where company_size = 'Large size'
Group by experience_level
order by average_salary Desc

--calculating for average salary by employment
Select distinct(employment_type), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Group by employment_type
order by average_salary Desc

--Max and Min salalry by different countries for Full time employees
Select company_location, Min(salary_in_usd) as minimum_salary, Max(salary_in_usd) as maximum_salary
From DataProfessionalSalary.dbo.ds_salaries
Where employment_type = 'Full time'
Group by company_location
order by 3 desc


--Max and Min salalry by different countries for Part Time employees
Select company_location, Min(salary_in_usd) as minimum_salary, Max(salary_in_usd) as maximum_salary
From DataProfessionalSalary.dbo.ds_salaries
Where employment_type = 'Part Time'
Group by company_location
order by 3 desc



--CREATING VIEWS FOR VISUALIZATION

create view survey_respondent AS

Select distinct(experience_level), COUNT(experience_level) as count_of_experience_level
From DataProfessionalSalary.dbo.ds_salaries
Group by experience_level
--order by count_of_experience_level desc

create view salary_experience_level AS
Select distinct(experience_level), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Group by experience_level

create view salary_job_title as
Select distinct(job_title), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Group by job_title


--Calculating for average salary by job_title for SMALL SIZE companies
create view SmallSizeCompanies_Average as
Select distinct(experience_level), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Where company_size = 'Small size'
Group by experience_level
--order by average_salary Desc


--Calculating for average salary by job_title for Mid Size Companies
create view MidSizeCompany_Average as
Select distinct(experience_level), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Where company_size = 'Mid size'
Group by experience_level
--order by average_salary Desc

--Calculating for average salary by job_title for "Large Size" companies
create view LargeSizeCompanies_average as
Select distinct(experience_level), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Where company_size = 'Large size'
Group by experience_level


--Max and Min salalry by different countries for Full time employees
create view Country_MinMaxSalary_FulltTime as
Select company_location, Min(salary_in_usd) as minimum_salary, Max(salary_in_usd) as maximum_salary
From DataProfessionalSalary.dbo.ds_salaries
Where employment_type = 'Full time'
Group by company_location


--Max and Min salalry by different countries for Part Time employees
Create view CountryMinMax_salary_PartTime as
Select company_location, Min(salary_in_usd) as minimum_salary, Max(salary_in_usd) as maximum_salary
From DataProfessionalSalary.dbo.ds_salaries
Where employment_type = 'Part Time'
Group by company_location
--order by 3 desc


--calculating for average salary by employment
create view EmploymentType_Average as
Select distinct(employment_type), Avg(salary_in_usd) as average_salary
From DataProfessionalSalary.dbo.ds_salaries
Group by employment_type