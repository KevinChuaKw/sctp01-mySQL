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

