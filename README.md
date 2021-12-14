# Pewlett-Hackard-Analysis

## Background
We have been assigned two tasks: 1.) determine the number of retiring employees per title, and 2.) identify employees who are eligible to participate in a mentorship program. The purpose of these tasks is to prepare for the impending retirement of current employees around retirement age; the vacuum created by the departure of these employees will cause significant problems if we do not plan for this “silver tsunami.”

## Results

### 1.) Finding the Number of Retiring Employees by Title
* We created a table to store employees with their corresponding titles that are projected to be retiring soon. For this endeavor the company had defined employees about to retire as those who were born between January 1, 1952 and December 31, 1955. It is important to note that some employees had multiple titles due to promotions and consequently had duplicate entries in the tables. We filtered these out to leave just the most recent titles for each employee. We filtered those out and came to our final product: a table that has the number of retirement-age employees by their most recent job title. 
* We first joined the “employees” table (containing emp_no, birth_date, first_name, last_name, gender, hire_date) and the “titles table (containing emp_no, title, from_date, to_date) on emp_no. The two tables are shown below, respectively.

![image](https://user-images.githubusercontent.com/72320203/145906671-33fa4c83-8806-4a63-bb1e-7844c4b8ddca.png)

![image](https://user-images.githubusercontent.com/72320203/145906909-be920985-712e-42ab-90f5-db0a55e78263.png)

*Then we filtered that table based on the birth_date so we can get employees of retirement age and then filtered for their most recent title to take out duplicate employee entries. Following this step, we counted the number of each title to find how many employees were closing in on retirement in each title. The following image is the final product:

![image](https://user-images.githubusercontent.com/72320203/145908228-1b7dcb69-6eeb-4dfd-90d3-b2e43c8ccf1f.png)

### 2.) Identifying Employees Eligible for the Mentorship Program
* We created a table by joining the “employees” table and the “titles” tables, leaving us with the “mentorship_eligibility” table. 
* The company has defined employees eligible for the mentorship program as those born between January 1,1965 and December 31, 1965.
* Duplicate entries due to multiple titles were addressed with the DISTINCT ON clause.
* Below is the final product: a table with retirement-eligible employees who would be a good fit for the mentorship program.

![image](https://user-images.githubusercontent.com/72320203/145911879-3f2f9bd9-50fa-4097-bfd2-d3205c916421.png)

## Summary
### Question 1: How many roles will need to be filled as the “silver tsunami” begins to make an impact?
* There are 29,415 senior engineers retiring, 28,255 senior staff retiring, 14,221 engineers retiring, 12,242 staff retiring, 4,502 technique leaders retiring, 1761 assistant engineers retiring and 2 managers retiring. This means PH is losing 90,398 employees.
* It would be helpful to have tables that can output the exact totals of each title. This would facilitate the calculations of percentages for titles that have duplicates due to promotion and such.

### Question 2: Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of PH employees?
* We believe that the metric for calculating this would be to determine the percentage of their respective workforce the numbers from the “mentorship_eligibility” table occupy. Currently, this is difficult to determine as there are inconsistent records of total numbers of each title. The data that we do have is populated with many duplicates and does not take promotions and more into consideration. Further research could help us determine these totals and find the ratio between each title population and the number of mentorship-eligible employees. These ratios can then be analyzed to determine if those numbers are adequate enough for mentoring the next generation of PH employees.








	


