-- COVID 19 Data Exploration with SQL
-- Dataset Source: https://ourworldindata.org/covid-deaths

select *
from dbo.CovidDeaths
order by 3,4

-- Select the needed columns

select location, date, total_cases, new_cases, total_deaths, population
from sqlportfolio..coviddeaths
order by 1,2

-- Percentage of total deaths per total cases

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from sqlportfolio..coviddeaths
where lower(location) like '%thailand%' --in case you want to look up the percentage in your country
order by 1,2

-- Percentage of total cases per population

select location, date, population, total_cases, (total_cases/population)*100 as InfectionPercentage
from sqlportfolio..coviddeaths
where continent is not null
order by 1,2

-- Countries with highest infection rate compared to population

select location, population, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as InfectionPercentage
from sqlportfolio..coviddeaths
where continent is not null
group by location, population
order by InfectionPercentage desc

-- Countries with highest death count per population

select location, population, max(total_deaths) as HighestDeathCount, max(total_deaths/population)*100 as DeathPercentage
from sqlportfolio..coviddeaths
where continent is not null
group by location, population
order by DeathPercentage desc

-- Continents with highest death counts

select continent, max(total_deaths) as TotalDeathCount
from sqlportfolio..coviddeaths
where continent is not null
group by continent
order by TotalDeathCount desc

-- Population vs Vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from sqlportfolio..coviddeaths dea
join sqlportfolio..covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

-- Use CTE to create a column of vaccination percentage
with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from sqlportfolio..coviddeaths dea
join sqlportfolio..covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select *, (RollingPeopleVaccinated*1.0/population)*100 as VaccinationPercentage
from PopvsVac

-- Use TEMP TABLE to create a column of vaccination percentage

drop table if exists PercentPopulationVaccinated -- in case you want to make changes to the table
create table PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from sqlportfolio..coviddeaths dea
join sqlportfolio..covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

select *, (RollingPeopleVaccinated*1.0/population)*100 as VaccinationPercentage
from PercentPopulationVaccinated

-- Create view for later visualisations
drop view if exists PercentagePopulationVaccinated
use SQLportfolio
create view PercentagePopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from sqlportfolio..coviddeaths dea
join sqlportfolio..covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

select *
from PercentagePopulationVaccinated
