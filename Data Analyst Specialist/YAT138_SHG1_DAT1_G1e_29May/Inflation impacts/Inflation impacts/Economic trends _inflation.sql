use EconomicTrendsDB ;

-- Load the CSV file and write its contents.

select*from`global_inflation_data (1)` ;

-- Create a table with the same attributes and data as the table in the CSV file.

create table world_inflation
like `global_inflation_data (1)`;

insert  world_inflation
select distinct*
from `global_inflation_data (1)`;

select*from world_inflation ;

-- Start cleaning the data and removing unwanted data, such as columns from 1980 to 2013.

alter table world_inflation
DROP COLUMN `1981`,drop column`1982`,drop column `1983`,drop column `1984`,drop column `1985`,drop column `1986`,drop column `1987`,drop column `1988`,drop column`1989`,drop column `1990`,drop column `1991`,
drop column`1992`,drop column `1993`,drop column`1994`,drop column`1995`,drop column`1996`,drop column`1997`,drop column `1998`,drop column`1999`,drop column`2000`,
drop column `2001`,drop column `2002`,drop column `2003`,drop column `2004`,drop column `2005`,drop column `2006`,drop column `2007`, 
drop column `2008`,drop column `2009`,drop column `2010`, drop column `2011`,drop column `2012`,drop column `2013`;

alter table world_inflation
drop column `1980`;


alter table world_inflation
rename column `ï»؟country_name` to  country_name ;

DELETE FROM  world_inflation
	where Country_name = 'ï»؟country_name';
    
  -- Search for empty values.

    SELECT *
FROM world_inflation
WHERE country_name IS NULL;


SELECT country_name,count(*) AS count
FROM world_inflation
group by country_name
having count >1 ;

-- Search for out-of-range or anomalous values in the table.

SELECT *
FROM world_inflation
WHERE `2019` > (SELECT AVG(`2019`) + 3 * STDDEV(`2019`) FROM world_inflation)
OR `2019` < (SELECT AVG(`2019`) - 3 * STDDEV(`2019`) FROM world_inflation);

-- Update some country names.

UPDATE world_inflation
SET country_name = 'Turkiye' 
WHERE country_name ='Tأ¼rkiye, Republic of' ;


INSERT INTO world_inflation (country_name,indicator_name, `2014`, `2015`, `2016`, `2017`, `2018`, `2019`, `2020`, `2021`, `2022`, `2023`, `2024`)
VALUES ('China','Annual average inflation (consumer prices) rate', 2.1, 1.5, 2.1, 1.5, 1.9, 2.9, 2.5, 0.9, 1.9, 0.7, 1.7);

-- Add a new column to store the average data over the ten years.

alter table world_inflation
add column  avg_inflation float ;

UPDATE world_inflation
SET avg_inflation = (
  (`2014` + `2015` +`2016` + `2017` +`2018` + `2019` + `2020` + `2021` + `2022` + `2023` + `2024`) / 11
);

-- The average inflation rate of global production over the past decade.

select avg(avg_inflation)as avgerage_world_inflation_ from world_inflation;

-- Calculate the global inflation rate, excluding Venezuela.

SELECT 
    AVG(avg_inflation) AS global_avg_inflation
FROM world_inflation
WHERE country_name != 'Venezuela';

-- Calculate the inflation rate over the past ten years excluding Venezuela.
SELECT 
    AVG(`2014`) AS avg_inflation_2014,
    AVG(`2015`) AS avg_inflation_2015,
    AVG(`2016`) AS avg_inflation_2016,
    AVG(`2017`) AS avg_inflation_2017,
    AVG(`2018`) AS avg_inflation_2018,
    AVG(`2019`) AS avg_inflation_2019,
    AVG(`2020`) AS avg_inflation_2020,
    AVG(`2021`) AS avg_inflation_2021,
    AVG(`2022`) AS avg_inflation_2022,
    AVG(`2023`) AS avg_inflation_2023
