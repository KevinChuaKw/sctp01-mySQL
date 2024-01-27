-- 1 - Find all the offices and display 
-- only their city, phone and country
SELECT city,
         phone,
         country
FROM offices;

-- 2 - Find all rows in the orders table 
-- that mentions FedEx in the comments.
SELECT *
FROM orders
WHERE comments LIKE "%fedex%"; 

-- 3 - Show the contact first name and contact 
-- last name of all customers in descending 
-- order by the customer's name
SELECT contactFirstName,
         contactLastName, 
		 customerName
FROM customers
ORDER BY  customerName desc; 


-- 4 - Find all sales rep who are in office 
-- code 1, 2 or 3 and their first name or last name 
-- contains the substring 'son'
SELECT firstName,
         lastName,
         jobTitle
FROM employees
WHERE officeCode IN (1,2,3)
        AND jobTitle = "sales rep"
        AND (firstName LIKE "%son%"
        OR lastName LIKE "%son%");


-- 5 - Display all the orders bought by the 
-- customer with the customer number 124, along 
-- with the customer name, the contact's 
-- first name and contact's last name.
SELECT *
FROM customers
JOIN orders
    ON customers.customerNumber = orders.customerNumber
WHERE customers.customerNumber = 124;

-- 6 - Show the name of the product, 
-- together with the order details,  for each order 
-- line from the orderdetails table



-- 7 - Display sum of all the payments made by each 
-- company from the USA. 
SELECT sum(amount),
         country
FROM payments
JOIN customers
    ON payments.customerNumber = customers.customerNumber
WHERE country = 'usa'
GROUP BY  customers.country;


-- 8 - Display all orders made by customers from the 
-- USA and UK



-- 9 - Show how many employees are there for each state 
-- in the USA		



-- 10 - Display the number of orders made, per month, 
-- between Jan 2003 and Dec 2003



-- 11 - From the payments table, display the average amount spent by each customer. Display the name of the customer as well.



-- 12  - How many products are there in each product line?



-- 13 - From the payments table, display the average amount spent by each customer but only if the customer has spent a minimum of average 10,000 dollars.



-- 14  - For each product, display how many times it was ordered, and display the results with the most orders first and only show the top ten.



-- Lab 4.1B

-- Which employees have a phone extension that ends with "11"?
-- What are the names, contact first name and contact last name of all customers in France?
-- Which products have a product code that starts with the letter "S" and also have a list price greater than 80.00?
-- What are the names and emails of all employees who work in the New York Office?
-- What are the names and phone numbers of all employees who work in offices located outside of the United States?
-- What are the first name and last names of all employees hired before 1st Jan 2003?
-- Display all orders which shipped later than their required date
-- Show all orders with a status of "Cancelled" that were placed before December 31, 2004?
-- Which product has a product line of "Motorcycles" and has a quantity in stock less than 10?
-- What are the names and emails of all customers who have placed an order that has "car" in the product name?
-- Display the average credit limit and number of customers for each country, only for countries more than 5 customers
-- Display the total number of orders placed per month, along with the month and year
-- Display the total amount of sales (in terms of revenue earned) of each order, along with the order date and customer name
-- Display the total number of orders, total sales amount and average sales aount per product line
