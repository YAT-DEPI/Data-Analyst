/*Please not that this is the first draft of the cleaning 
process which was then done better with python*/

CREATE DATABASE IF NOT EXISTS Waste;
USE Waste;
CREATE TABLE IF NOT EXISTS WasteData (
    Country VARCHAR(100),
    Region VARCHAR(100),
    Indicator VARCHAR(255),
    Indicator_Unit VARCHAR(100),
    Year INT,
    Value FLOAT,
    Calculation VARCHAR(100),
    Disaggregation_Level VARCHAR(100),
    Information TEXT
);
-- Observe the unique values in "Disaggregation_Level"
SELECT DISTINCT Disaggregation_Level FROM WasteData;

-- Update "Disaggregation_Level" to "country" where it is "PAÍS"
UPDATE wastedata
SET Disaggregation_Level = 'country'
WHERE Disaggregation_Level = 'PAÍS';

-- Update "Disaggregation_Level" to "Unknown" where it is empty
UPDATE wastedata
SET Disaggregation_Level = 'Unknown'
WHERE Disaggregation_Level = '';

-- Update "Disaggregation_Level" to "Country, Municipality" where it is "PAÍS, MUNICIPIO"
UPDATE wastedata
SET Disaggregation_Level = 'Country, Municipality'
WHERE Disaggregation_Level = 'PAÍS, MUNICIPIO';

-- Update "Disaggregation_Level" to "Country, Department" where it is "PAÍS, DEPARTAMENTO"
UPDATE wastedata
SET Disaggregation_Level = 'Country, Department'
WHERE Disaggregation_Level = 'PAÍS, DEPARTAMENTO';

-- Update "Disaggregation_Level" to "Country, Macroregion" where it is "PAÍS, MACROREGIÓN"
UPDATE wastedata
SET Disaggregation_Level = 'Country, Macroregion'
WHERE Disaggregation_Level = 'PAÍS, MACROREGIÓN';

-- Update "Disaggregation_Level" to "Country, Region, Municipality" where it is "PAÍS, REGIÓN, MUNICIPIO"
UPDATE wastedata
SET Disaggregation_Level = 'Country, Region, Municipality'
WHERE Disaggregation_Level = 'PAÍS, REGIÓN, MUNICIPIO';

UPDATE wastedata
SET Disaggregation_Level = 'Country, Region, Area'
WHERE Disaggregation_Level = 'PAÍS, REGIÓN, ÁREA';

UPDATE wastedata
SET Disaggregation_Level = 'Country, Region, Province'
WHERE Disaggregation_Level = 'PAÍS, REGIÓN, PROVINCIA';

UPDATE wastedata
SET Disaggregation_Level = 'Partial'
WHERE Disaggregation_Level = 'PARCIAL';

UPDATE wastedata
SET Disaggregation_Level = 'District'
WHERE Disaggregation_Level = 'DISTRITO';

UPDATE wastedata
SET Disaggregation_Level = 'Country, District'
WHERE Disaggregation_Level = 'PAÍS, DISTRITO';

UPDATE wastedata
SET Disaggregation_Level = 'Country'
WHERE Disaggregation_Level = 'PAÍS';

UPDATE wastedata
SET Disaggregation_Level = 'Subregion'
WHERE Disaggregation_Level = 'SUBREGIÓN';

UPDATE wastedata
SET Disaggregation_Level = 'Region'
WHERE Disaggregation_Level = 'REGIÓN';

-- Observe the unique values in "Calculation"
SELECT DISTINCT Calculation FROM wastedata;

-- Translate "DIRECTO" to "DIRECT"
UPDATE wastedata
SET Calculation = 'DIRECT'
WHERE Calculation = 'DIRECTO';

-- Translate "INDIRECTO" to "INDIRECT"
UPDATE wastedata
SET Calculation = 'INDIRECT'
WHERE Calculation = 'INDIRECTO';

-- Observe the unique values in "Information"
SELECT DISTINCT Information FROM wastedata;

-- Translate empty values in "Information" to "Unknown"
UPDATE wastedata
SET Information = 'Unknown'
WHERE Information = '';

-- Translate "OFICIAL" to "Official"
UPDATE wastedata
SET Information = 'Official'
WHERE Information = 'OFICIAL';

-- Translate "IMPUTADA" to "Inputed"
UPDATE wastedata
SET Information = 'Inputed'
WHERE Information = 'IMPUTADA';

-- To check for duplicates
SELECT COUNT(*) AS duplicate_count
FROM wastedata
GROUP BY Country, Region, Indicator, Indicator_Unit, Year, Value, Calculation, Disaggregation_Level, Information
HAVING COUNT(*) > 1;

-- Count null values
SELECT
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_null_count,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS Region_null_count,
    SUM(CASE WHEN Indicator IS NULL THEN 1 ELSE 0 END) AS Indicator_null_count,
    SUM(CASE WHEN Indicator_Unit IS NULL THEN 1 ELSE 0 END) AS Indicator_Unit_null_count,
    SUM(CASE WHEN Year IS NULL THEN 1 ELSE 0 END) AS Year_null_count,
    SUM(CASE WHEN Value IS NULL THEN 1 ELSE 0 END) AS Value_null_count,
    SUM(CASE WHEN Calculation IS NULL THEN 1 ELSE 0 END) AS Calculation_null_count,
    SUM(CASE WHEN Disaggregation_Level IS NULL THEN 1 ELSE 0 END) AS Disaggregation_Level_null_count,
    SUM(CASE WHEN Information IS NULL THEN 1 ELSE 0 END) AS Information_null_count
FROM wastedata;

-- Export the data to a CSV file
SELECT *
INTO OUTFILE 'C:/Users/abdulrahman/OneDrive/Desktop/Final project/Translated.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM wastedata;