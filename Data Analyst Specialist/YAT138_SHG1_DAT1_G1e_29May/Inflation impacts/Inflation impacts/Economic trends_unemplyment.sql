use EconomicTrendsDB ;

select*from global_unemployment_data ;

-- Create a table with the same attributes and data as the table in the CSV file.

create table world_unemployment
like `global_unemployment_data`;

insert  world_unemployment
select distinct*
from `global_unemployment_data`;

-- Start cleaning the data and removing unwanted data, such as columns from 1980 to 2013.

DELETE FROM  world_unemployment
	where Country_name = 'country_name';

-- Search for empty values.

SELECT *
FROM world_inflation
WHERE country_name IS NULL;

-- Search for the most frequent values.

SELECT country_name,count(*) AS count
FROM world_unemployment
group by country_name
having count >6 ;

-- Search for out-of-range or anomalous values in the table.

SELECT *
FROM world_unemployment
WHERE `2019` > (SELECT AVG(`2019`) + 3 * STDDEV(`2019`) FROM world_unemployment)
OR `2019` < (SELECT AVG(`2019`) - 3 * STDDEV(`2019`) FROM world_unemployment);

-- Add a new column to store the average data over the ten years.

alter table world_unemployment
add column  avg_unemployment float ;

UPDATE world_unemployment
SET avg_unemployment = (
  (`2014` + `2015` +`2016` + `2017` +`2018` + `2019` + `2020` + `2021` + `2022` + `2023` + `2024`) / 11
);                    
	
 -- Calculate the global unemployment rate.
  
SELECT 
    AVG(avg_unemployment) AS world_avg_unemployment_rate
FROM world_unemployment ;
              
-- Calculate the global unemployment rate by each type (gender, age group, etc.).

 SELECT 
age_categories,
    AVG(avg_unemployment) AS world_avg_unemployment_rate
FROM world_unemployment
group by age_categories;         

-- Calculate the unemployment rate for each type (gender, age group, etc.) for each year over the past ten years.

select
    age_categories, 
    AVG(`2014`) AS avg_2014, 
    AVG(`2015`) AS avg_2015,
    AVG(`2016`) AS avg_2016,
    AVG(`2017`) AS avg_2017,
    AVG(`2018`) AS avg_2018,
    AVG(`2019`) AS avg_2019,
    AVG(`2020`) AS avg_2020,
    AVG(`2021`) AS avg_2021,
    AVG(`2022`) AS avg_2022,
    AVG(`2023`) AS avg_2023,
	AVG(`2024`) AS avg_2024
FROM world_unemployment
GROUP BY age_categories ;  
  
  -- Compare unemployment rates between males and females.

SELECT 
    sex, 
    age_categories, 
    AVG(`2014`) AS avg_2014, 
    AVG(`2015`) AS avg_2015,
    AVG(`2016`) AS avg_2016,
    AVG(`2017`) AS avg_2017,
    AVG(`2018`) AS avg_2018,
    AVG(`2019`) AS avg_2019,
    AVG(`2020`) AS avg_2020,
    AVG(`2021`) AS avg_2021,
    AVG(`2022`) AS avg_2022,
    AVG(`2023`) AS avg_2023
FROM world_unemployment
GROUP BY sex, age_categories;

-- Identify the ten countries with the lowest unemployment rates globally.

  SELECT country_name, 
       min(avg_unemployment) AS average_unemployment
FROM world_unemployment
GROUP BY country_name 
ORDER BY average_unemployment ASC 
LIMIT 10; 

-- Identify the ten countries with the highest unemployment rates globally.

SELECT country_name, 
      max(avg_unemployment) AS average_unemployment
FROM world_unemployment
GROUP BY country_name 
ORDER BY average_unemployment desc
LIMIT 10; 
   
   
   -- Determine the unemployment rate between males and females globally by age group.

   SELECT 
    age_group,
    AVG(unemployment_rate) AS avg_unemployment
FROM 
  new_world_unemployment
GROUP BY 
    age_group;

   
   -- Calculate the unemployment rate in Egypt by each type (gender, age group, etc.).

select
sex,age_categories,avg_unemployment
from world_unemployment
where country_name='Egypt' ;

select*from world_unemployment;




