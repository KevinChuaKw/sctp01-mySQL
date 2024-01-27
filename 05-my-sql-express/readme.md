# Dependencies
* express
* dotenv
* mysql2
* hbs
* wax-on

# Setup steps
1. Create a new database in MySQL (for our example, we use `crm`).
    ```
    create database crm; 
    ```

2. In the first line of the `schema.sql`, type in
    ```
    USE crm;
    ```



Object destructuring 
let [a,o,p,z] = fruits
The order matters within the array

let {firstName, lastName, age } = req.body