create database caremetrics;
use caremetrics;

select * from healthcare_data;
select count(*) from healthcare_data;

-- if there is duplication 
SELECT `Name`, `Age`, `Gender`, `Blood Type`, `Medical condition`, `Date of Admission`, `Doctor`, `Hospital`, `Insurance Provider`, `Billing Amount`, `Room Number`, `Admission Type`, `Discharge Date`, `Medication`, `Test Results`, COUNT(*)
FROM healthcare_data
GROUP BY `Name`, `Age`, `Gender`, `Blood Type`, `Medical condition`, `Date of Admission`, `Doctor`, `Hospital`, `Insurance Provider`, `Billing Amount`, `Room Number`, `Admission Type`, `Discharge Date`, `Medication`, `Test Results`
HAVING COUNT(*) > 1;



CREATE TABLE Patients (
    Patient_Id INT PRIMARY KEY auto_increment,
    Name VARCHAR(255),
    Gender VARCHAR(10),
    Age INT,
    Blood_Type VARCHAR(10),
    Condition_Id INT,
    Admission_Type_Id INT,
    Insurance_Provider_Id INT,
    Billing_Amount DECIMAL(10, 2),
    Medication VARCHAR(50),
    Room_Number VARCHAR(50), 
    FOREIGN KEY (Condition_Id) REFERENCES Medical_Conditions(Condition_Id),
    FOREIGN KEY (Admission_Type_Id) REFERENCES Admission_Types(Admission_Type_Id),
    FOREIGN KEY (Insurance_Provider_Id) REFERENCES Insurance_Providers(Insurance_Provider_Id)
);

INSERT INTO Patients (Name, Gender, Age, Blood_Type, Condition_Id, Admission_Type_Id, Insurance_Provider_Id, Billing_Amount, Medication, Room_Number)
SELECT 
    `Name`,
    `Gender`,
    `Age`,
    `Blood Type` AS Blood_Type,
    (SELECT Condition_Id FROM Medical_Conditions WHERE Medical_Condition = `Medical Condition`) AS Condition_Id,
    (SELECT Admission_Type_Id FROM Admission_Types WHERE Admission_Type = `Admission Type`) AS Admission_Type_Id,
    (SELECT Insurance_Provider_Id FROM Insurance_Providers WHERE Insurance_Provider = `Insurance Provider`) AS Insurance_Provider_Id,
    `Billing Amount` AS Billing_Amount,
    `Medication`,
    `Room Number` AS Room_Number 
FROM healthcare_data;

select * from patients;

select count(*) from patients;


CREATE TABLE Medical_Conditions (
    Condition_Id INT PRIMARY KEY auto_increment,
    Medical_Condition VARCHAR(255)
);

INSERT INTO Medical_Conditions (Medical_Condition)
SELECT DISTINCT `Medical Condition`
FROM healthcare_data;

select * from Medical_Conditions;


CREATE TABLE Admission_Types (
    Admission_Type_Id INT PRIMARY KEY auto_increment,
    Admission_Type VARCHAR(255)
);
INSERT INTO Admission_Types (Admission_Type)
SELECT DISTINCT `Admission Type`
FROM healthcare_data;

select * from Admission_Types;


CREATE TABLE Insurance_Providers (
    Insurance_Provider_Id INT PRIMARY KEY auto_increment,
    Insurance_Provider VARCHAR(255)
);
INSERT INTO Insurance_Providers (Insurance_Provider)
SELECT DISTINCT `Insurance Provider`
FROM healthcare_data;

select * from Insurance_Providers;


CREATE TABLE Doctors (
    Doctor_Id INT PRIMARY KEY auto_increment,
    Doctor_Name VARCHAR(255)
);

INSERT INTO Doctors (Doctor_Name)
SELECT DISTINCT `Doctor`
FROM healthcare_data;

select * from Doctors;


CREATE TABLE Hospitals (
    Hospital_Id INT PRIMARY KEY auto_increment,
    Hospital_Name VARCHAR(255)
);

