CREATE DATABASE Depression ;
USE Depression ;
CREATE TABLE Depression (
Name VARCHAR(100),
Age INT NOT NULL, 
Marital_Status VARCHAR (50),
Education VARCHAR (50),
Number_of_Children VARCHAR (50),
Smoking_Status  VARCHAR (50),
Physical_Activity_Level  VARCHAR (50),
Employment_Status VARCHAR (50),
Income INT NOT NULL, 
Alcohol_Consumption VARCHAR (50),
Dietary_Habits VARCHAR (50),
Sleep_Patterns VARCHAR (50),
History_of_Mental_Illness VARCHAR (50),
History_of_Substance_Abuse VARCHAR (50),
Family_History_of_Depression VARCHAR (50),
Chronic_Medical_Conditions VARCHAR (50)
);
USE Depression ;

SELECT * 
FROM Depression ;

#  How does depression prevalence vary across different age groups?
ALTER TABLE Depression
ADD age_range VARCHAR(255);

#  How does depression prevalence vary across different age groups?
ALTER TABLE Depression
ADD Income_Leveling VARCHAR(255);

# Categories of annual income according to poverty line for a normal family
UPDATE Depression
SET Income_Leveling = CASE
    WHEN Income <= 15000 THEN 'Extreme_Poverty'
    WHEN Income > 15000 AND Income <= 30000 THEN 'Poverty'
    WHEN Income > 30000 AND Income <= 60000 THEN 'Low_Income'
    WHEN Income > 60000 AND Income <= 150000 THEN 'Middle_Income'
    WHEN Income > 150000 AND Income <= 500000 THEN 'Rich'
    WHEN Income > 500000 THEN 'Wealthy'
    ELSE 'Unknown Income Group'
END;

# Age range to determine the groups variance
UPDATE Depression
SET age_range = CASE
    WHEN Age BETWEEN 18 AND 26 THEN '18-26 years'
    WHEN Age BETWEEN 27 AND 35 THEN '27-35 years'
    WHEN Age BETWEEN 36 AND 45 THEN '36-45 years'
    WHEN Age BETWEEN 46 AND 55 THEN '46-55 years'
    WHEN Age BETWEEN 56 AND 65 THEN '56-65 years'
    WHEN Age >= 66 THEN '66 years and above'
    ELSE 'Unknown Age Group'
END;

SELECT *
FROM depression ;

SELECT COUNT(Name) AS Number_OF_Depressed, age_range
FROM depression 
WHERE age_range IN ('18-26 years', '27-35 years', '36-45 years', '46-55 years', '56-65 years', '66 years and above')
GROUP BY age_range;

# Is marital status associated with depression risk?
SELECT COUNT(Name) AS Number_OF_Depressed, Marital_Status
FROM depression 
WHERE Marital_Status IN ('Married', 'Divorced', 'Single', 'Widowed')
GROUP BY Marital_Status;

# Does education level influence the likelihood of experiencing depression?
SELECT COUNT(Name) AS Number_OF_Depressed , Education
FROM depression 
WHERE Education IN ("Bachelor's Degree", "High School", "Associate Degree", "Master's Degree", "PhD")
GROUP BY Education;

# Does smoking increase the risk of depression?
SELECT COUNT(Name) AS Number_OF_Depressed , Smoking_Status
FROM depression 
WHERE Smoking_Status IN ("Current", "Former", "Non-smoker")
GROUP BY Smoking_Status;

# How does physical activity level relate to depression?
SELECT COUNT(Name) AS Number_OF_Depressed , Physical_Activity_Level
FROM depression 
WHERE Physical_Activity_Level IN ("Active", "Sedentary", "Moderate")
GROUP BY Physical_Activity_Level;

# Is alcohol consumption a risk factor for depression?
SELECT COUNT(Name) AS Number_OF_Depressed , Alcohol_Consumption
FROM depression 
WHERE Alcohol_Consumption IN ("High", "Moderate", "Low")
GROUP BY Alcohol_Consumption;

# Are unhealthy dietary habits associated with higher depression rates?
SELECT COUNT(Name) AS Number_OF_Depressed , Dietary_Habits
FROM depression 
WHERE Dietary_Habits IN ("Healthy", "Moderate", "Unhealthy")
GROUP BY Dietary_Habits;

# Does poor sleep quality contribute to depression? 
SELECT COUNT(Name) AS Number_OF_Depressed , Sleep_Patterns
FROM depression 
WHERE Sleep_Patterns IN ("Good", "Fair", "Poor")
GROUP BY Sleep_Patterns;

#  Is a history of mental illness a risk factor for depression? 
SELECT COUNT(Name) AS Number_OF_Depressed , History_of_Mental_Illness
FROM depression 
WHERE History_of_Mental_Illness IN ("No", "Yes")
GROUP BY History_of_Mental_Illness;

# Does substance abuse increase the likelihood of experiencing depression? 
SELECT COUNT(Name) AS Number_OF_Depressed , History_of_Substance_Abuse
FROM depression 
WHERE History_of_Substance_Abuse IN ("No", "Yes")
GROUP BY History_of_Substance_Abuse;

# How does family history of depression influence individual risk?
SELECT COUNT(Name) AS Number_OF_Depressed , Family_History_of_Depression
FROM depression 
WHERE Family_History_of_Depression IN ("No", "Yes")
GROUP BY Family_History_of_Depression;

# Does income level impact depression prevalence?
SELECT COUNT(Name) AS Number_OF_Depressed, Income_Leveling
FROM depression 
WHERE Income_Leveling IN ('Extreme_Poverty', 'Poverty', 'Low_Income', 'Middle_Income', 'Rich', 'Wealthy')
GROUP BY Income_Leveling;

# Is employment status associated with depression risk?
SELECT COUNT(Name) AS Number_OF_Depressed , Employment_Status
FROM depression 
WHERE Employment_Status IN ("Employed", "Unemployed")
GROUP BY Employment_Status;

# Are individuals from lower socioeconomic backgrounds more likely to experience depression?
SELECT COUNT(Name) AS Total_Individuals
FROM Depression
WHERE Income_Leveling IN ('Extreme_Poverty', 'Poverty')
AND (History_of_Mental_Illness = 'Yes' 
    OR History_of_Substance_Abuse = 'Yes' 
    OR Family_History_of_Depression = 'Yes'
    OR Chronic_Medical_Conditions = 'Yes');
    
# Are individuals from lower socioeconomic backgrounds more likely to experience depression with No. of Children?
SELECT Income_Leveling, Number_of_Children, COUNT(Name) AS Total_Individuals
FROM Depression
WHERE Income_Leveling IN ('Extreme_Poverty', 'Poverty')
AND (History_of_Mental_Illness = 'Yes' 
    OR History_of_Substance_Abuse = 'Yes' 
    OR Family_History_of_Depression = 'Yes'
    OR Chronic_Medical_Conditions = 'Yes')
GROUP BY Income_Leveling, Number_of_Children;

# Are individuals from lower socioeconomic backgrounds more likely to experience depression with No. of Children and marital status ?
SELECT Income_Leveling, Number_of_Children, Marital_Status, COUNT(Name) AS Total_Individuals
FROM Depression
WHERE Income_Leveling IN ('Extreme_Poverty', 'Poverty')
AND (History_of_Mental_Illness = 'Yes' 
    OR History_of_Substance_Abuse = 'Yes' 
    OR Family_History_of_Depression = 'Yes'
    OR Chronic_Medical_Conditions = 'Yes')
GROUP BY Income_Leveling, Number_of_Children, Marital_Status
ORDER BY Income_Leveling;

