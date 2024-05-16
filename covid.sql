USE covid_data;

SELECT * FROM covid;

FINDING THE TOTAL CASES AND DEATHS BY COUNTRY AND COMPARING THAT TO THE AVERAGE DEATHS BY THE CONTINENT;
SELECT country, 
continent, 
population, 
total_cases, 
total_deaths,
ROUND(AVG(total_deaths) OVER(PARTITION BY continent), 3) AS avg_death_continent
FROM covid
ORDER BY total_cases DESC;

COMPARING COUNTRIES AND CONTINENTS ACTIVE CASES OF COVID;
SELECT 
a.country,
a.active_cases,
a.continent,
b.continent_avg_cases
FROM covid a
JOIN (SELECT continent,
ROUND(AVG(active_cases),2) AS continent_avg_cases
FROM covid 
GROUP BY continent) b
ON a.continent = b.continent
ORDER BY a.total_cases DESC;

WHICH COUNTRY HAS MOST CASES IN EACH CONTINENT;
SELECT COUNTRY, continent, MAX(active_cases) AS most_active_cases
FROM covid
GROUP BY continent
ORDER BY active_cases DESC;

WHICH COUNTRY HAS THE MOST DEATHS IN EACH CONTINENT;
SELECT COUNTRY, continent, MAX(total_deaths) AS most_deaths
FROM covid
GROUP BY continent;

WHICH COUNTRIES ARE TESTING THE MOST TESTED;
SELECT 
country,
continent,
population,
total_tests,
(total_tests / population) * 100 AS percent_tested
FROM covid 
ORDER BY total_tests DESC
LIMIT 10;


SEEING HOW MANY OF TOTAL CASES ARE RECOVERD;
SELECT country, total_cases, (total_recovered / total_cases) * 100 AS percentage_recovered
FROM covid
ORDER BY total_cases DESC;