INSERT INTO Hospitals (Hospital_Name)
SELECT DISTINCT `Hospital`
FROM healthcare_data;

select * from Hospitals;



CREATE TABLE Admissions_Facts (
    Admission_Id INT PRIMARY KEY auto_increment,
    Patient_Id INT,
    Doctor_Id INT,
    Hospital_Id INT,
    Discharge_Date DATE,
    Date_of_Admission DATE,
    FOREIGN KEY (Patient_Id) REFERENCES Patients(Patient_Id),
    FOREIGN KEY (Doctor_Id) REFERENCES Doctors(Doctor_Id),
    FOREIGN KEY (Hospital_Id) REFERENCES Hospitals(Hospital_Id)
);

INSERT INTO Admissions_Facts (Patient_Id, Doctor_Id, Hospital_Id, Discharge_Date, Date_of_Admission)
SELECT 
    p.Patient_Id,
    d.Doctor_Id,
    h.Hospital_Id,
    hd.`Discharge Date`,
    hd.`Date of Admission`
FROM healthcare_data hd
LEFT JOIN Patients p ON hd.`name` = p.Name 
LEFT JOIN Doctors d ON hd.`Doctor` = d.Doctor_Name 
LEFT JOIN Hospitals h ON hd.`Hospital` = h.Hospital_Name; 

select * from Admissions_Facts;



-- 1. What is the total number of patient for each medical condition??
SELECT 
    mc.Medical_Condition,
    COUNT(p.Patient_Id) AS Total_Patients
FROM 
    Patients p
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
GROUP BY 
    mc.Medical_Condition;
    
 -- 2 What is the total number of patients by gender??   
SELECT 
    Gender,
    COUNT(Patient_Id) AS Total_Patients
FROM 
    Patients
GROUP BY 
    Gender;
    
    
-- 3 what is the average age for each medical condition??
  SELECT 
    mc.Medical_Condition,
    AVG(p.Age) AS Average_Age
FROM 
    Patients p
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
GROUP BY 
    mc.Medical_Condition;
    
    -- 4 what is the number of patients by blood type for each medical condition??
  SELECT 
    p.Blood_Type,
    mc.Medical_Condition,
    COUNT(p.Patient_Id) AS Total_Patients
FROM 
    Patients p
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
GROUP BY 
    p.Blood_Type, mc.Medical_Condition;



-- 5 What is the number of patients by gender for each medical condition??
SELECT 
    mc.Medical_Condition,
    p.Gender,
    COUNT(p.Patient_Id) AS Total_Patients
FROM 
    Patients p
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
GROUP BY 
    mc.Medical_Condition, p.Gender;
  
  
  -- 6. Which age group has the highest number of admissions for a specific medical condition?
SELECT 
    mc.Medical_Condition,
    CASE 
        WHEN p.Age < 30 THEN 'Under 30'
        WHEN p.Age BETWEEN 30 AND 60 THEN '30-60'
        ELSE 'Above 60'
    END AS Age_Group,
    COUNT(p.Patient_Id) AS Total_Admissions
FROM 
    Patients p
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
GROUP BY 
    mc.Medical_Condition, Age_Group
ORDER BY 
    mc.Medical_Condition, Total_Admissions DESC;
    
-- 7 How much sum of billing amount for each hospital ??
SELECT 
    h.Hospital_Name,
    SUM(p.Billing_Amount) AS Total_Billing_Amount
FROM 
    Patients p
JOIN 
    Admissions_Facts af ON p.Patient_Id = af.Patient_Id
JOIN 
    Hospitals h ON af.Hospital_Id = h.Hospital_Id
GROUP BY 
    h.Hospital_Name
ORDER BY 
    Total_Billing_Amount DESC;



-- 8. what is the average bill amount for each insurance provider ??
SELECT 
    ip.Insurance_Provider,
    AVG(p.Billing_Amount) AS Average_Billing_Amount
FROM 
    Patients p
