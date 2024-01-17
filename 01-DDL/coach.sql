-- Show al database in your SQL server
show databases; 

-- create a new database
create database swimming_coach; 
-- you will need the ';' 

-- switch database with 'use'
use swimming_coach; 

-- create table - refer to the schema diagram 
-- order of creating the column
-- <name of column> <data type> <options> <null or not null> 
create table parents (
    id int unsigned auto_increment primary key, 
    name varchar(100) not null,
    email varchar(320) not null, 
    phone varchar(20) not null
) engine = innodb; 

-- see table in database 
show tables;

-- to examine the columns in the table, use 'describe' 
describe parents; 