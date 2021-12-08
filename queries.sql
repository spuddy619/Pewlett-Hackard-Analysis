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

