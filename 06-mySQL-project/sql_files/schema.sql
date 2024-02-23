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
create table customer (
    customer_id int unsigned auto_increment PRIMARY key,
    first_name VARCHAR(45) not null,
    last_name VARCHAR(45) not null,
    address VARCHAR(255) not null,
    email VARCHAR(255) not null, 
    phone_number VARCHAR(45) not null 
) engine = innodb;

-- Create transaction table 
CREATE TABLE transaction (
    transaction_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date_of_transaction DATETIME NOT NULL,
    transaction_amount INT NOT NULL, 
    customer_id INT UNSIGNED,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    watch_id INT UNSIGNED,
    FOREIGN KEY (watch_id) REFERENCES watch (watch_id)
) ENGINE = InnoDB;


-- Create brand table
CREATE TABLE brand (
    brand_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    watch_id INT UNSIGNED,
    FOREIGN KEY (watch_id) REFERENCES watch (watch_id)
) ENGINE = InnoDB;
