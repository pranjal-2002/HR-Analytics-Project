create table hrdata
(
	emp_no int8 PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar(50),
	age int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int8,
	active_employee int8
)

select * from hrdata

-- Employee count
select sum(employee_count) from hrdata

select sum(employee_count) from hrdata
where education='High School'

-- Attrition count
select count(attrition) from hrdata
where attrition='Yes'

select count(attrition) from hrdata
where attrition='Yes' and department='Sales'

-- attrition Rate
select round((select count(attrition) from hrdata
where attrition='Yes')/ sum(employee_count)*100,2) from hrdata

-- Active Employee
select sum(employee_count)-(select count(attrition) from hrdata
where attrition='Yes') from hrdata

select sum(employee_count)-(select count(attrition) from hrdata
where attrition='Yes' and department='Sales') from hrdata 
where department='Sales'

-- Avg age
select round(avg(age)) from hrdata

-- Attrition by genders
select gender,count(attrition) from hrdata
where attrition='Yes'
group by gender

-- Department wise attrition
select department,count(attrition) from hrdata
where attrition='Yes'
group by department

-- No of employee by age Group
select age, sum(employee_count) from hrdata
group by age
order by age

select age, sum(employee_count) from hrdata
where department='R&D'
group by age
order by age

select age_band, gender, sum(employee_count) from hrdata
group by age_band, gender
order by age_band, gender

-- Job satisfaction rating
create extension if not exists tablefunc

select * from crosstab(
'select job_role, job_satisfaction, sum(employee_count) from hrdata
group by job_role, job_satisfaction
order by job_role, job_satisfaction'
) as ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
order by job_role

-- Education field wise attrition
select education_field, count(attrition)
from hrdata where attrition='Yes'
group by education_field
order by count(attrition) desc

-- attrition rate by gender for different age group
select age_band, gender, count(attrition) from hrdata
where attrition='Yes' 
group by age_band, gender
order by age_band, gender


-- alternate method to import data from csv file--
-- COPY hrdata from "C:\Users\HP\Desktop\Data Analyst\project\hrdata.csv" delimiter ','  CSV HEADER;
