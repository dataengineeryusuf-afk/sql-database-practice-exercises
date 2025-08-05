Create database Tables_Overview;

USE Tables_Overview;

CREATE TABLE EmployeesTable(
EmployeeID INT Primary Key,
FirstName VARCHAR(50),
LastName VARCHAR(50),
DepartmentID  INT REFERENCES Departments(DepartmentID),
Salary DECIMAL(10, 2),
HireDate DATE
)

INSERT INTO EmployeesTable
VALUES
(1, 'John', 'Doe', 1, 50000.00, '2020-01-15'),
(2, 'Jane', 'Smith', 2, 60000.00, '2019-06-23'),
(3, 'Sam', 'Green', 1, 55000.00, '2021-03-01'),
(4, 'Mary', 'Brown', 3, 75000.00, '2018-11-12'),
(5, 'Mike', 'Wilson', 2, 62000.00, '2020-10-05')

CREATE TABLE Departments(
DepartmentID INT Primary Key,
DepartmentName VARCHAR(50)
)

INSERT INTO Departments
VALUES 
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

CREATE TABLE Projects(
ProjectID INT Primary Key,
ProjectName VARCHAR(100),
StartDate DATE,
EndDate DATE
)

INSERT INTO Projects
VALUES
(1, 'Website Redesign', '2022-01-10', '2022-03-15'),
(2, 'Payroll System', '2021-05-01', '2021-12-31'),
(3, 'Marketing Campaign', '2022-02-20', '2022-05-01');

CREATE TABLE EmployeeProjects(
EmployeeID INT REFERENCES EmployeesTable(EmployeeID),
ProjectID INT REFERENCES Projects(ProjectID)
)

INSERT INTO EmployeeProjects (EmployeeID, ProjectID)
VALUES
(1, 1),
(2, 1),
(1, 2),
(3, 2),
(4, 3),
(5, 3);
CREATE TABLE Salaries(
SalaryID INT Primary Key,
EmployeeID INT REFERENCES EmployeesTable(EmployeeID),
SalaryDate DATE,
Amount DECIMAL(10, 2)
)

INSERT INTO Salaries
VALUES
(1, 1, '2023-01-01', 50000.00),
(2, 2, '2023-01-01', 60000.00),
(3, 3, '2023-01-01', 55000.00),
(4, 4, '2023-01-01', 75000.00),
(5, 5, '2023-01-01', 62000.00);


--1. Select all columns from the `Employees` table.

Select * from EmployeesTable

--2. Retrieve only the `FirstName` and `LastName` of all employees.

Select FirstName, LastName from EmployeesTable

--3. Get the `EmployeeID` and `DepartmentName` for all employees.

Select EmployeeID , DepartmentID from EmployeesTable

--4. Find the first and last name of employees who work in the HR department.

Select FirstName, LastName from EmployeesTable join
Departments on EmployeesTable.DepartmentID = Departments.DepartmentID
where Departments.DepartmentName = 'HR'


Select * from EmployeesTable
Select * from EmployeeProjects
Select * from Salaries
Select * from Departments
Select * from Projects


--5. List the employees who were hired after January 1, 2020.

Select * from EmployeesTable where HireDate > '2020-01-01'


--6. Retrieve all distinct departments from the `Departments` table.


Select distinct DepartmentName from Departments

--7. Count the number of employees in each department.

select count(e.EmployeeID) as TotalEmp, d.DepartmentName from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName

--8. Display the names of employees who have a salary greater than $60,000.


--9. Find the employee with the highest salary.

Select * from EmployeesTable where Salary = (Select max(Salary)as MaxSalary from EmployeesTable)


--10. Select employees whose last name starts with 'S'.

Select * from EmployeesTable where LastName like 's%'

--11. Retrieve the employees who do not belong to the IT department.

Select * from EmployeesTable e join Departments d on 
e.DepartmentID = d.DepartmentID where d.DepartmentName not in ('IT')


--12. Find employees whose `Salary` is between $50,000 and $60,000.

select * from EmployeesTable where Salary between 50000 and 60000
SELECT * FROM EmployeesTable 
WHERE Salary  >= 50000 and Salary <=60000
            

--13. Get the employees' full names and their hire date in descending order.

select FirstName+' '+ LastName,HireDate  from EmployeesTable order by HireDate desc

select concat(FirstName,' ', LastName) as FullName, HireDate from EmployeesTable 
order by HireDate desc

--14. List employees who were hired in the year 2021.

