To start mysql, in the terminal, type in `mysql -u root`

# Create a new database user
In the MySQL CLI:
```
CREATE USER 'ahkow'@'localhost' IDENTIFIED BY 'rotiprata123';
```

```
GRANT ALL PRIVILEGES on sakila.* TO 'ahkow'@'localhost' WITH GRANT OPTION;
```
**Note:** Replace *sakila* with the name of the database you want the user to have access to
 
 ```
FLUSH PRIVILEGES;
```


SQL has 3 components 

DDL - Data Defination Language (what allows you to create) [To create table / alter table / drop table]
DML - Data Manulipulate Language (CUD in CRUD) [Insert data into / update name / delete from <table> where <criteria>]
DQL - Data Query Language (R in CRUD) [Select command]

Must start from gidpod for the database to be intact

Injection attacks 
Adding a single quote into the search bar might give an error from the server
By adding a single quote (') you will break the wildcard
    This will allow hackers to identity which database management system you are using
By adding (;--), you will not crash the server but you will comment out the end of the query. 
You can then add in your own query with the faked end query that you have just created

Probing phase
Use the term 'sleep' 
To use 'union' to try to output data onto results in the search 
Use the metadata tables that are generic in all MySQL tables and try to get the program to display it

In summary 
This will make the query into code and confuse the database


How to reduce the likely hood of the injections? 
1. Limit the character input for the user 
2. Do not use a root user, it has full access to the full database 
    When you create a particular user to only access specific tables
    in the database 
3. Using prepared statements - A 2 stage process - Converting the user input into data and not code 