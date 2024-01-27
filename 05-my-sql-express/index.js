const express = require('express');
const mysql2 = require('mysql2/promise');
const dotenv = require('dotenv');
dotenv.config();

let app = express();
app.use(express.urlencoded());

async function main() {

    // create a MySQL connection
    const connection = await mysql2.createConnection({
        host: process.env.DB_HOST, // server: URL or IP address
        user: process.env.DB_USER,
        database: process.env.DB_DATABASE,
        password: process.env.DB_PASSWORD
    })

    app.get('/', function(req,res){
        res.send("Hello world");
    })
}
main()

app.listen(3000, ()=>{
    console.log("server has started")
})