select * from EmployeesTable where year(HireDate) = '2021'

--15. Display the total number of employees in the company.

select count(EmployeeID) as TotalEmp from EmployeesTable
--16. Find the average salary of all employees.

select avg(Salary) as AvgSalEmp from EmployeesTable
--17. List employees working on the "Payroll System" project.

select e. *  from EmployeesTable e join
EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on ep.ProjectID = p.ProjectID
where p.ProjectName = 'Payroll System'


--18. Select employees who are assigned to more than one project.

select e.EmployeeID, e.FirstName, e.LastName, count(ep.ProjectID) as ProjectCount from EmployeesTable e join
EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on ep.ProjectID = p.ProjectID
group by e.EmployeeID, e.FirstName, e.LastName
having count(ep.ProjectID) > 1

--19. Find the `DepartmentName` for each `EmployeeID` in the `Employees` table.

Select d.DepartmentName,e.EmployeeID,e.FirstName,e.LastName from Departments d
join EmployeesTable e on d.DepartmentID= e.DepartmentID
order by d.DepartmentName, e.EmployeeID, e.FirstName, e.LastName

--20. Retrieve the `FirstName`, `LastName`, and `DepartmentName` of all employees using a JOIN.

Select d.DepartmentName,e.FirstName,e.LastName from Departments d
join EmployeesTable e on d.DepartmentID= e.DepartmentID
order by d.DepartmentName, e.EmployeeID, e.FirstName, e.LastName

--#### **Intermediate SQL Queries**

--21. List all projects that started in 2022.

select * from Projects where year(StartDate)= 2022

--22. Count the number of employees working in each project.

select count(e.EmployeeID) as TotalEmp, p.ProjectName  from EmployeesTable e 
join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID 
join Projects p on ep.ProjectID = p.ProjectID
group by p.ProjectName

--23. Retrieve employees who are not assigned to any project.

select e. * from EmployeesTable e 
left join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
where ep.ProjectID is null

SELECT e.*
FROM EmployeesTable e
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL;

--24. Find employees who have never received a salary increase.
select e.EmployeeID,e.FirstName, e.LastName from EmployeesTable e 
left join Salaries s on e.EmployeeID = s.EmployeeID where s.Amount is null

--25. Get the names of all employees and the number of projects they are involved in.

select e.EmployeeID ,e.FirstName, e.LastName, count(p.ProjectName) as NumProject from EmployeesTable e join
EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on ep.ProjectID =p.ProjectID
group by e.EmployeeID,e.FirstName, e.LastName

--26. Retrieve the maximum salary in each department.

Select d.DepartmentName ,max(e.Salary) as MaxSalary from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName



--27. Display the department name and the total salary of its employees.

Select d.DepartmentName ,sum(e.Salary) as TotalSalary from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName

--28. Find the average salary per department.
Select d.DepartmentName ,avg(e.Salary) as AvgSalary from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName

--29. List employees who have the same salary as another employee.

Select distinct e1.EmployeeID ,e1.FirstName, e1.LastName, e1.Salary from EmployeesTable e1
join EmployeesTable e2 on e1.Salary = e2.Salary 
and e1.EmployeeID <> e2.EmployeeID

--30. Retrieve the project name and the duration of the project (in days).

Select ProjectName, datediff(day, StartDate, EndDate) as DurationInDays from Projects
Select * from Projects
--31. Get the details of employees who are both in the IT department and assigned to the "Website Redesign" project.
select e.FirstName, e.LastName, d.DepartmentName, p.ProjectName from EmployeesTable e
join EmployeeProjects ep  on e.EmployeeID = ep.EmployeeID
join Projects p on p.ProjectID = ep.ProjectID
join Departments d on d.DepartmentID = e.DepartmentID
where d.DepartmentName = 'IT' and p.ProjectName = 'Website Redesign'


--32. Find the total salary paid to employees in 2023.

select sum(e.Salary) as TotalSalasy from EmployeesTable e
join Salaries s on e.EmployeeID = s.EmployeeID
where year (s.SalaryDate) = '2023'


--33. List employees who are not working on any project in 2022.

Select e. * from EmployeesTable e
left join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
left join Projects p on ep.ProjectID = p.ProjectID
and (year (p.StartDate) = 2022 or year(p.EndDate)=2022)
where p.ProjectName is null 


--34. Find employees whose salary is less than the average salary in their department.

