use EconomicTrendsDB;

select*from book1 ;
-- Create a table with the same attributes and data as the table in the CSV file.
create table economic_trends 
like `book1` ;

insert economic_trends
select distinct*
from `book1` ;

select* from economic_trends ;

-- Transform columns into rows in the unemployment table.

CREATE TABLE new_world_unemployment AS
SELECT country_name, '2014' AS year, `2014` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2015' AS year, `2015` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2016' AS year, `2016` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2017' AS year, `2017` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2018' AS year, `2018` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2019' AS year, `2019` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2020' AS year, `2020` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2021' AS year, `2021` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2022' AS year, `2022` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2023' AS year, `2023` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment
UNION ALL
SELECT country_name, '2024' AS year, `2024` AS unemployment_rate, sex, age_group, age_categories
FROM world_unemployment;


-- Transform columns into rows in the table of average domestic production rate.


CREATE TABLE new_world_GDP AS
SELECT country_name, '2014' AS year, `2014` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2015' AS year, `2015` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2016' AS year, `2016` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2017' AS year, `2017` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2018' AS year, `2018` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2019' AS year, `2019` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2020' AS year, `2020` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2021' AS year, `2021` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2022' AS year, `2022` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2023' AS year, `2023` AS gdp_growth
FROM world_GDP
UNION ALL
SELECT country_name, '2024' AS year, `2024` AS gdp_growth
FROM world_GDP;


----- Transform columns into rows in the inflation table.


CREATE TABLE new_world_inflation AS
SELECT country_name, '2014' AS year, `2014` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2015' AS year, `2015` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2016' AS year, `2016` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2017' AS year, `2017` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2018' AS year, `2018` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2019' AS year, `2019` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2020' AS year, `2020` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2021' AS year, `2021` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2022' AS year, `2022` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2023' AS year, `2023` AS inflation_rate
FROM world_inflation
UNION ALL
SELECT country_name, '2024' AS year, `2024` AS inflation_rate
FROM world_inflation;


-- Add a new column to the three tables to use for linking between the tables.


ALTER TABLE new_world_GDP ADD COLUMN country_year_id VARCHAR(255);

ALTER TABLE new_world_inflation ADD COLUMN country_year_id VARCHAR(255);

ALTER TABLE new_world_unemployment ADD COLUMN country_year_id VARCHAR(255);

-- Insert data into the new columns from the original table.

UPDATE new_world_GDP g
JOIN economic_trends m ON g.country_name = m.CountryName AND g.year = m.Year
SET g.country_year_id = m.country_year_id;


UPDATE new_world_inflation i
JOIN economic_trends m ON i.country_name = m.CountryName AND i.year = m.Year
SET i.country_year_id = m.country_year_id;


UPDATE new_world_unemployment u
JOIN economic_trends m ON u.country_name = m.CountryName AND u.year = m.Year
SET u.country_year_id = m.country_year_id;

select *from economic_trends ;

-- Split the data into the new column in the unemployment table and distribute it over the years due to the failure of inserting it all at once.


UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2014;

UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2015;

UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2016;


UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2017;


UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2018;


UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2019;


UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2020;


UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2021;

UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2022;

UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2023;


UPDATE new_world_unemployment u
JOIN economic_trends m 
  ON u.country_name = m.CountryName 
  AND u.year = m.Year
SET u.country_year_id = m.country_year_id
WHERE u.year = 2024;

-- Add new constraints to a column in the linking table.

alter table economic_trends
rename column ï»؟CountryYearID to country_year_id ;

-- Add new constraints to the three recently added columns in the tables and make them primary keys.

ALTER TABLE new_world_unemployment ADD PRIMARY KEY (unemployment_rate);
ALTER TABLE new_world_inflation ADD PRIMARY KEY (country_year_id);
ALTER TABLE new_world_GDP ADD PRIMARY KEY (country_year_id);

-- Organize and clean the data to facilitate the linking process between the four tables.


SELECT * 
FROM new_world_unemployment
WHERE country_year_id IS NULL OR country_year_id = '';


SELECT country_year_id, COUNT(*)
FROM new_world_unemployment
GROUP BY country_year_id
HAVING COUNT(*) > 6;


-- Link the four tables using primary keys.


ALTER TABLE economic_trends ADD PRIMARY KEY (country_year_id);

ALTER TABLE new_world_GDP ADD CONSTRAINT fk_gdp_country_year FOREIGN KEY (country_year_id) REFERENCES economic_trends(country_year_id);

ALTER TABLE new_world_inflation ADD CONSTRAINT fk_inflation_country_year FOREIGN KEY (country_year_id) REFERENCES economic_trends(country_year_id);

ALTER TABLE new_world_unemployment ADD CONSTRAINT fk_unemployment_country_year FOREIGN KEY (country_year_id) REFERENCES economic_trends(country_year_id);



ALTER TABLE economic_trends
MODIFY COLUMN year VARCHAR(4);


