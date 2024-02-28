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

    // Doing home page for all routes 
    app.get('/', async function (req,res){
        res.render('home/index'); 
    }); 

    app.get('/home', async function (req,res){
        res.render('home/index'); 
    }); 

    // Doing watch home page
    app.get('/watch', async function (req,res){
        const [watch] = await connection.execute ("Select * from watch");
        res.render('watch/index',{
            watch
        })
    }); 

    // Search within watch 
    // app.get('/watch/search', async function (req,res){
    //     let sql = "select * from watch where 1"; 
    //     const bindings = [];
    //     if (req.query.searchTerms){
    //         sql += ` and (brand like ? or model like ?)`;
    //         bindings.push(`%${req.query.searchTerms}%`); 
    //         bindings.push(`%${req.query.searchTerms}%`); 
    //     }
    //     const [watch] = await connection.execute(sql,bindings);
    //     res.render('watch/search',{
    //         watch
    //     });
    // });

    // app.post('/watch/search', async function (req,res){
    //     let sql = "select * from watch where 1"; 
    //     const bindings = [];
    //     if (req.query.searchTerms){
    //         sql += ` and (brand like ? or model like ?)`;
    //         bindings.push(`%${req.query.searchTerms}%`); 
    //         bindings.push(`%${req.query.searchTerms}%`); 
    //     }
    //     const [watch] = await connection.execute(sql,bindings);
    //     res.render('watch/search',{
    //         watch
    //     });
    // });

    // Search within watch (by XJ)
    app.get('/watch/search', async function (req,res){
        let sql = "select * from watch where 1"; 
        const [watch] = await connection.execute(sql);
        res.render('watch/search',{
            watch
        });
    });

    app.post('/watch/search', async function (req,res){
        let sql = "SELECT * FROM watch WHERE 1"; 
        const bindings = [];
        // This only works if both fields are filled up need to find a way to seperate this
        if (req.body.brandSearchTerms || req.body.modelSearchTerms){
            sql += ` AND (brand like ? OR model like ?)`;
            bindings.push(`%${req.body.brandSearchTerms}%`); 
            bindings.push(`%${req.body.modelSearchTerms}%`); 
        }
        console.log(bindings)
        const [watch] = await connection.execute(sql,bindings);
        res.render('watch/search',{
            watch
        });
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

    // Delete within watch 
    app.get('/watch/:watch_id/delete', async function (req,res){
        const sql = "select * from watch where watch_id = ?"; 
        const [watches] = await connection.execute(sql ,[req.params.watch_id]);
        const watch = watches[0];
        res.render('watch/delete',{
            watch,
        })
    }); 

    app.post('/watch/:watch_id/delete', async function (req,res){
        const query = "delete from watch where watch_id =?";
        await connection.execute(query, [req.params.watch_id]);
        res.redirect('/watch');
    }); 
    

    // Update within watch
    app.get('/watch/:watch_id/update', async function (req,res){
        const query = "select * from watch where watch_id =?";
        const [watches] = await connection.execute(query, [req.params.watch_id]);
        const watch = watches[0];
        res.render('watch/update',{
            watch
        })
    })
    
    app.post('/watch/:watch_id/update', async function (req,res){
        const {brand, model, state_of_watch, price, date_of_watch} = req.body; 
        const watch_id = req.params.watch_id;
        const query = "UPDATE watch SET brand=?, model=?, state_of_watch=?, price=?, date_of_watch=? WHERE watch_id=?";
        const bindings = [brand, model, state_of_watch, parseInt(price), date_of_watch, watch_id];
        await connection.execute(query, bindings);
        res.redirect('/watch');
    })

    // Doing customer home page
    app.get('/customer', async function (req,res){
        const [customer] = await connection.execute ("Select * from customer"); 
        console.log(customer);
        res.render('customer/index',{
            customer
        })
    }); 

    // displaying the form to create a new customer
    app.get('/customer/create', async function (req,res){
        const [customer] = await connection.execute('select * from customer'); 
        res.render("customer/create",{
            customer
        });
    }); 

    // process the form to create a new customer
    app.post('/customer/create', async function (req,res){
        const {first_name, last_name, address, email, phone_number} = req.body;
        const query = `
            insert into customer (first_name, last_name, address, email, phone_number) 
            values (?,?,?,?,?)`;
        // prepare the values in order of the question marks in the query
        const bindings = [first_name, last_name, address, email, phone_number];
        await connection.execute (query, bindings); 
        res.redirect("/customer"); 
    }); 

    // Delete within customer
    app.get('/customer/:watch_id/delete', async function (req,res){
        const sql = "select * from customer where customer_id = ?"; 
        const [customers] = await connection.execute(sql ,[req.params.customer_id]);
        const customer = customers[0];
        res.render('customer/delete',{
            customer,
        })
    }); 

    app.post('/customer/:customer_id/delete', async function (req,res){
        const query = "delete from customer where customer_id =?";
        await connection.execute(query, [req.params.customer_id]);
        res.redirect('/customer');
    }); 


    // Doing transaction home page
    app.get('/transaction', async function (req,res){
        const [transaction] = await connection.execute ("Select * from transaction"); 
        res.render('transaction/index',{
            transaction
        })
    }); 

    



}
main();

// app.listen(3000, () => {
//     console.log("server has started");
// });

// PORT CHANGED
app.listen(4000, () => {
    console.log("server has started");
});
