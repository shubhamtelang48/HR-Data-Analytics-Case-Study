


create table hrdata
(
	emp_no int PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar(50),
	age int,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int,
	active_employee int
)

select * from hrdata

-- import the file

BULK INSERT dbo.hrdata
FROM "C:\Users\dell\Downloads\hrdata.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)

select * from hrdata

-- Employees Count

select sum(employee_count) as employee_count from hrdata
--- 1470

--Attrition Count

select count(attrition) as attrition_count from hrdata
where attrition='Yes'
---- 237

select round(((select count(attrition) from hrdata where attrition='Yes')/(select sum(employee_count) from hrdata))*100,2) from hrdata


-- Active Employee
select sum(employee_count)-(select count(attrition) from hrdata where attrition='yes') from hrdata 

-- Attrition By Gender

select gender,count(attrition) as attrition_count from hrdata 
where attrition = 'Yes'
group by gender
order by attrition_count DESC

---- Male=150
---- Female=87

--Average Age

select round(avg(age),0) from hrdata
------ 36

-- No. of employee per age group

select age,sum(employee_count) as employee_count from hrdata
group by age
order by age

select department,count(attrition),round((cast(count(attrition) as numeric)/(select gender,count(attrition) as attrition_count from hrdata where attrition = 'Yes'))*100,2) 
as pct from hrdata
where attrition = 'Yes'
group by department


-- Education Field wise Attrition:
select education_field, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by education_field
order by count(attrition) desc;


-- Attrition Rate by Gender for different Age Group
select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes')) * 100,2) as pct
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender desc;


