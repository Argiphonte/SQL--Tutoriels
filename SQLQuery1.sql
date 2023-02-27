--SELECT JobTitle, AVG(Salary)
--FROM SQLTutoriel.dbo.EmployeeDemographics
--JOIN SQLTutoriel.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING AVG(Salary) > 45000
--ORDER BY AVG(Salary)


--SELECT *
--FROM SQLTutoriel.dbo.EmployeeDemographics

--UPDATE SQLTutoriel.dbo.EmployeeDemographics
--SET EmployeeID = 1012, Gender = 'Female', Age = 31
--WHERE FirstName = 'Holly' AND LastName = 'Flax'

--DELETE FROM SQLTutoriel.dbo.EmployeeDemographics
--WHERE EmployeeID = 1005

--SELECT Demo.EmployeeID, Sal.Salary
--FROM [SQLTutoriel].[dbo].[EmployeeDemographics] AS Demo
--JOIN [SQLTutoriel].[dbo].[EmployeeSalary] AS Sal
--	ON Demo.EmployeeID = Sal.EmployeeID

--SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Sal.JobTitle, Ware.Age
--FROM [SQLTutoriel].[dbo].EmployeeDemographics Demo
--LEFT JOIN [SQLTutoriel].[dbo].EmployeeSalary Sal
--	ON Demo.EmployeeID = Sal.EmployeeID
--LEFt JOIN [SQLTutoriel].[dbo].WareHouseEmployeeDemographics
--	ON Demo.EmployeeID = Ware.EmployeeID

--SELECT FirstName, LastName, Gender, Salary,
--COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
--FROM SQLTutoriel..EmployeeDemographics dem
--JOIN SQLTutoriel..EmployeeSalary sal
--	ON dem.EmployeeID = sal.EmployeeID

--SELECT Gender, COUNT(Gender) 
--FROM SQLTutoriel..EmployeeDemographics dem
--JOIN SQLTutoriel..EmployeeSalary sal
--	ON dem.EmployeeID = sal.EmployeeID
--GROUP BY Gender

--WITH CTE_Employee as 
--(SELECT FirstName, LastName, Gender, Salary
--, COUNT(gender) OVER (PARTITION BY Gender) as TotalGender
--, AVG(Salary) OVER (PARTITION BY Gender) as AVGSalary
--FROM SQLTutoriel..EmployeeDemographics emp
--JOIN SQLTutoriel..EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--WHERE Salary > '45000'
--)
--SELECT *
--FROM CTE_Employee

--CREATE TABLE #tempo_Employee (
--EmployeeID int,
--JobTitle varchar(100),
--Salary int
--)

--Select *
--FROM #tempo_Employee

--INSERT INTO #tempo_Employee VALUES (
--'1001', 'HR', '45000'
--)

--INSERT INTO #tempo_Employee
--SELECT *
--FROM SQLTutoriel..EmployeeSalary

--CREATE TABLE #Temp_Employee2 (
--JobTitle varchar(50),
--EmployeesPerJob int,
--AvgAge int, 
--AvgSalary int)

--INSERT INTO #Temp_Employee2
--SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(salary)
--FROM SQLTutoriel..EmployeeDemographics emp
--JOIN SQLTutoriel..EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--GROUP BY JobTitle

--Select *
--FROM #Temp_Employee2

--CREATE TABLE EmployeeErrors(
--EmployeeID varchar (50),
--FirstName varchar(50),
--LastName varchar(50)
--)

--INSERT INTO EmployeeErrors VALUES
--('1001   ', 'Jimbo', 'Halbert'),
--('    1002', 'Pamela', 'Beasely'),
--('1005', 'TOby', 'Flenderson - Fired')

--SELECT *
--FROM EmployeeErrors

--SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM
--FROM EmployeeErrors

--SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM
--FROM EmployeeErrors

--SELECT EmployeeID, RTRIM(EmployeeID) AS IDTRIM
--FROM EmployeeErrors

--SELECT LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
--FROM EmployeeErrors

--SELECT EmployeeErrors.FirstName, dem.FirstName
--FROM EmployeeErrors
--JOIN EmployeeDemographics dem
--	ON EmployeeErrors.FirstName = dem.FirstName

--CREATE PROCEDURE Temp_Employee
--AS
--DROP TABLE IF EXISTS #temp_employee
--Create table #temp_employee (
--JobTitle varchar(100),
--EmployeesPerJob int ,
--AvgAge int,
--AvgSalary int
--)


--Insert into #temp_employee
--SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
--FROM SQLTutorial..EmployeeDemographics emp
--JOIN SQLTutorial..EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--group by JobTitle

--Select * 
--From #temp_employee
--GO;




--CREATE PROCEDURE Temp_Employee2 
--@JobTitle nvarchar(100)
--AS
--DROP TABLE IF EXISTS #temp_employee3
--Create table #temp_employee3 (
--JobTitle varchar(100),
--EmployeesPerJob int ,
--AvgAge int,
--AvgSalary int
--)


--Insert into #temp_employee3
--SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
--FROM SQLTutorial..EmployeeDemographics emp
--JOIN SQLTutorial..EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--where JobTitle = @JobTitle --- make sure to change this in this script from original above
--group by JobTitle

--Select * 
--From #temp_employee3
--GO;


--exec Temp_Employee2 @jobtitle = 'Salesman'
--exec Temp_Employee2 @jobtitle = 'Accountant'

Select EmployeeID, JobTitle, Salary
From EmployeeSalary

-- Subquery in Select

Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary

-- How to do it with Partition By
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary

-- Why Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
order by EmployeeID


-- Subquery in From

Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
Order by a.EmployeeID


-- Subquery in Where


Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDemographics
	where Age > 30)