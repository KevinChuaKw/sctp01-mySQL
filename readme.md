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

DDL - Data Defination Language (what allows you to create)
DML - Data Manulipulate Language (CUD in CRUD)
DQL - Data Query Language (R in CRUD)

Must start from gidpod for the database to be intact 