FROM world_inflation
WHERE country_name != 'Venezuela'; 

-- Calculate the average inflation rate for each year over the past ten years.

SELECT 
    AVG(`2014`) AS avg_inflation_2014,
    AVG(`2015`) AS avg_inflation_2015,
    AVG(`2016`) AS avg_inflation_2016,
    AVG(`2017`) AS avg_inflation_2017,
    AVG(`2018`) AS avg_inflation_2018,
    AVG(`2019`) AS avg_inflation_2019,
    AVG(`2020`) AS avg_inflation_2020,
    AVG(`2021`) AS avg_inflation_2021,
    AVG(`2022`) AS avg_inflation_2022,
    AVG(`2023`) AS avg_inflation_2023
FROM world_inflation ;

-- Identify the ten countries with the lowest average inflation growth.

SELECT country_name, 
       min(avg_inflation) AS average_inflation
FROM world_inflation
GROUP BY country_name 
ORDER BY average_inflation ASC 
LIMIT 10; 

-- Identify the ten countries with the highest average inflation over the past ten years.

SELECT country_name, 
      max(avg_inflation) AS average_inflation
FROM world_inflation
GROUP BY country_name 
ORDER BY average_inflation desc
LIMIT 10; 

-- Calculate the average inflation in Egypt over the past ten years.

SELECT country_name, avg_inflation
FROM world_inflation 
WHERE country_name = 'Egypt';

-- Compare the largest economies in the Middle East during periods of crises and wars over the years.

select country_name,
       `2019` AS infalation_2019,
       `2020` AS inflation_2020,
       `2021` AS inflation_2021,
       `2022` AS inflation_2022,
       `2023` AS inflation_2023,
       (`2019` + `2020` + `2021` +`2022` + `2023`) / 5 AS average_inflation
FROM world_inflation
WHERE country_name IN ('Egypt', 'Turkiye');


-- Compare the average inflation rate in Egypt over the past ten years with the global average rate.


SELECT 
    'Egypt' AS country,
    `2014` AS inflation_rate_2014,
    `2015` AS inflation_rate_2015,
    `2016` AS inflation_rate_2016,
    `2017` AS inflation_rate_2017,
    `2018` AS inflation_rate_2018,
    `2019` AS inflation_rate_2019,
    `2020` AS inflation_rate_2020,
    `2021` AS inflation_rate_2021,
    `2022` AS inflation_rate_2022,
    `2023` AS inflation_rate_2023
FROM world_inflation
WHERE country_name = 'Egypt'

UNION ALL

SELECT 
    'Global Average' AS country,
    AVG(`2014`) AS inflation_rate_2014,
    AVG(`2015`) AS inflation_rate_2015,
    AVG(`2016`) AS inflation_rate_2016,
    AVG(`2017`) AS inflation_rate_2017,
    AVG(`2018`) AS inflation_rate_2018,
    AVG(`2019`) AS inflation_rate_2019,
    AVG(`2020`) AS inflation_rate_2020,
    AVG(`2021`) AS inflation_rate_2021,
    AVG(`2022`) AS inflation_rate_2022,
    AVG(`2023`) AS inflation_rate_2023
FROM world_inflation
WHERE country_name != 'Venezuela';  

select* from world_inflation;


-- Compare the strongest global economies with the strongest regional economies and how each has been affected by global wars and crises.

SELECT 
    country_name,
    AVG(`2019`) AS average_inflation_2019,
    AVG(`2020`) AS average_inflation_2020,
    AVG(`2021`) AS average_inflation_2021,
    AVG(`2022`) AS average_inflation_2022,
    AVG(`2023`) AS average_inflation_2023,
    ( AVG(`2019`) + AVG(`2020`) + AVG(`2021`) + AVG(`2022`) + AVG(`2023`)) / 5 AS overall_average_inflation
FROM world_inflation
WHERE country_name IN ('United States', 'China',  'Egypt',  'Turkiye')
GROUP BY country_name;