select distinct e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentName from EmployeesTable e 
join Departments d on e.DepartmentID = d.DepartmentID 
where e.Salary <( select avg(e2.Salary)  from EmployeesTable e2 
where e.DepartmentID = e2.DepartmentID
)


--35. Retrieve employees who were hired in the last 6 months.

select * from EmployeesTable
where HireDate >= DATEADD(MONTH, -6, GETDATE())

--36. Get the second highest salary in the `Employees` table.

select top 1 Salary from EmployeesTable where Salary <(select max(Salary) from EmployeesTable)
order by Salary desc

--37. List all employees who joined the company on the same date.

select * 
from EmployeesTable
where HireDate in (
select HireDate 
from EmployeesTable
Group by HireDate
Having count(*) >1
)
--38. Find departments that have more than one employee.

select e.EmployeeID, d.DepartmentID, e.FirstName, e.LastName, d.DepartmentName
from EmployeesTable e
join Departments d 
on e.DepartmentID = d.DepartmentID
where d.DepartmentID in (
select e2.DepartmentID 
from EmployeesTable e2
group by e2.DepartmentID
having count(*) > 1
)


--39. Retrieve the names of employees who do not have a middle name (assuming a column `MiddleName` exists).




--40. Display the first name, last name, and total number of projects for each employee.

Select 
e.EmployeeID , 
e.FirstName, 
e.LastName , 
count(ep.ProjectID) as Total_Project
from EmployeesTable e 
join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on p.ProjectID = ep.ProjectID
group by e.EmployeeID , e.FirstName, e.LastName 

Select * from EmployeesTable
Select * from EmployeeProjects
Select * from Projects

--#### **Advanced SQL Queries**

--41. Retrieve employees who have received the highest salary in each department.

USE Tables_Overview

select e.EmployeeID, 
e.FirstName,
e.LastName,
e.Salary,
d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
where e.Salary > (select max(e2.Salary)
from EmployeesTable e2
where e.DepartmentID= e2.DepartmentID
)


--42. Find the number of employees who received a salary increase between two specific dates.

select count(*) as EmployeesWithIncrease
from EmployeesTable e
join Salaries s on e.EmployeeID = s.EmployeeID
where s.SalaryDate between '2018-11-12' and '2020-10-05'
and s.Amount > e.Salary

-- Find employees with a salary increase between two specific dates


select e.EmployeeID, e.FirstName, e.LastName, e.Salary
from EmployeesTable e
join Salaries s on e.EmployeeID = s.EmployeeID
where s.SalaryDate between '2018-11-12' and '2020-10-05'
and s.Amount>e.Salary




select * from EmployeesTable
select * from Departments
select * from EmployeeProjects
select * from Projects
select * from Salaries

--43. Get the employee details along with their current project (if any).

Select e.EmployeeID, e.FirstName, e.LastName, p.ProjectName
from EmployeesTable e
join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on ep.ProjectID = p.ProjectID
where p.EndDate is null or p.EndDate > getdate()


--44. List employees who received more than one salary on the same date.

select 
e.EmployeeID,
e.FirstName,
e.LastName,
s.SalaryDate,
count(*)
from EmployeesTable e
join Salaries s on e.EmployeeID = s.EmployeeID
Group by e.EmployeeID,e.FirstName,e.LastName,s.SalaryDate
Having count(*)>1




--45. Retrieve the total number of employees and the total salary per department.
select count(e.EmployeeID) as TotalEmployee,sum(e.Salary) as TotalSalary, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName


--46. Find the department with the least number of employees.

select top 1 count(e.EmployeeID) as LeastNumOfEmp, 
d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName 
order by LeastNumOfEmp;


WITH DeptCounts AS (
    SELECT 
        d.DepartmentName,
        COUNT(e.EmployeeID) AS NumOfEmployees
    FROM EmployeesTable e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
)
SELECT DepartmentName, NumOfEmployees
FROM DeptCounts
WHERE NumOfEmployees = (SELECT MIN(NumOfEmployees) FROM DeptCounts);


--47. List the project(s) with the longest duration.

with ProjectDurations as (
Select 
ProjectID, ProjectName,
DatedIff(day, StartDate, EndDate) as DurationDays
from 
Projects)
Select
ProjectID,
ProjectName,
DurationDays
from
ProjectDurations
where DurationDays = (
Select 
max(DurationDays)
from ProjectDurations)

--48. Retrieve employees who worked on the most projects.

