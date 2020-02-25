/* server.js designed by Angela Dunwoodie-Lambert, Jared Bellamy, Brandon Cuthbertson, Caleb Badick*/

//------------------------------importing plugins----------------------------------------a-
const mysql = require("mysql");
const express = require("express");
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });
const session = require("express-session");
const app = express();
const router = express.Router();
const pool = mysql.createPool({
        connectionLimit: 10,
         host: "localhost",
        user: "root",
        password: "",
        database: "travelexperts"
    });

var engine = require('consolidate');
app.set('public', __dirname + '/public');
app.engine('html', engine.mustache);


//----------------------loading pages from the public path----------------------------------a-

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'));
app.use(express.static('views'));


app.set('view engine', 'ejs');

app.use(session({
    secret: 'toby',
    resave: true,
    saveUninitialized: true
  }))

//----launching express----
app.listen(8000, err => {
    if (err) throw err;
    console.log("server started on port 8000");
});

app.use(express.static('public'));

var s;
app.get('/login', (req, res) =>{
    if(s){
        return res.redirect("/index.html");
    }

    return res.redirect("/login.html");
});

//------------------------------------Creating login session---------------------------------a-c-
app.post('/login', (req, res) => {
    s=req.session;
    s.email = req.body.email;
    console.log(s.email);
    res.end('done');
});

//----------------------------Importing information to packages form--------------------------a-
app.get("/service/packages/:packageId*?", (req, res) => {
    console.log(req.params.packageId);
    var whereClause = "";
    if (req.params.packageId != null) {
        whereClause = " WHERE packageId = " + req.params.packageId;
    }

    pool.getConnection(function (err, connection) {
        connection.query("SELECT * FROM packages" + whereClause, function (err, result, fields) {
            if (err) throw err;
            console.log(result);
            res.setHeader('Content-Type', 'application/json');
            res.send(result);
            console.log("Returned packages to caller");
        });
    });
});

// -------------------------importing data from MySQL into contact.ejs-------------------------j-
app.get('/service/agents', (req, res) => {
    pool.getConnection(function (err, connection) {
        var sql = "SELECT * FROM `agents`"
        connection.query(sql, function (err, result, fields) {
            if (err) throw err;
            res.setHeader('Content-Type', 'application/json');
            res.send(result);
        });
    });
});

// ------------------------posting new user to database----------------------------------------b-a-
app.post('/register', urlencodedParser, function (req, res, next) {
    pool.getConnection(function (err, connection) {
        // Added by Brandon, Fixed By Angela, emphasis on Angela getting it to work
        
        if (err) throw err;
        console.log("submitting registration form");
        let data = [req.body.CustFirstName, req.body.CustLastName, req.body.CustAddress, req.body.CustCity, req.body.CustPostal, req.body.CustCountry, req.body.CustHomePhone, req.body.CustBusPhone, req.body.CustEmail];
        var sqli = "INSERT INTO customers (CustFirstName, CustLastName, CustAddress, CustCity, CustPostal, CustCountry, CustHomePhone, CustBusPhone, CustEmail)"
            + " VALUES (?,?,?,?,?,?,?,?,?)";



        pool.query(sqli, data,  function (err, result) {
            if (err) throw err;
            console.log(result);
            //connection.release();

        });

        res.render(
            '/public/index.html'

        );
    });
});




//-------------------------404 handler *****MUST BE LAST*******-------------------------------------a-
app.use(function (req, res, next) {
    res.status(404).sendFile(__dirname + '/public/404.html');
});
