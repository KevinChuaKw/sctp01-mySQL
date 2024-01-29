const express = require('express');
const mysql2 = require('mysql2/promise');
const dotenv = require('dotenv');
const hbs = require('hbs');
const wax = require('wax-on');

dotenv.config();

let app = express();
app.use(express.urlencoded({ extended: false }));

// Set up Handlebars
app.set('view engine', 'hbs');

// Use Wax-On for additional Handlebars helpers
wax.on(hbs.handlebars);
wax.setLayoutPath('./views/layouts');

async function main() {
    // create a MySQL connection
    const connection = await mysql2.createConnection({
        host: process.env.DB_HOST, // server: URL or IP address
        user: process.env.DB_USER,
        database: process.env.DB_DATABASE,
        password: process.env.DB_PASSWORD
    });

    app.get('/customers', async function(req, res) {
        // we want the first element from the array returned from connection.execute
        const [customers] = await connection.execute("SELECT * from Customers");
        // same 
        res.render('customers/index',{
            customers
        }); 
    });

    // Display the form to create new customer
    app.get('/customers/create', async function (req,res){
        const [companies] = await connection.execute("SELECT * from Companies");
        res.render("customers/create"); 
            companies; 
    });

    app.post('/customers/create', async function (req,res){
        // Using
        const {first_name, last_name, rating, company_id}= req.body; 
        const query = `
            INSERT INTO Customers (first_name, last_name, rating, company_id) 
            VALUES (?,?,?,?)
        `;

        const bindings = [first_name, last_name, parseInt(rating), parseInt(company_id)];
        await connection.execute (query, bindings); 
        res.redirect('/customers'); 


        //Using RAW QUERIES -- DANGEROUS! Vulnerable to SQL injections
        // const {first_name, last_name, rating, company_id}= req.body; 
        // const query = `
        //     INSERT INTO Customers (first_name, last_name, rating, company_id) 
        //     VALUES ('${first_name}', '${last_name}', ${rating}, ${company_id})
        // `;
        // await connection.execute(query); 
        // res.redirect('/customers'); 
    })

    app.get('/customers/search', async function(req,res){

        let sql = "SELECT * from Customers WHERE 1"; 
        const bindings= [];
        if (req.query.searchTerms) {
            sql += ` AND (first_name LIKE ? OR last_name LIKE ?)`;
            bindings.push(`%${req.query.searchTerms}%`);
            bindings.push(`%${req.query.searchTerms}%`);
        }

        const [customers] = await connection.execute(sql, bindings);

        res.render('customers/search-form', {
            customers
        });
    })

    // Delete
    app.get('/customers/:customers_id/delete', async function (req,res){
        const sql = "select * from Customers where customer_id = ?";
        
        // Connection.execute will always return a array even if it is just one reult
        // That one will be the only element in the array
        const [customers] = await connection.execute(sql, [req.params.customers_id]);
        const customer = customer[0];
        res.render('customers/delete.hbs',{
            customer
        })
    })





    



}
main();

app.listen(3000, () => {
    console.log("server has started");
});
