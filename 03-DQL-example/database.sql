-- Works for 'classic models' database 

-- Show all employees 
select * from employees; 
-- The '*' means all the column 

-- How do I select first name / last name / email from all employees
select firstName, lastName, email from employees; 

-- You can rename the results when it comes up 
select firstName as "First Name", lastName as "last Name", email as "Email" from employees; 

-- Only selecting certain rows
-- Get all employees with office code 1
select * from employees where officeCode=1;
-- There is only a single "="

-- Just show the first name / last name / email of employees from office code 1
select firstName, lastName, email, officeCode from employees where officeCode=1; 

-- Select customer name / contact last name / contact first name from USA
select customerName, contactLastName, contactFirstName, country from customers where country='USA';

-- String matching within the database
SELECT * FROM employees where jobTitle like 'Sales Rep'; 
-- The string for Sales Rep is case insensitive

-- Select al employees where the jobTitle is "<anything>sales"
SELECT * FROM employees where jobTitle like '%Sales'; 
-- The 'space' is also accounted for in the "%" sign 

-- Select al employees where the jobTitle is "sales<anything>"
SELECT * FROM employees where jobTitle like 'Sales%'; 

-- Select al employees where the jobTitle is "<anything>sales<anything>"
SELECT * FROM employees where jobTitle like '%Sales%'; 

-- Find all orders which mentioned the word shipping in the comments and display their order
-- number status and comments
SELECT orderNumber, status, comments from orders where comments like '%shipping%' and status = "disputed";

-- Get employees from officeCode 1 or 2
SELECT firstName, lastName FROM employees where officeCode = 1 or officeCode = 2; 

-- Get sales rep from office code 1 or 2
SELECT * FROM employees where jobTitle like 'sales rep' and (officeCode = 1 or officeCode = 2);

-- Show all customers from USA in the state of NV which credit limit is more than 5000 
SELECT * FROM customers where state="NV" and country ="USA" and creditLimit >5000;

-- Show all customers from singapore or USA and also have less than 10k credit limit
SELECT * FROM customers where (country="singapore" or country ="USA") and creditLimit <10000;

-- Selecting from 2 tables 
SELECT firstName,
         lastName,
         addressLine1,
         addressLine2
FROM employees
JOIN offices
    ON employees.officeCode = offices.officeCode; 

-- For each customer, we want to know the customer name and the first name, 
-- last name and email of the corresponding sales rep
SELECT customerName,
         firstName,
         lastName,
         email
FROM customers
JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber;

-- When you join 2 tables and there are columns with the same name
-- You select the column that you want by putting 
-- the <name of table>.<name of column> to be more specific
SELECT customerName,
         firstName as "Sales Rep First Name",
         lastName as "Sales Rep Last Name",
         email as "Email"
FROM customers
JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber;

-- There are 3 kinds of JOIN
-- INNER JOIN - standard: Only included in the result if there is a 
-- matching row on the other table 
-- LEFT OUTER JOIN - All rows on the lefthand side will be included
-- RIGHT JOIN - All rows on the righthand side will be included 

-- When you are joining the tables - Usually the smaller table will come first 

-- All customers will be included regardless if they have a sales rep
SELECT customerName,
         firstName as "Sales Rep First Name",
         lastName as "Sales Rep Last Name",
         email as "Email"
FROM customers
LEFT JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber;

-- There is a order to the functions - 
-- 'join' will go first followed by 
-- 'where'
-- 'select'  
SELECT customerName,
         firstName as "Sales Rep First Name",
         lastName as "Sales Rep Last Name",
         email as "Email"
FROM customers
LEFT JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber
    where country = "USA"; 

-- Get the current date
select curdate(); 

-- ISO Standard YYYY-MM-DD
-- Get all payments after 30 June 2003 
SELECT * FROM payments where paymentDate >"2003-06-30";

-- Get all payments from a specific date range 
SELECT * FROM payments where paymentDate between "2003-01-01" and "2003-06-30";

-- Getting only the year / month / day compenent in the date
select year("2003-06-30")
select month("2003-06-30")
select day("2003-06-30")

-- Get all payments made in june 2003
select * from payments where paymentDate where year (paymentDate) = "2003" and month (paymentDate) = "6"

-- Aggregation 
-- We want to summarise the entire table 

-- When you want to count the number of rows in the table 
select count(*) employees; 

-- Calculating the average amount of payments 
SELECT avg(amount)
FROM payments;

-- Show only unique values with Distinct 
select distinct (officeCode) from offices; 

-- Showing group by 
select count(*), officeCode from employees
group by officeCode; 
-- Group by happens after the 'where' 
-- Group by will happen where the employees of the office code and then the count will happen

-- For each office, show their state and country and how many employees there are
select count(*), employees.officeCode, country, state from employees
join offices
on employees.officeCode = offices.officeCode
group by officeCode, country, state 

-- Show the average credit limit of each country
-- 1. which table will give us the information that we want? 
-- 2. what do we want to group by 
-- 3. select ??? from <table name> group by <criteria to group by>
-- 4. what do I wan from each group : MIN, MAX, SUM, COUNT, AVG
-- 5. whatever I group by, I need to selct (vice versa) except the aggregation
select avg(creditLimit), country from customers 
group by country; 

-- We only want countries where the credit limit is more than 10,000
select avg(creditLimit), country from customers 
group by country
having avg(creditLimit) >10000; 

-- When we dont want to include customers where the credit limit is 0
-- before the groupings
select avg(creditLimit), country from customers 
where creditLimit !=0 
group by country
having avg(creditLimit) >10000; 

-- Find the total sales made by each sales person in the year 2003
select sum(amount), employeeNumber, firstName, LastName from payments 
join customers 
on payments.customerNumber = customers.customerNumber
join employees
on customers.salesRepEmployeeNumber = employees.employeeNumber
group by employeeNumber; 

-- We want to sort so the highest grossing salesperson is at the top limit to the top 3
select sum(amount), employeeNumber, firstName, LastName from payments 
join customers 
on payments.customerNumber = customers.customerNumber
join employees
on customers.salesRepEmployeeNumber = employees.employeeNumber
group by employeeNumber
order by sum(amount) desc 
limit 3; 

-- We want to order the table based on a requirement 
select * from customers order by creditLimit; 

-- Change the direction of the sort 
select * from customers order by creditLimit DESC;

-- We want to sort so the highest grossing salesperson is at the top limit 
-- to the top 3 not from USA and amount is more than 600000
select sum(amount), country, employeeNumber, firstName, LastName from payments 
join customers 
on payments.customerNumber = customers.customerNumber
join employees
on customers.salesRepEmployeeNumber = employees.employeeNumber
where customers.country !="USA"
group by employeeNumber, country, firstName, lastName
having sum(amount) >600000
order by sum(amount) desc 
limit 3; 


-- Show all customers where credit limit is aboe the average credit limit
select * from customers where creditLimit >(
    select avg(creditLimit) from customers
); 










