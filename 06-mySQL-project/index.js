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

    app.get('/watch', async function (req,res){
        const [watch] = await connection.execute ("Select * from watch");
        res.json(watch); 
    })

    // display form to create new watch
    app.get('/watch/create', async function(req,res){
        const 
        res.render('watch/create',{
            
        })
    })

}
main();

app.listen(3000, () => {
    console.log("server has started");
});
