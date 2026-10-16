/*
select *
from EmployeeDemographics;

select top 5*
from EmployeeDemographics;

select distinct(Gender)
from EmployeeDemographics;

select distinct(Age)
from EmployeeDemographics;

select max(Age)
from EmployeeDemographics;

select min(Age)
from EmployeeDemographics;

select avg(Age)
from EmployeeDemographics;

--where statements:
select *
from EmployeeDemographics
where gender = 'male';

select *
from EmployeeDemographics
where gender <> 'male';

select *
from EmployeeDemographics
where age>=35;

select*
from EmployeeSalary
where Salary<=35000;

select*
from EmployeeDemographics
where gender='male' and age>40;

select*
from EmployeeDemographics
where gender='female' or age>40;

select*
from EmployeeDemographics
where Firstname like '%a';

select*
from EmployeeDemographics
where Firstname like 'a%';

select*
from EmployeeDemographics
where Firstname like '%a%';

select*
from EmployeeDemographics
where LastName is not null;

select*
from EmployeeSalary
where EmployeeID in (1001, 1002, 1005)

--group by and order by statements:
select gender
from EmployeeDemographics
group by gender;

select gender, count(gender) as NoofMalesandFemales
from EmployeeDemographics
group by gender;

select* 
from EmployeeDemographics
order by firstname desc;

select *
from EmployeeDemographics
order by 1 desc;

--join statements:(to add multiples tables)
select*
from EmployeeDemographics
inner join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

select*
from EmployeeDemographics
full outer join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

select*
from EmployeeDemographics
left outer join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

select*
from EmployeeDemographics
right outer join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--union statements:(to add tables with same no. of columns)
select*
from EmployeeDemographics
union
select*
from Warehouseemployeedemographics;

--case statements: using when and else statements, adds column
select*,
case
 when age>=35 then 'old'
 else 'young'
end as oldoryoung
from EmployeeDemographics;

select EmployeeDemographics.EmployeeID, firstname, age, gender, jobtitle, salary,
case
 when gender='female' then salary+(salary*0.10)
 when gender='male' then salary+(salary*0.08)
end as NewSalary
from EmployeeDemographics
join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--having clause: (where clause cannot be used with aggregate
--functions like count() & avg() therefore we use having clause) 
--having clause always used after group by
select jobtitle, avg(salary)
from EmployeeDemographics
join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
group by jobtitle
having avg(salary)>35000;

--updating and deleting data in a table
update EmployeeDemographics
set LastName='scott', age=36
where Firstname='holly'
select *
from EmployeeDemographics;

--once data deleted, it cannot be recovered.
delete
from EmployeeDemographics
where EmployeeID=1007
select *
from EmployeeDemographics

--Aliasing:temporary changing or creating column names
select firstname+' '+LastName as fullname
from EmployeeDemographics

--Aliasing table names: naming tables as demo and sal makes
--it easier to join and select wihout confusion.
select demo.employeeid, sal.salary
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID;

--partition by: acts like group by but doesn't collapse the rows
select gender, count(gender) as totalgenders
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
group by Gender;

select firstname, LastName, Gender, Salary
,count(gender) over (partition by gender) as totalgender
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID;

--CTEs(common table expressions):temporary table that exists
--only for that query. the table is not saved like EmploDemo
with cte as(
select firstname,age, gender, salary
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
where Salary>40000 and age<40
)
select *
from cte

--Temp tables:can be used multiple times unlike CTEs
--use # sign after create table to make it temp
create table #temptable
(employeeID int,
Jobtitle varchar(50),
salary int);

insert into #temptable
select*
from EmployeeSalary
select*
from #temptable;

drop table if exists #temptable2
create table #temptable2(
jobtitle varchar(50),
employeesperjob int,
avgage int,
avgsalary int)

insert into #temptable2
select jobtitle, count(jobtitle), avg(age), avg(salary)
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
group by Jobtitle
select *
from #temptable2;

--String functions:TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER, LOWER
create table EmployeeErrors
(EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50)
);
insert into EmployeeErrors values
('  1001', 'jimbo', 'halbert'),
('1002  ', 'pamela', 'beasely'),
('1003', 'toby', 'flenderson-fired');
select*
from EmployeeErrors;

--trim: gets rid of blank spaces in both start/end
select employeeid, trim(employeeid) as correctedIDs
from EmployeeErrors

--LTRIM: only gets rid of blank spaces on start or left
select employeeid, ltrim(employeeid) as correctedIDsL
from EmployeeErrors

--RTRIM: only gets rid of blank spaces on end or right
select employeeid, rtrim(employeeid) as correctedIDsR
from EmployeeErrors

--Replace: to replace data in a column. Doesn't permanently
--update in the table
select lastname,
replace(lastname, '-fired', '') as lastnameFixed
from Employeeerrors;

--Substring:to take only a specific part of a string
--it's syntax (column, start_position, length)
select substring(err.firstname, 1, 3), substring(demo.firstname, 1, 3)
from Employeeerrors as err
join EmployeeDemographics as demo
on substring(err.firstname, 1, 3) = substring(demo.firstname, 1, 3)

--Upper/lower: converts text to uppercase/lowercase resp.
select upper(firstname)
from employeeerrors

select lower(firstname)
from employeeerrors

--stored procedures: once a query is saved it can be used again
create procedure test
as
select *
from EmployeeDemographics;
exec test

--stored procedure with parameters can take input values
create procedure temp_employees
as
create table #temp_employees(
Jobtitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

insert into #temp_employees
select jobtitle, count(jobtitle), avg(age), avg(salary)
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
group by Jobtitle;

select*
from #temp_employees;

exec temp_employees @jobtitle = 'salesman';

--Subqueries: a query within a query
--subquery in select:
select employeeid, salary, (select avg(salary) from EmployeeSalary) as AllAvgSalary
from EmployeeSalary;

--subquery in from:
select a.employeeid, AllAvgSalary
from (select employeeid, salary, avg(salary) over () as AllAvgSalary
 from EmployeeSalary) as a;

--subquery in where:
select employeeid, jobtitle, salary
from EmployeeSalary
where employeeid in (select employeeid
  from EmployeeDemographics
  where age>30);

