
-- First, create a database to start working and begin the analysis.

create database EconomicTrendsDB ;

use EconomicTrendsDB ;

-- Load the CSV file and write its contents

select* from `world_gdp_data`;

-- Create a table with the same attributes and data as the table in the CSV file.


create table world_GDP
like `world_gdp_data`;

insert  world_gdp
select distinct*
from world_gdp_data ;

select* from world_GDP;

-- Start cleaning the data and removing unwanted data, such as columns from 1980 to 2013.


alter table world_GDP
DROP COLUMN `1981`,drop column`1982`,drop column `1983`,drop column `1984`,drop column `1985`,drop column `1986`,drop column `1987`,drop column `1988`,drop column`1989`,drop column `1990`,drop column `1991`,
drop column`1992`,drop column `1993`,drop column`1994`,drop column`1995`,drop column`1996`,drop column`1997`,drop column `1998`,drop column`1999`,drop column`2000`,
drop column `2001`,drop column `2002`,drop column `2003`,drop column `2004`,drop column `2005`,drop column `2006`,drop column `2007`, 
drop column `2008`,drop column `2009`,drop column `2010`, drop column `2011`,drop column `2012`,drop column `2013`,drop column`1980`;

-- Update some country names.

UPDATE world_GDP
SET country_name = 'Turkiye' 
WHERE country_name ='Türkiye, Republic of' ;

UPDATE world_GDP
SET country_name = 'China' 
WHERE country_name ='China, People''s Republic of' ;

-- Search for empty values.

SELECT *
FROM world_GDP
WHERE country_name IS NULL;

-- Search for out-of-range or anomalous values in the table.

SELECT *
FROM world_GDP
WHERE `2019` > (SELECT AVG(`2019`) + 3 * STDDEV(`2019`  ) FROM world_GDP)
OR `2019` < (SELECT AVG(`2019`) - 3 * STDDEV(`2019` ) FROM world_GDP) ;

-- Add a new column to store the average data over the ten years.


alter table world_GDP
add column  avg_growth float  ;

UPDATE world_GDP
SET avg_growth = (
  (`2014` + `2015` +`2016` + `2017` +`2018` + `2019` + `2020` + `2021` + `2022` + `2023` + `2024`) / 11
);

select* from world_GDP ;

-- The average growth rate of global production over the past decade.

select avg(avg_growth)as avgerage_world_growth_ from world_GDP ;

-- Calculate the average global production for each year over the past ten years.

SELECT 
    'Global Average' AS source,
    AVG(`2014`) AS avg_growth_2014,
    AVG(`2015`) AS avg_growth_2015,
    AVG(`2016`) AS avg_growth_2016,
    AVG(`2017`) AS avg_growth_2017,
    AVG(`2018`) AS avg_growth_2018,
    AVG(`2019`) AS avg_growth_2019,
    AVG(`2020`) AS avg_growth_2020,
    AVG(`2021`) AS avg_growth_2021,
    AVG(`2022`) AS avg_growth_2022,
    AVG(`2023`) AS avg_growth_2023
FROM world_GDP;

-- Identify the ten countries with the lowest average production growth.

SELECT country_name, 
       min(avg_growth) AS average_growth
FROM world_GDP
GROUP BY country_name 
ORDER BY average_growth ASC 
LIMIT 10; 

-- Identify the ten countries with the highest average production over the past ten years.


SELECT country_name, 
      max(avg_growth) AS average_growth
FROM world_GDP 
GROUP BY country_name 
ORDER BY average_growth desc
LIMIT 10; 

-- Calculate the average domestic production in Egypt over the past ten years.


SELECT country_name, avg_growth 
FROM world_GDP
WHERE country_name = 'Egypt';


-- Compare the average domestic production rate in Egypt over the past ten years with the global average rate.

SELECT 
    'Global Average' AS source,
    AVG(`2014`) AS avg_growth_2014,
    AVG(`2015`) AS avg_growth_2015,
    AVG(`2016`) AS avg_growth_2016,
    AVG(`2017`) AS avg_growth_2017,
    AVG(`2018`) AS avg_growth_2018,
    AVG(`2019`) AS avg_growth_2019,
    AVG(`2020`) AS avg_growth_2020,
    AVG(`2021`) AS avg_growth_2021,
    AVG(`2022`) AS avg_growth_2022,
    AVG(`2023`) AS avg_growth_2023
FROM world_GDP
UNION ALL
SELECT 
    'Egypt' AS source,
    `2014`, `2019`,
	`2015`, `2020`, 
    `2016`, `2021`, 
    `2017`, `2022`,
    `2018`, `2023`
  
FROM world_GDP
WHERE country_name = 'Egypt';

-- Compare the largest economies in the Middle East during periods of crises and wars over the years.

select country_name,
       `2019` AS growth_2019,
       `2020` AS growth_2020,
       `2021` AS growth_2021,
       `2022` AS growth_2022,
       `2023` AS growth_2023,
       (`2019` + `2020` + `2021` +`2022` + `2023`) / 5 AS average_growth
FROM world_GDP
WHERE country_name IN ('Egypt', 'Turkiye', 'Saudi Arabia');

-- Calculate the average global rates during the recent crises and wars the world has experienced.

SELECT 
    AVG(`2019`) AS average_growth_2019,
    AVG(`2020`) AS average_growth_2020,
    AVG(`2021`) AS average_growth_2021,
    AVG(`2022`) AS average_growth_2022,
    AVG(`2023`) AS average_growth_2023,
    (AVG(`2019`) + AVG(`2020`) + AVG(`2021`) + AVG(`2022`) + AVG(`2023`)) / 5 AS overall_average_growth
FROM world_gdp;

-- Compare the strongest global economies with the strongest regional economies and how each has been affected by global wars and crises.


SELECT 
    country_name,
    AVG(`2019`) AS average_growth_2019,
    AVG(`2020`) AS average_growth_2020,
    AVG(`2021`) AS average_growth_2021,
    AVG(`2022`) AS average_growth_2022,
    AVG(`2023`) AS average_growth_2023,
    ( AVG(`2019`) + AVG(`2020`) + AVG(`2021`) + AVG(`2022`) + AVG(`2023`)) / 5 AS overall_average_growth
FROM world_gdp
WHERE country_name IN ('United States', 'China', 'Japan', 'Egypt', 'Saudi Arabia', 'Turkiye')
GROUP BY country_name;