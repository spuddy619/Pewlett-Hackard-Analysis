--------------------------------------------- Deliverable 1
DROP TABLE title_fdate_tdate
DROP TABLE unique_titles
DROP TABLE unique_titles_export

--1.) Retrieve emp_no, first_name, last_name from employees table
SELECT emp_no,
	first_name,
	last_name
FROM employees;

--2.) Retrieve title, from_date, to_date
SELECT title, 
	from_date,
	to_date
FROM titles;

--3-4.) Create new table from employees and title
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	tit.title,
	tit.from_date,
	tit.to_date,
	e.birth_date
INTO employees_titles
FROM employees AS e
FULL JOIN titles AS tit
ON e.emp_no = tit.emp_no;

--5.) Filter this new table on birth_date column to retrieve emps. born between 1952 and 1955
	-- then ORDER BY emp_no
SELECT *
FROM employees_titles
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no ;

--6-7.) Export this new table as retirement_titles.csv (but omit column "birth_date")
SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date
INTO retirement_titles_export
FROM employees_titles
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no ;

--8.)
    -- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
ORDER BY _____, _____ DESC;

--9.) Retrieve from the retirement_titles to set up table that will hold the most recent title for each employee:
	--emp_no
	--first_name
	--last_name
	--title
	--NOTE: these are emps who are about to retire: their info and title
SELECT emp_no,
	first_name,
	last_name,
	title
FROM retirement_titles;

--10-11.) Use DISTINCT ON() statement to retrieve the 1st occurrence of the emp. number
	--The problem is that it picks the wrong duplicate - picks the 
	--I gotta Double Check this one - What was wrong with my first attempt?

SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title,
	to_date
INTO unique_titles 
FROM retirement_titles 
ORDER BY emp_no, to_date DESC;

--12.) Sort unique_titles in ascending order by emp_no and desc. order by to_date
SELECT *
FROM unique_titles
ORDER BY emp_no ASC, to_date DESC;

--13.) Export unique_titles table as unique_titles.csv 
	--omit the columns to match module challenge image 
SELECT emp_no,
	first_name,
	last_name,
	title
INTO unique_titles_export
FROM unique_titles;

--15.) Write query in Employee_Database_challenge.sql that:
	--retrieves # of employees by their most recent job title a
		--from unique_titles

--16-18.) Create Retiring Table to hold required information (retiring_titles.csv)
SELECT COUNT(title),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

--19-20.) Export retiring_titles

	
--------------------------------------Deliverable 2
--1.)Retrieve emp_no, first_name, last_name, birth_date from "employees"
SELECT emp_no,
	first_name,
	last_name,
	birth_date
FROM employees;
--2.) Retrieve from_date, to_date columns from dept_emp 
SELECT from_date,
	to_date
FROM dept_emp
--3. Retrieve title from "titles" table
SELECT title
FROM titles
--4.) Use DISTINCT ON to retrieve 1st occurrence of emp_no for each set of rows defined by ON()
SELECT DISTINCT ON(emp_no) *
FROM titles



--5-6.) Join employees and dept_emp table and create that as a new table
SELECT e.emp_no,
	e.birth_date,
	e.first_name,
	e.last_name,
	e.gender,
	e.hire_date,
	de.dept_no,
	de.from_date,
	de.to_date
	
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no

	

--7.) join employees and titles 
SELECT e.emp_no,
	e.birth_date,
	e.first_name,
	e.last_name,
	e.gender,
	e.hire_date,
	tit.title,
	tit.from_date,
	tit.to_date
	
FROM employees AS e
JOIN titles AS tit
ON e.emp_no = tit.emp_no

--8-9.)Filter data on to_date column to all the current employees
--then filter the data on birth_date to get all the employees whose birthdates
--are BETWEEN 1965-01-01 and 1965-12-31
	
SELECT e.emp_no, 
	e.first_name,
	e.last_name,
	e.birth_date,
	tit.from_date,
	tit.to_date,
	tit.title
INTO mentorship_eligibility	
FROM employees AS e
JOIN titles AS tit
ON e.emp_no = tit.emp_no
WHERE to_date = '9999-01-01' AND birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no

--10. Export step 8-9 as mentorship_eligibility.csv
--11. Confirm image 

