const express = require('express');
const mysql2 = require('mysql2/promise');
const dotenv = require('dotenv');
const hbs = require('hbs');
const wax = require('wax-on');
const handlebarsHelpers = require('handlebars-helpers')({
    'handlebars':hbs.handlebars
}); 
dotenv.config();
let app = express();
app.use(express.urlencoded({ extended: false }));
app.set('view engine', 'hbs');
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

    connection.connect((err) => {
        if(err){
            console.error("Error connecting to MySQL database");
            return; 
        } 
        console.log("MySQL database connected"); 
    })

    app.get('/watch', async function (req,res){
        // we want the first element from the array returned from connection.execute
        const [watch] = await connection.execute ("Select * from watch");

        console.log(watch); 
        res.render('watch/index',{
            watch
        })
    }); 

    // displaying the form to create a new watch
    app.get('/watch/create', async function (req,res){
        const [watch] = await connection.execute('select * from watch'); 
        res.render("watch/create",{
            watch
        });
    }); 

    // process the form to create a new watch
    app.post('/watch/create', async function (req,res){
        const {brand, model, state_of_watch, price, date_of_watch} = req.body;
        const query = `
            insert into watch (brand, model, state_of_watch, price, date_of_watch) 
            values (?,?,?,?,?)`;
        // prepare the values in order of the question marks in the query
        const bindings = [brand, model, state_of_watch, parseInt(price), date_of_watch];
        await connection.execute (query, bindings); 
        res.redirect("/watch"); 
    }); 

    // Search within watch 
    app.get('/watch/search', async function (req,res){
        let sql = ""
    })



    // Delete within watch 
    app.get('/watch/watch_id/delete', async function (req,res){
        const sql = "select * from watch where watch_id = ?"; 
        const [watch] = await connection.execute(sql ,[req.params.watch_id]);
        const deleteWatch = watch[0];
        res.render('watch/delete',{
            watch,
        })
    }); 

    // Update within watch
}
main();

app.listen(3000, () => {
    console.log("server has started");
});
