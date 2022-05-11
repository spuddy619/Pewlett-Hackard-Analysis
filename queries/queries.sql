SELECT *
FROM departments; 

--DROP TABLE 
----------------------------

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31
-----------------------------

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
---------------------------- 7.3.1 
-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

----------------------------- 7.3.1
-- Number of employees retiring
SELECT COUNT(first_name)    --> this line counts the numbers of rows in the "first_name" column
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
----------------------------- 7.3.1
SELECT first_name, last_name
INTO retirement_info    --> this line tells Postgres to save the data into a table named "retirement_info" / jelpful for exporting
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT *
FROM retirement_info;

------------------------------ 7.3.2 
-- We desire a table join to depict a list of retiring employees but broken down into apartments 
-- join the "Employees" with "dept_emp"
-- We wanna drop the current "retirement_info" table, and then make its replacement - now it includes column "emp_no" 

DROP TABLE retirement_info; 

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM Employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT *
FROM retirement_info;
--now we are ready to join this with "dept_emp" table

----------------------------- 7.3.3
-- create query for: department name(Departments table) and 
					-- employee numbers (dept_manager table)
					--from and  to dates (dept_manager table)
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM Departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no; -- the column that the 2 tables share
					
----------------------------- 7.3.3
-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri ----> This is the LEFT table 
LEFT JOIN dept_emp as de------> this also denotes the RIGHT table
ON ri.emp_no = de.emp_no;
-------------------------- 7.3.3 
--creates a new table containing only CURRENT employees eligible for retirement
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT *
FROM current_emp

-----------------------7.3.4
--In Postgres, GROUP BY is used when we want to group rows of identical data together in a table
--Join the "current_emp" and "dept_emp" tables

SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no

---------------------- 7.3.4 Skill Drill - Export previous block as a csv

SELECT COUNT(ce.emp_no), de.dept_no
INTO retirement_info_departments
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no

-------------------------7.3.5 - we want more lists >:)
--List 1: Employee Information - general employee information but with current salaries included
	

SELECT emp_no,   ------> From table "employees" we filter for just these columns and filters (retirement eligibility)
    first_name,
	last_name,
    gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Now we must join "emp_info" with the "salaries" table to add the "to_date" and salary columns to the query
--INGREDIENTS: "emp_info", "salaries", dept_emp(?)
---I dont really get this - i am not sure what information we want from these tables
	- and how joins work - why is it inner join? that is a table of just things they share right?
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
--INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON(e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');
	
-------------------------7.3.5 (list 2: management)
--we want: 
		--emp_no,      
		--first_name, 
		--last_name, 
		--from_date, 
		--to_date
--Tables: departments(why this one?), dept_manager, employees
		--dept_manager.emp_no
		--dept_manager.from_date
		--dept_manager.to_date
		--employees.first_name  --> get this via emp_no
		--employees.last_name  --> get this via emp_no
--List of managers per department
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
--INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);



SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

--------------------------7.3.6 Skill Drill 
--Create list that contains employees from "retirement_info" for only Sales Department
	-- Join retirement_info with dept_emp
	--From that result, join it with "departments"
	--Columns for final query:
		--emp_no (retirement_info)
		--first_name (retirement_info)
		--last_name (retirement_info)
		--dept_name (departments)
			--we will get here via dept_emp (based on dept_no)
	--The Tables for the Triple Join:
		--retirement_info --> ri
		--dept_emp --> de
		--departments --> d

SELECT ri.emp_no, 
	ri.first_name,
	ri.last_name,
	d.dept_name
--INTO tablename
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de ON de.emp_no = ri.emp_no
LEFT JOIN departments AS d ON d.dept_no = de.dept_no
WHERE d.dept_name='Sales'; 


-------------------------------7.3.6 Skill Drill
--Create query that will return the following for the Sales and Development teams
	-emp_no
	-first_name
	-last_name
	-dept_name 

SELECT ri.emp_no, 
	ri.first_name,
	ri.last_name,
	d.dept_name
--INTO tablename
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de ON de.emp_no = ri.emp_no
LEFT JOIN departments AS d ON d.dept_no = de.dept_no
WHERE d.dept_name in ('Sales', 'Development');

