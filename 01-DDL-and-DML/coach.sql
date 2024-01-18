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
    phone varchar(20) not null,
    unique(email)
) engine = innodb; 

-- see table in database 
show tables;

-- to examine the columns in the table, use 'describe' 
describe parents; 

-- to do up the student table 
-- this is unique as there is a foreign key 
-- Creating foreign key 
-- 1. Create the table first, then add the foreign key (safer)
-- 2. Create the table and the foreign key in one DDL statement 
-- (but it is still considered as 2 process) 
-- engine must be innodb 
create table students (
    id mediumint unsigned auto_increment primary key,
    name varchar(300) not null, 
    swimming_grade varchar(20) not null, 
    dob datetime not null, 
    -- make sure the data type of the foreign key matches the correspondinng
    -- column in the other table - the foreign key has not been linked yet
    parent_id int unsigned not null
) engine = innodb; 

-- Creating the foreign key between 2 tables
-- add constraint: name a FK 
alter table students add constraint fk_students_parents
    foreign key (parent_id) references parents (id); 

-- This is where the students parent id column will 
-- refer to one id in the parents table


-- Inserting data 
insert into parents (
    name, email, phone
) values ("John Tan", "JT@gmail.com", "12345678"); 

-- Get all rows from tabls 
select * from parents


-- Inserting multiple rows
insert into parents (
    name, email, phone
) values ("Kevin Tan", "KT@gmail.com", "87654321"),
("Bob Wong", "BT@gmail.com","12121212"); 

insert into students (name, swimming_grade, dob, parent_id)
values ("Jelly Tan", "Bronze", "2020-05-10", 1); 
-- This is adding the foreign key at the back 


-- invalid insert 
insert into students (name, swimming_grade, dob, parent_id)
values ("John Wong", "Gold", "1985-08-08", 999); 

-- invalid delete 
delete from parents where id = 1;
-- We cannot delete Jelly Tan because Jelly Tan depends on John Tan


-- To alter the table
alter table sessions add column student_id mediumint unsigned not null; 

alter table sessions add constraint fk_sessions_students
foreign key (student_id) references students(id); 

alter table sessions drop column when; 

alter table sessions modify column when varchar(50); 

-- Delete table 
drop table asd 

-- Delete row from table 
delete from parents where id=2; 


-- Update an existing row
update parents set name = "Bobby Wong" where id = 3; 

update parents set name = "Kelvin Tan", email = "KelTan#gmail.com" where id = 2;



