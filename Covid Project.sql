

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
order by 1,2


--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract Covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE location LIKE '%Africa%'
ORDER BY 1,2


--Looking at Total Cases vs Population
--Shows what percentage of population got Covid

SELECT location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
FROM coviddeaths
WHERE location LIKE '%Africa%'
ORDER BY 1,2


--Looking at countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) as HighestInfectionCount,  MAX(total_cases/population)*100 as PercentPopulationInfected
FROM coviddeaths
WHERE location LIKE '%Africa%'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC


--Showing countries with the Highest Death Per Population

SELECT location, MAX(total_deaths) as TotalDeathCount
FROM coviddeaths
WHERE location LIKE '%Africa%'
GROUP BY location
ORDER BY TotalDeathCount DESC


--Looking at Total Population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, dea.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)
AS RollingPeopleVaccinated
FROM covidvaccinations vac
JOIN coviddeaths dea
ON dea.location = vac.location
and dea.date = vac.date
WHERE 'dea.continents' is not null
ORDER BY 2,3


--Queries for Tableau Project
--1

SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
FROM coviddeaths
--Where location like '%states%'
WHERE continent is not null 
--Group By date
ORDER BY 1,2

-- 2. 


SELECT location, SUM(new_deaths) as TotalDeathCount
FROM coviddeaths
--Where location like '%states%'
WHERE continent is null 
AND location not in ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount desc


-- 3.

SELECT location, population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
FROM covidDeaths
--Where location like '%states%'
GROUP BY Location, Population
ORDER BY PercentPopulationInfected desc


----