with MostProjectEmployees as(
Select 
e.EmployeeID, e.FirstName, e.LastName, count(ep.ProjectID) as totalProject
from EmployeesTable e
join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
Group by e.EmployeeID, e.FirstName, e.LastName
)

select 
*
from
MostProjectEmployees
where totalProject = (
select max(totalProject) from MostProjectEmployees);


WITH ProjectCounts AS (
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        COUNT(ep.ProjectID) AS TotalProjects
    FROM EmployeesTable e
    JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
)
SELECT *
FROM ProjectCounts
WHERE TotalProjects = (
    SELECT MAX(TotalProjects) FROM ProjectCounts
);


--49. Find employees whose salary is above the company’s average salary.

With AboveEmpSalary as (
select 
EmployeeID,
FirstName,
LastName,
Salary
from 
EmployeesTable
)
select 
*
from
AboveEmpSalary
where Salary >(select avg(Salary)
from
AboveEmpSalary)

select 
EmployeeID,
FirstName,
LastName,
Salary
from EmployeesTable
where Salary > (Select
avg(Salary)
from EmployeesTable )

--50. List employees who do not have a project assigned using a `LEFT JOIN`.

select distinct e.EmployeeID, e.FirstName, e.LastName, p.ProjectName
from EmployeesTable e
left join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
left join Projects p on ep.ProjectID = p.ProjectID
where p.ProjectName is null



--51. Retrieve all projects that were completed in less than 65 days.

select 
ProjectName,
StartDate,
EndDate,
datediff(day, StartDate, EndDate) as NumberOfDays
from Projects
where DATEDIFF(day, StartDate, EndDate)< 65


--52. Find the employees who are not in any department (if possible).

Select e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName
from EmployeesTable e
left join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName is null 


--53. Display all projects that have no employees assigned.

select p.ProjectID, p.ProjectName 
from 
Projects p
left join EmployeeProjects ep on p.ProjectID = ep.ProjectID
where ep.EmployeeID is null


--54. List employees who have never worked on a project in the Finance department.

select e.EmployeeID, e.FirstName, e.LastName
from EmployeesTable e
left join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
where e.DepartmentID not in (
select DepartmentID 
from Departments d
where d.DepartmentName = 'Finance')
and ep.ProjectID is null

SELECT e.EmployeeID, e.FirstName, e.LastName
FROM EmployeesTable e
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
WHERE e.DepartmentID NOT IN (
    SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Finance'
)
AND ep.ProjectID IS NULL;






--55. Find the total salary per project.

Select sum(Salary) as TotalSalary , p.ProjectName
from EmployeesTable e
join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on ep.ProjectID = p.ProjectID
Group by p.ProjectName
order by p.ProjectName 


--56. Retrieve the name and salary of the employee who joined last.

select EmployeeID, FirstName, LastName, HireDate
from EmployeesTable
where HireDate = ( select 
max(HireDate) from EmployeesTable)


--57. List the projects that are currently active.

select *
from Projects
where EndDate is null


--58. Display the highest-paid employee in each department.

select e.DepartmentID,  e.FirstName, e.LastName, e.Salary, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
where e.Salary = (
select max(e2.Salary)
from EmployeesTable e2
where e.DepartmentID = e2.DepartmentID)

--59. Find the employee who worked on the most recent project.
select e.EmployeeID, e.FirstName, e.LastName, p.ProjectName, p.StartDate
from EmployeesTable e
join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on ep.ProjectID = p.ProjectID
where p.StartDate = (select max(StartDate)
from Projects)


--60. List employees who have the same first name as another employee.

select e.DepartmentID, e.FirstName
from EmployeesTable e
where e.FirstName = (
select FirstName
from EmployeesTable
group by FirstName
having count(*)>1)

--#### **Subqueries**

--61. Find employees whose salary is higher than the average salary of all employees.

select *, (select avg(Salary) 
from EmployeesTable) as avgSalary
from EmployeesTable
where Salary > ( select avg(Salary) as avgSalary
from EmployeesTable 
)


--62. List departments where the total salary exceeds $100,000.

select sum(e.Salary) as TotalSalay, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName
having sum(e.Salary) >100000

--63. Retrieve the employees who were hired in the same year as the highest-paid employee.

select * 
from EmployeesTable
     where Year(HireDate) in (select year(HireDate)
     from EmployeesTable
	      where Salary= (
		  select max(Salary)
		  from EmployeesTable)

)

--64. Get the employee(s) with the lowest salary in the IT department.

