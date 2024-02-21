-- Creating the database
create database watch_shop 

-- Creating watch table 
create table watch (
    watch_id int unsigned auto_increment primary key,
    brand VARCHAR(45) not null,
    model VARCHAR(45) not null,
    state_of_watch VARCHAR(45) not null, 
    price int not null,
    date_of_watch date not null
) engine = innodb;


-- Creating customers table
create table customers (
    customer_id int unsigned auto_increment PRIMARY key,
    first_name VARCHAR(45) not null,
    last_name VARCHAR(45) not null,
    address VARCHAR(255) not null,
    email VARCHAR(255) not null, 
    phone_number VARCHAR(45) not null 
) engine = innodb;

-- Create transaction table 





-- Create brand TABLE