JOIN 
    Insurance_Providers ip ON p.Insurance_Provider_Id = ip.Insurance_Provider_Id
GROUP BY 
    ip.Insurance_Provider
ORDER BY 
    Average_Billing_Amount DESC;

-- 9. how many patients in each medical condition for each insurance provider??
SELECT 
    ip.Insurance_Provider,
    mc.Medical_Condition,
    COUNT(p.Patient_Id) AS Patient_Count
FROM 
    Patients p
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
JOIN 
    Insurance_Providers ip ON p.Insurance_Provider_Id = ip.Insurance_Provider_Id
GROUP BY 
    ip.Insurance_Provider, mc.Medical_Condition
ORDER BY 
    ip.Insurance_Provider, mc.Medical_Condition;



-- 10.how many patients for each room ??
SELECT 
    Room_Number, 
    COUNT(Patient_Id) AS Patient_Count
FROM 
    Patients
GROUP BY 
    Room_Number
ORDER BY 
    Patient_Count DESC;
    
 
 -- 11 what is the total number of rooms??  
SELECT 
    COUNT(DISTINCT Room_Number) AS Total_Rooms
FROM 
    Patients;
   
-- 12 what is the total number of hospitals ?? 
   SELECT 
    COUNT(*) AS Total_Hospitals
FROM 
    Hospitals;
 
 -- 13 what is the total number of doctors 
  SELECT COUNT(*) AS Total_Doctors
FROM Doctors;
  
 -- 14 What are the top 5 highest billing amounts paid by patients??  
 SELECT *
FROM Patients
ORDER BY Billing_Amount DESC
LIMIT 5;
   
  
-- 15 How many patients are there from each insurance provider؟؟  
  SELECT ip.Insurance_Provider, COUNT(p.Patient_Id) AS Patient_Count
FROM Patients p
JOIN Insurance_Providers ip ON p.Insurance_Provider_Id = ip.Insurance_Provider_Id
GROUP BY ip.Insurance_Provider;


-- 16 How many patients were admitted for each type of admission??  
SELECT at.Admission_Type, COUNT(p.Patient_Id) AS Patient_Count
FROM Patients p
JOIN Admission_Types at ON p.Admission_Type_Id = at.Admission_Type_Id
GROUP BY at.Admission_Type;
  
  
 -- 17 .What is the total billing amount for each doctor? desc?
 SELECT 
    d.Doctor_Name,
    SUM(p.Billing_Amount) AS Total_Billing_Amount
FROM 
    Doctors d
JOIN 
    Admissions_Facts af ON d.Doctor_Id = af.Doctor_Id
JOIN 
    Patients p ON af.Patient_Id = p.Patient_Id
GROUP BY 
    d.Doctor_Name
ORDER BY 
    Total_Billing_Amount DESC;
    
    
    -- 18 What is the average age of patients in each hospital?
    SELECT h.Hospital_Name, AVG(p.Age) AS Average_Age
FROM Patients p
JOIN Admissions_Facts af ON p.Patient_Id = af.Patient_Id
JOIN Hospitals h ON af.Hospital_Id = h.Hospital_Id
GROUP BY h.Hospital_Name;

   -- 19 What is the most common medical condition among patients?? 
    SELECT mc.Medical_Condition, COUNT(p.Patient_Id) AS Patient_Count
FROM Patients p
JOIN Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
GROUP BY mc.Medical_Condition
ORDER BY Patient_Count DESC
LIMIT 1;

    
-- 20. What is the total number of patients admitted by each doctor?
SELECT 
    d.Doctor_Name,
    COUNT(af.Patient_Id) AS Total_Patients_Admitted
FROM 
    Doctors d
JOIN 
    Admissions_Facts af ON d.Doctor_Id = af.Doctor_Id
GROUP BY 
    d.Doctor_Name
ORDER BY 
    Total_Patients_Admitted DESC;
    
    
 -- 21 How many patients with each medical condition are admitted to different hospitals?
