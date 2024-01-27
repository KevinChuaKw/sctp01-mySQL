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



-- 6 - Show the name of the product, 
-- together with the order details,  for each order 
-- line from the orderdetails table



-- 7 - Display sum of all the payments made by each company from the USA. 



-- 8 - Display all orders made by customers from the USA and UK



-- 9 - Show how many employees are there for each state in the USA		



-- 10 - Display the number of orders made, per month, between Jan 2003 and Dec 2003



-- 11 - From the payments table, display the average amount spent by each customer. Display the name of the customer as well.



-- 12  - How many products are there in each product line?



-- 13 - From the payments table, display the average amount spent by each customer but only if the customer has spent a minimum of average 10,000 dollars.



-- 14  - For each product, display how many times it was ordered, and display the results with the most orders first and only show the top ten.


