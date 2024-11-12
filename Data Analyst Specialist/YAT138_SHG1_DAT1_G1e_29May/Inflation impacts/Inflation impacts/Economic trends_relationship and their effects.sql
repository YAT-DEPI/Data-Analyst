use EconomicTrendsDB ;

select*from new_world_gdp ;

select*from new_world_inflation;

select*from new_world_unemployment;


-- Analyze the relationship between changes in inflation, unemployment, and the average production rate.

SELECT 
g.country_name,
    AVG(i.inflation_rate) AS avg_inflation,
    AVG(g.gdp_growth) AS avg_growth,
    AVG(u.unemployment_rate) AS avg_unemployment
FROM 
   new_world_gdp g
JOIN 
    new_world_inflation i ON g.country_name = i.country_name
JOIN 
  new_world_unemployment u ON g.country_name = u.country_name
GROUP BY 
    g.country_name;
    
    
-- Analyze the impact of high inflation rates exceeding 10% on unemployment and production rates.


SELECT 
    g.country_name,
    AVG(i.inflation_rate) AS avg_inflation,
    AVG(g.gdp_growth) AS avg_growth,
    AVG(u.unemployment_rate) AS avg_unemployment
FROM 
   new_world_gdp g
JOIN 
    new_world_inflation i ON g.country_name = i.country_name
JOIN 
    new_world_unemployment u ON g.country_name = u.country_name
GROUP BY 
    g.country_name
HAVING 
    avg_inflation > 10; 

-- Analyze the relationship between inflation, unemployment, and production rates globally, and the impact of each on the others.

    SELECT 
    g.country_name,
    AVG(g.gdp_growth) AS avg_growth,
    AVG(i.inflation_rate) AS avg_inflation,
    AVG(u.unemployment_rate) AS avg_unemployment
FROM 
    new_world_gdp g
JOIN 
    new_world_inflation i ON g.country_name = i.country_name
JOIN 
  new_world_unemployment u ON g.country_name = u.country_name
GROUP BY 
    g.country_name;


-- Analyze the relationship between inflation, average production, and their effects on unemployment in Egypt for adult males and females .

SELECT 
    g.year,
    g.gdp_growth AS gdp,
    i.inflation_rate AS inflation_rate,
    u.unemployment_rate AS unemployment_rate,
    u.sex AS gender 
from    
    new_world_gdp g
JOIN 
  new_world_inflation i ON g.country_name = i.country_name AND g.year = i.year
JOIN 
   new_world_unemployment u ON g.country_name = u.country_name AND g.year = u.year
WHERE 
    g.country_name = 'Egypt' 
    AND u.age_group = '25+' 
    AND g.year BETWEEN 2019 AND 2022
GROUP BY 
    g.year, g.gdp_growth, i.inflation_rate, u.unemployment_rate, u.sex  
ORDER BY 
    g.year;

    -- Analyze the type of relationship between inflation and average production rate in Egypt over the last ten years in Egypt.

SELECT 
    g.country_name,
    AVG(g.gdp_growth) AS avg_growth,
    AVG(i.inflation_rate) AS avg_inflation
FROM 
    new_world_gdp g
JOIN 
    new_world_inflation i ON g.country_name = i.country_name
where g.country_name= 'Egypt'    
GROUP BY 
    g.country_name;

-- Analyze the relationship between inflation and unemployment in Egypt.

SELECT 
    u.country_name,
    AVG(i.inflation_rate) AS avg_inflation,
    AVG(u.unemployment_rate) AS avg_unemployment
FROM 
   new_world_unemployment u
JOIN 
    new_world_inflation i ON u.country_name = i.country_name
 where u.country_name='Egypt'   
GROUP BY 
    u.country_name;

-- Compare the impact of both inflation and average production rate on unemployment in Egypt and Saudi Arabia.

SELECT 
    g.country_name,
    AVG(g.gdp_growth) AS avg_growth,
    AVG(i.inflation_rate) AS avg_inflation,
    AVG(u.unemployment_rate) AS avg_unemployment
FROM 
    new_world_gdp g
JOIN 
    new_world_inflation i ON g.country_name = i.country_name
JOIN 
   new_world_unemployment u ON g.country_name = u.country_name
WHERE 
    g.country_name IN ('Egypt', 'Saudi Arabia')
GROUP BY 
    g.country_name;

-- Analyze the impact of inflation and average production growth rates on unemployment in both Egypt and Saudi Arabia, for both males and females.

    SELECT 
    g.year,
    g.country_name,
    g.gdp_growth AS gdp,
    i.inflation_rate AS inflation_rate,
    u.unemployment_rate AS unemployment_rate,
    u.sex AS gender  
FROM 
    new_world_gdp g
JOIN 
   new_world_inflation i ON g.country_name = i.country_name AND g.year = i.year
JOIN 
   new_world_unemployment u ON g.country_name = u.country_name AND g.year = u.year
WHERE 
    (g.country_name = 'Egypt' OR g.country_name = 'Saudi Arabia') 
    AND u.age_group = '25+' 
    AND g.year BETWEEN 2019 AND 2022
ORDER BY 
    g.year, g.country_name, u.sex; 