select e.DepartmentID,e.FirstName, e.LastName ,e.Salary, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
where e.Salary = (
select min(Salary)
from EmployeesTable
where DepartmentID = d.DepartmentID ) and
d.DepartmentName= 'IT'

--65. Find the projects that have at least one employee with a salary over $70,000.

select e.EmployeeID, e.FirstName, e.LastName, e.Salary, p.ProjectName
from EmployeesTable e
join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on ep.ProjectID = p.ProjectID
where e.Salary > 70000

--66. List the employees who are earning more than the average salary in their department.

select e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
where e.Salary > ( select avg(Salary)
                   from EmployeesTable
				   where DepartmentID = e.DepartmentID)

select min(Salary) from EmployeesTable


--67. Retrieve departments that have fewer than 3 employees.

select d.DepartmentName
from Departments d
join EmployeesTable e on e.DepartmentID = d.DepartmentID
Group by d.DepartmentName
having count(*) < 3

--68. Find employees whose salary is higher than the maximum salary in the HR department.
use Tables_Overview

select e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
where e.Salary > (select max(e2.Salary)
                   from EmployeesTable e2
				   join Departments d2 on e2.DepartmentID = d2.DepartmentID
				   where d2.DepartmentName = 'HR'
                   )



--69. List employees who have the highest salary in their respective departments.


select e.EmployeeID, e.FirstName, e.LastName, max(e.Salary) as maxSalary, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
Group by  e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName
 


select e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
where e.Salary = (Select max(Salary)
from EmployeesTable e2
join Departments d2 on e2.DepartmentID = d2.DepartmentID
where d2.DepartmentID= d.DepartmentID
)


--70. Get the projects where the earliest hire date of any employee involved is before 2020.

select p.ProjectName, min(et.HireDate) AS EarliestHireDate, et.FirstName
from Projects p
join EmployeeProjects ep on p.ProjectID = ep.ProjectID
join EmployeesTable et on ep.EmployeeID = et.EmployeeID
Group by p.ProjectName, et.FirstName
Having min(et.HireDate) < '2020-01-01'


--#### **Aggregate Functions**

--71. Calculate the total salary paid to all employees.

select sum(Salary) as totalSalary
from EmployeesTable
--72. Find the average salary of employees who joined after 2020.

select avg(Salary) as AvgSalary
from EmployeesTable 
where HireDate > '2020-12-31'
--73. Count the total number of projects completed before 2022.

select count(ProjectName) as TotalProject
from Projects 
where EndDate < '2022-12-31'

--74. Find the average salary of employees per project.

select avg(e.Salary) AvgSalary, p.ProjectName
from EmployeesTable e
join EmployeeProjects ep on e.EmployeeID= ep.EmployeeID
join Projects p on ep.ProjectID = p.ProjectID 
group by p.ProjectName


--75. Retrieve the total number of employees who have worked on more than two projects.
use Tables_Overview

With ProjectsCounts as (
select ep.EmployeeID, count(distinct ep.ProjectID) totalProjects
from EmployeeProjects ep
Group by ep.EmployeeID )
select count(*) as TotalEmp
from ProjectsCounts
where totalProjects >2

Select count(*) as TotalEmployees
from EmployeesTable e
where (
select count(distinct ep.ProjectID) as totalProject
from EmployeeProjects ep
where ep.EmployeeID = e.EmployeeID) > 2



Select * from EmployeesTable
Select * from EmployeeProjects
Select * from Salaries
Select * from Departments
Select * from Projects

--71.	Get the total number of departments and the average number of employees per department.
use Tables_Overview

With TotalNumDep as(
select e.DepartmentID , count(distinct e.EmployeeID) as TotalEmp
from EmployeesTable e
Group by e.DepartmentID)
Select count(*) as TotalDep, avg(TotalEmp) as AvgEmpPerDep
from TotalNumDep


--72.	Calculate the total salary paid to employees in each department.

select sum(e.Salary) as TotalSalary, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName

--73.	Find the department with the highest average salary.

select top 1 avg(e.Salary) as AvgHighestSal, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName
Order by AvgHighestSal Desc

--74.	Retrieve the total number of projects and the average duration per project.
Select count(Distinct ep.ProjectID) as TotalProject, avg(DATEDIFF(Day, StartDate, EndDate)) as AvgDurationInDays
from EmployeeProjects ep
join Projects p on ep.ProjectID = p.ProjectID


