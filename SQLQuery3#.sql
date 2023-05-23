/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [iso_code]
      ,[continent]
      ,[location]
      ,[date]
      ,[population_density]
      ,[total_cases]
      ,[new_cases]
      ,[new_cases_smoothed]
      ,[total_deaths]
      ,[new_deaths]
      ,[new_deaths_smoothed]
      ,[total_cases_per_million]
      ,[new_cases_per_million]
      ,[new_cases_smoothed_per_million]
      ,[total_deaths_per_million]
      ,[new_deaths_per_million]
      ,[new_deaths_smoothed_per_million]
      ,[reproduction_rate]
      ,[icu_patients]
      ,[icu_patients_per_million]
      ,[hosp_patients]
      ,[hosp_patients_per_million]
      ,[weekly_icu_admissions]
      ,[weekly_icu_admissions_per_million]
      ,[weekly_hosp_admissions]
      ,[weekly_hosp_admissions_per_million]
      ,[total_tests]
  FROM [PortfolioProject].[dbo].[coviddeaths]

  SELECT *
  FROM PortfolioProject.dbo.coviddeaths
  WHERE continent is not null
  ORDER BY 3,4 
  
 SELECT *
 FROM PortfolioProject.dbo.covidvaccinations
 ORDER BY 3,4
  
  
  
  
  SELECT date, location, population total_cases, new_cases, total_deaths
  FROM PortfolioProject.dbo.coviddeaths
  ORDER BY 2,3

ALTER TABLE PortfolioProject.dbo.coviddeaths
ALTER COLUMN total_cases INT


ALTER TABLE PortfolioProject.dbo.coviddeaths
ALTER COLUMN total_deaths INT

--Likelihood of dying if yu contract covid

  SELECT location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentages
  FROM portfolioproject.dbo.coviddeaths
  WHERE location like '%africa%'
  ORDER BY 1,2

  --Total cases Vs Population

  

  --countries with the highest infection rate compare to population

 SELECT location, population, MAX((total_cases)) AS Highestinfectioncount, MAX((total_cases/population))*100 as percentinfectedpopulation
 FROM portfolioproject.dbo.coviddeaths
 -- WHERE location like '%africa%'
 WHERE continent is not null
 GROUP BY location, population
 ORDER BY percentinfectedpopulation desc

  --countries with the highest death count

 SELECT location, MAX(CAST(total_deaths As INT)) AS highestdeathcount
 FROM portfolioproject.dbo.coviddeaths
 -- WHERE location like '%africa%'
 WHERE continent is not null
 GROUP BY location
 ORDER BY highestdeathcount desc

_--calculating by continent

 SELECT continent, MAX(CAST(total_deaths As INT)) AS highestdeathcount
 FROM portfolioproject.dbo.coviddeaths
 -- WHERE location like '%africa%'
 WHERE continent is not null
 GROUP BY continent
 ORDER BY highestdeathcount desc

 --showing the countries with highest death count per location

 SELECT continent, MAX(CAST(total_deaths As INT)) AS highestdeathcount
 FROM portfolioproject.dbo.coviddeaths
 -- WHERE location like '%africa%'
 WHERE continent is not null
 GROUP BY continent
 ORDER BY highestdeathcount desc

 --Global numbers
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as deathpercentage
 FROM portfolioproject.dbo.coviddeaths
 --WHERE location like '%africa%'
 WHERE continent is not null
 --GROUP BY date
 ORDER BY 1,2

 --Looking for population Vs vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
  SUM(cast(vac.new_vaccinations as int)) 
  OVER (partition by dea.location Order by dea.location, dea.date) as rollingpeoplesvaccinated
  --, (rollingpeoplesvaccinated/population)*100
From 
   PortfolioProject.dbo.coviddeaths dea
 join 
   PortfolioProject.dbo.covidvaccinations vac
   on
     dea.location = vac.location
	 and dea.date = vac.date
 

 --USE CTE

 With popvsvac (continent, location, date, population, new_vaccinations, rollingpeoplesvaccinated)
   as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
  SUM(cast(vac.new_vaccinations as int)) 
  OVER (partition by dea.location Order by dea.location, dea.date) as rollingpeoplesvaccinated
  --, (rollingpeoplesvaccinated/population)*100
From 
   PortfolioProject.dbo.coviddeaths dea
 join 
   PortfolioProject.dbo.covidvaccinations vac
   on
     dea.location = vac.location
	 and dea.date = vac.date
Where dea.continent is not null
)
select *, (rollingpeoplesvaccinated/population)*100
from popvsvac



--CREATING VIEWS FOR LATER VISUALIZATION

Create view percentpopulationvaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
  SUM(cast(vac.new_vaccinations as int)) 
  OVER (partition by dea.location Order by dea.location, dea.date) as rollingpeoplesvaccinated
  --, (rollingpeoplesvaccinated/population)*100
From 
   PortfolioProject.dbo.coviddeaths dea
 join 
   PortfolioProject.dbo.covidvaccinations vac
   on
     dea.location = vac.location
	 and dea.date = vac.date
Where dea.continent is not null

select *
from percentpopulationvaccinated



Create view percentinfectedpopulation as
SELECT location, population, MAX((total_cases)) AS Highestinfectioncount, MAX((total_cases/population))*100 as percentinfectedpopulation
 FROM portfolioproject.dbo.coviddeaths
 -- WHERE location like '%africa%'
 WHERE continent is not null
 GROUP BY location, population
 -- BY percentinfectedpopulation desc



create view deathpercentage as
 SELECT location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentages
  FROM portfolioproject.dbo.coviddeaths
  WHERE location like '%africa%'
  --ORDER BY 1,2

  create view highestdeathcount as
 SELECT continent, MAX(CAST(total_deaths As INT)) AS highestdeathcount
 FROM portfolioproject.dbo.coviddeaths
 -- WHERE location like '%africa%'
 WHERE continent is not null
 GROUP BY continent
 --ORDER BY highestdeathcount desc

create view globalcovidpopulation as
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as deathpercentage
 FROM portfolioproject.dbo.coviddeaths
 --WHERE location like '%africa%'
 WHERE continent is not null

