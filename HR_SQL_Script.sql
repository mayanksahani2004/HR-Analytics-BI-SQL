-- CREATE DATABASE HR;

USE HR;

-- CREATE TABLE hr_analytics(
--     EmployeeID VARCHAR(15) PRIMARY KEY,
--     Name VARCHAR(100),
--     Age TINYINT,
--     Gender Varchar(10),
--     Department VARCHAR(100),
--     JobRole VARCHAR(100),
--     EducationLevel VARCHAR(100),
--     YearsAtCompany INT,
--     MonthlyIncome DECIMAL(10,2),
--     PerformanceRating TINYINT,
--     JobSatisfaction TINYINT,
--     WorkLifeBalance TINYINT,
--     MaritalStatus VARCHAR(10),
--     DistanceFromHome TINYINT,
--     OverTime VARCHAR(10),
--     TrainingTimesLastYear TINYINT,
--     NumCompaniesWorked TINYINT,
--     TotalWorkingYears TINYINT,
--     DateOfJoining DATE,
--     Attrition VARCHAR(10)
-- )

-- KPIs

-- 1. Total No. of Employees 
SELECT COUNT(EmployeeID) AS Employee_Count 
FROM hr_analytics;

-- 2. Average Age of Employees
SELECT ROUND(AVG(Age)) AS Average_Age
FROM hr_analytics;

-- 3. Attrition Count 
SELECT SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count 
FROM hr_analytics;

-- 4. Attrition Rate 
SELECT ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/COUNT(EmployeeID),2) AS Attrition_Percentage 
FROM hr_analytics;

-- 5. Average Monthly Income 
SELECT ROUND(AVG(MonthlyIncome),2) AS Average_Monthly_Income
FROM hr_analytics;

-- 6. Average Working Experience at the Company 
SELECT ROUND(AVG(YearsAtCompany)) AS Average_Working_Experience
FROM hr_analytics;



-- EMPLOYEE DEMOGRAPHICS
 
-- 1. Gender Distribution and Attrition Count 
SELECT Gender, COUNT(EmployeeID) AS employee_count,SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS attrition_count,
ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY Gender
ORDER BY attrition_count DESC;

-- 2. Marital Status Distribution and Attrition Count 
SELECT MaritalStatus, COUNT(EmployeeID) AS employee_count,SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS attrition_count,
ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY MaritalStatus
ORDER BY attrition_count DESC;

-- 3. Age Group Distribution and Attrition Count
SELECT CASE WHEN Age<30 THEN "20-29" WHEN Age<40 THEN "30-39" WHEN Age<50 THEN "40-49" ELSE "50-59" END AS Age_Group, COUNT(EmployeeID) AS employee_count,
SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count,ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY Age_Group
ORDER BY attrition_count DESC;

-- 4. Education Level Distribution and Attrition Count
SELECT EducationLevel, COUNT(EmployeeID) AS employee_count,SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY EducationLevel
ORDER BY attrition_count DESC;



-- EMPLOYEE JOB DETAILS

-- 1. Employee Count and Attrition Count by Department
SELECT Department, COUNT(EmployeeID) AS employee_count,SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY Department
ORDER BY attrition_count DESC;

-- 2. Employee Count and Attrition Count by Job Role
SELECT JobRole, COUNT(EmployeeID) AS employee_count,SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY JobRole
ORDER BY attrition_count DESC;

-- 3. Employee Count and Attrition Count by OverTime
SELECT OverTime, COUNT(EmployeeID) AS employee_count,SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY OverTime
ORDER BY attrition_count DESC;

-- 4. Employee Count and Attrition Count by Distance from Home
SELECT CASE WHEN DistanceFromHome<=5 THEN "0-5" 
            WHEN DistanceFromHome<=10 THEN "6-10"
            WHEN DistanceFromHome<=15 THEN "11-15"
            WHEN DistanceFromHome<=20 THEN "16-20"
            WHEN DistanceFromHome<=25 THEN "21-25"
            ELSE "26-30" END AS Distance, 
            COUNT(EmployeeID) AS employee_count,SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY Distance
ORDER BY attrition_count DESC;


-- 5. Employee Count and Attrition Count by Monthly Salary
SELECT CASE WHEN MonthlyIncome<50000 THEN "<50K" 
            WHEN MonthlyIncome<100000 THEN "50K-100K" 
            WHEN MonthlyIncome<150000 THEN "100K-150K" 
            WHEN MonthlyIncome<200000 THEN "150K-200K" 
            ELSE ">200K" END AS salary_distribution,
COUNT(EmployeeID) AS employee_count,
SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY salary_distribution
ORDER BY attrition_count DESC;


-- 6. Employee Count and Attrition Count by Working Years At Company
SELECT CASE WHEN YearsAtCompany<=2 THEN "1-2" 
            WHEN YearsAtCompany<=5 THEN "3-5" 
            WHEN YearsAtCompany<=10 THEN "6-10"
            ELSE "10+" END AS Years_At_Company,
COUNT(EmployeeID) AS employee_count,
SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY Years_At_Company
ORDER BY attrition_count DESC;



-- EMPLOYEE RATINGS ANALYSIS

-- 1. Performance Rating by Department 
SELECT Department, COUNT(CASE WHEN PerformanceRating=1 THEN 1 END) AS "1",
				   COUNT(CASE WHEN PerformanceRating=2 THEN 1 END) AS "2",
                   COUNT(CASE WHEN PerformanceRating=3 THEN 1 END) AS "3",
                   COUNT(CASE WHEN PerformanceRating=4 THEN 1 END) AS "4",
SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count
-- ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY Department
ORDER BY attrition_count DESC;


-- 2. Job Satisfaction Rating by Department 
SELECT Department, COUNT(CASE WHEN JobSatisfaction=1 THEN 1 END) AS "1",
				   COUNT(CASE WHEN JobSatisfaction=2 THEN 1 END) AS "2",
                   COUNT(CASE WHEN JobSatisfaction=3 THEN 1 END) AS "3",
                   COUNT(CASE WHEN JobSatisfaction=4 THEN 1 END) AS "4",
SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count
-- ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY Department
ORDER BY attrition_count DESC;


-- 3. Work Life Balance Rating by Department 
SELECT Department, COUNT(CASE WHEN WorkLifeBalance=1 THEN 1 END) AS "1",
				   COUNT(CASE WHEN WorkLifeBalance=2 THEN 1 END) AS "2",
                   COUNT(CASE WHEN WorkLifeBalance=3 THEN 1 END) AS "3",
                   COUNT(CASE WHEN WorkLifeBalance=4 THEN 1 END) AS "4",
SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count
-- ROUND(100*SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(EmployeeID) FROM hr_analytics),2) AS attrition_percentage
FROM hr_analytics
GROUP BY Department
ORDER BY attrition_count DESC;