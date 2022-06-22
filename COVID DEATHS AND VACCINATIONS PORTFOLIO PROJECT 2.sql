select *
from [PORTFOLIO PROJECT] .. ['COVID DEATHS$']
where continent is not null
order by 3,4

--select *
--from [PORTFOLIO PROJECT] .. ['COVID VACCINATIONS$']
--order by 3,4

-- Select data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from [PORTFOLIO PROJECT] .. ['COVID DEATHS$']
order by 1,2


-- Looking at the Total Cases vs. Total Deaths
-- Shows the likelyhood of dying if you Contract COVID in Canada

select location, date, total_cases, total_deaths, (Total_deaths/total_cases)*100 as DeathPercentage
from [PORTFOLIO PROJECT] .. ['COVID DEATHS$']
WHERE location like '%canada%'
order by 1,2


-- Looking at total cases vs. the population
-- Shows what percentage of popluation got contracted COVID


select location, date, total_cases, population, (total_cases/population)*100 as PercentofPopulationInfected
from [PORTFOLIO PROJECT] .. ['COVID DEATHS$']
WHERE location like '%canada%'
order by 1,2

-- Looking at countries with highest infection rate compared to population

select location, Population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 as PercentofPopulationInfected
from [PORTFOLIO PROJECT] .. ['COVID DEATHS$']
-- Where location like '%canada%'
group by Location, population
order by PercentofPopulationInfected DESC

-- Showing countries with the Highest Death Count per Population

select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [PORTFOLIO PROJECT] .. ['COVID DEATHS$']
-- Where location like '%canada%'
where continent is not null
group by Location
order by TotalDeathCount DESC



-- BREAKING THINGS DOWN BY CONTINENT

-- Showing continents with the highest death count per population


select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [PORTFOLIO PROJECT] .. ['COVID DEATHS$']
-- Where location like '%canada%'
where continent is not null
group by continent
order by TotalDeathCount DESC


-- Global Numbers

select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [PORTFOLIO PROJECT] .. ['COVID DEATHS$']
-- Where location like '%canada%'
WHERE continent is not null
group by date
order by 1,2


-- Looking at Total Population vs. Vaccinations


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [PORTFOLIO PROJECT]..['COVID DEATHS$'] dea
join  [PORTFOLIO PROJECT] ..['COVID VACCINATIONS$'] vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3