select count(ProjectID) as TotalProject, avg(DATEDIFF(DAY, StartDate, EndDate)) as AvgDurInHours
from Projects

--75.	Get the total amount paid to employees in 2023.

Select sum(Salary) as TotalAmount 
from EmployeesTable
where HireDate = '2023'


--Joins and Relationships
--81.	List all employees along with their department name using INNER JOIN.

select e.*, d.DepartmentName
from EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID

--82.	Retrieve all employees along with their project names using a JOIN.

select e.*, p.ProjectName
from EmployeesTable e
join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on ep.ProjectID = p.ProjectID


--83.	Find employees who have not been assigned to any project using a LEFT JOIN.

select e.*, p.ProjectName
from EmployeesTable e
left join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
left join Projects p on ep.ProjectID = p.ProjectID
where p.ProjectName is null


--84.	Get the department name and the total salary of employees in each department.

select sum(e.Salary) , d.DepartmentName
from  EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
Group by d.DepartmentName
Order by d.DepartmentName Asc

--85.	Retrieve the names of employees working on the "Website Redesign" project using a JOIN.

select e.FirstName , e.LastName, p.ProjectName
from  EmployeesTable e
join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
join Projects p on ep.ProjectID = p.ProjectID
where p.ProjectName = 'Website Redesign'

select * from Projects

--86.	List all employees and their projects using a RIGHT JOIN.

select e.FirstName, e.LastName, p.ProjectName
from  EmployeesTable e
right join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
right join Projects p on ep.ProjectID = p.ProjectID

--87.	Find the department name for each employee using a JOIN.

select e.FirstName, e.LastName, d.DepartmentName
from  EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID

--88.	List employees who are not assigned to any department using a RIGHT JOIN.

select e.FirstName, e.LastName, d.DepartmentName
from  EmployeesTable e
right join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName is null

--89.	Get the total salary per department using a GROUP BY and JOIN.

select sum(e.Salary) as TotalSalary, d.DepartmentName
from  EmployeesTable e
join Departments d on e.DepartmentID = d.DepartmentID
Group by d.DepartmentName


--90.	Retrieve employees who have never been assigned a project using a FULL OUTER JOIN.

select e.FirstName, e.LastName, p.ProjectName
from  EmployeesTable e
full outer join EmployeeProjects ep on e.EmployeeID = ep.EmployeeID
full outer join Projects p on ep.ProjectID = p.ProjectID
where p.ProjectName is null



--Date Functions
--91.	Retrieve the names of employees who were hired in the last year.

select * from EmployeesTable
where HireDate >= DATEADD(YEAR,-1, GETDATE())

--92.	Find the total number of employees hired each month in 2022.
select year(HireDate) as HireYear, month(HireDate) as HireMonth, count(*) as totalEmp
from EmployeesTable
where year(HireDate) = 2020
Group by year(HireDate), month(HireDate) 
Order by month(HireDate) 


--93.	List employees who were hired on a Monday.
use Tables_Overview

select *, Datename(WEEKDAY,HireDate) as DaysName from EmployeesTable 
where Datename(WEEKDAY,HireDate)  = 'Monday'

--94.	Get the employees who have been with the company for more than 3 years.

select *, Datediff(Year,HireDate, GETDATE()) as YearsWithCom from EmployeesTable 
where Datediff(Year,HireDate, GETDATE()) >3

--95.	Retrieve employees who were hired in the first quarter of 2021.
select * from EmployeesTable 
where year(HireDate) = 2021 and month(HireDate) between 1 and 3

--96.	Find the employees who joined within the last 30 days.

select * from EmployeesTable
where HireDate >= DATEADD(Day,-30, GETDATE())

--97.	List employees who have a hire date in the first 10 days of any month.

select * from EmployeesTable
where day(HireDate) between 1 and 10

--98.	Retrieve the number of employees hired in each year since 2019.

select count(*) as NumEmp, year(HireDate) as HireYears
from EmployeesTable
where year(HireDate) between 2019 and 2025
Group by year(HireDate)
Order by HireYears


--99.	Find employees who were hired exactly 2 years ago.

select * 
from EmployeesTable
where DatedIff(year, HireDate, GETDATE()) =2

select * 
from EmployeesTable
where HireDate= Dateadd(year,-2, GETDATE())

--100.	Get the list of projects that started within the last 6 months.

select * 
from Projects
where StartDate >= DATEADD(month,-6, GETDATE())