SELECT 
    mc.Medical_Condition,
    h.Hospital_Name,
    COUNT(DISTINCT af.Patient_Id) AS Patient_Count
FROM 
    Admissions_Facts af
JOIN 
    Patients p ON af.Patient_Id = p.Patient_Id
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
JOIN 
    Hospitals h ON af.Hospital_Id = h.Hospital_Id
GROUP BY 
    mc.Medical_Condition, h.Hospital_Name
ORDER BY 
    mc.Medical_Condition, h.Hospital_Name;

-- 22 How many patients with each type of admission are admitted to different hospitals?
SELECT 
    at.Admission_Type,
    h.Hospital_Name,
    COUNT(DISTINCT af.Patient_Id) AS Patient_Count
FROM 
    Admissions_Facts af
JOIN 
    Patients p ON af.Patient_Id = p.Patient_Id
JOIN 
    Admission_Types at ON p.Admission_Type_Id = at.Admission_Type_Id
JOIN 
    Hospitals h ON af.Hospital_Id = h.Hospital_Id
GROUP BY 
    at.Admission_Type, h.Hospital_Name
ORDER BY 
    at.Admission_Type, h.Hospital_Name;


-- 23. top 10 most expensive hospitals 
SELECT 
    h.Hospital_Name,
    SUM(p.Billing_Amount) AS Total_Billing
FROM 
    Hospitals h
JOIN 
    Admissions_Facts af ON h.Hospital_Id = af.Hospital_Id
JOIN 
    Patients p ON af.Patient_Id = p.Patient_Id
GROUP BY 
    h.Hospital_Name
ORDER BY 
    Total_Billing DESC
LIMIT 10;



 -- 24 What is the most common medical condition for patients under the age of 30?
SELECT 
    mc.Medical_Condition,
    COUNT(p.Patient_Id) AS Patient_Count
FROM 
    Patients p
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
WHERE 
    p.Age < 30
GROUP BY 
    mc.Medical_Condition
ORDER BY 
    Patient_Count DESC
LIMIT 1;


-- 25 What is the average billing amount for patients with specific medical conditions?
SELECT 
    mc.Medical_Condition,
    AVG(p.Billing_Amount) AS Average_Billing_Amount
FROM 
    Patients p
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
GROUP BY 
    mc.Medical_Condition;


-- 26. What is the average length of stay (difference between admission and discharge) for each hospital?
SELECT 
    h.Hospital_Name,
    AVG(DATEDIFF(af.Discharge_Date, af.Date_of_Admission)) AS Average_Length_of_Stay
FROM 
    Hospitals h
JOIN 
    Admissions_Facts af ON h.Hospital_Id = af.Hospital_Id
GROUP BY 
    h.Hospital_Name;
    
    
    -- 27 what is the average length of hospitalization ؟
    SELECT 
    AVG(DATEDIFF(af.Discharge_Date, af.Date_of_Admission)) AS Average_Length_of_Hospitalization
FROM 
    Admissions_Facts af;


-- 28 What is the average length of stay for each medical condition??
SELECT mc.Medical_Condition, AVG(DATEDIFF(af.Discharge_Date, af.Date_of_Admission)) AS Average_Length_of_Stay
FROM Admissions_Facts af
JOIN Patients p ON af.Patient_Id = p.Patient_Id
JOIN Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
GROUP BY mc.Medical_Condition;


-- 29 What are the highest medication prescribed to patients?
SELECT Medication, COUNT(*) AS Medication_Count
FROM Patients
GROUP BY Medication
ORDER BY Medication_Count DESC
LIMIT 1;

-- 30 Highest medications for each medical condition ?
SELECT 
    mc.Medical_Condition,
    p.Medication,
    COUNT(p.Medication) AS Medication_Count
FROM 
    Patients p
JOIN 
    Medical_Conditions mc ON p.Condition_Id = mc.Condition_Id
GROUP BY 
    mc.Medical_Condition, p.Medication
ORDER BY 
    mc.Medical_Condition;
    