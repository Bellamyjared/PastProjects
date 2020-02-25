



app.use(session({secret: 'sooperseekrit', saveUninitialized: true,resave: true}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static('public'));

var sess; //Global session

function loadIndex(){
    res.sendFile('index.html');
}

router.get('/',(req, res) => {
    sess = req.session;
    if(sess.email){
        console.log("session: " + sess);
        return res.redirect('/admin');
    }
    res.sendFile('index.html');
});


var engine = require('consolidate');
app.set('public', __dirname + '/public');
app.engine('html', engine.mustache);


//login code
router.post('/login', (req, res) => {
    sess = req.session;
    sess.email= req.body.email;
    res.end('done');
});

router.get('/admin', (req, res) => {
    sess = req.session;
    if(sess.email){
        // Not sure if this is gonna work...
        res.write('<h1>Hello, Travel Experts User! </h1><br>');
        res.end('<a href'+'/logout'+'>Logout</a>');
        setTimeout(loadIndex, 3000);
    }
    else {
        res.write('<h1>Please log in first</h1>');
        res.end('<a href'+'/'+'>Login</a>');
    }
});

router.get('/logout', (req, res) => {
    req.session.destroy((err) => {
        if(err) {
            return console.log(err);
        }
        res.redirect('/');
    });
});

app.use('/', router);

app.listen(process.env.PORT || 3000,() => {
    console.log('App Started on Port ${process.env.PORT || 3000}');
});



//----loading pages from the public path----

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'));
app.use(express.static('views'));


app.set('view engine', 'ejs');



//-----Connecting MySQL to express -----
var connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "travelexperts"
});



connection.connect((err)=> {
    if (err) throw err;
    console.log("Connected MySQL");
});


module.exports = connection;


//----launching express----
app.listen(8000, err => {
    if (err) throw err;
    console.log("server started on port 8000");
});

//loading pages from the public path
app.use(express.static('public'));

app.get("/service/packages/:packageId*?", (req, res) => {
    console.log(req.params.packageId);
    var whereClause = "";
    if (req.params.packageId != null) {
        whereClause = " WHERE packageId = " + req.params.packageId;
    }

    pool.getConnection(function (err, connection) {
        connection.query("SELECT * FROM packages" + whereClause, function (err, result, fields) {
            if (err) throw err;
            //console.log(result);
            res.setHeader('Content-Type', 'application/json');
            res.send(result);
            console.log("Returned packages to caller");
        });
    });
});

// importing data from MySQL into contact.ejs
app.get('/service/agents', (req, res) => {
    var sql = "SELECT * FROM `agents`"
    connection.query(sql, function (err, result, fields) {
        if (err) throw err;
        res.setHeader('Content-Type', 'application/json');
        res.send(result);
    });
});


app.post('/submit-form', urlencodedParser, function (req, res, next) {
    pool.getConnection(function (err, connection) {
        if (err) throw err;
        console.log("connected");
        let data = [req.body.CustFirstName, req.body.CustLastName,req.body.CustAddress,req.body.CustCountry,req.body.CustProv,req.body.CustHomePhone,req.body.CustBusPhone, , req.body.CustEmail, req.body.UserID, req.body.PassId,req.body.AgentId];
        var sqli = "INSERT INTO `customers`(`CustFirstName`, `CustLastName`, `CustAddress`, `CustCity`, `CustCountry`, `CustProv`, `CustPostal`, `CustHomePhone`, `CustBusPhone`, `CustEmail`, `UserID`, `PassId`,`AgentId`)"
            + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?);";
        //var data = ""[value - 1]","[value - 2]","[value - 3]","[value - 4]","[value - 5]","[value - 6]","[value - 7]","[value - 8]","[value - 9]","[value - 10]","[value - 11]","[value - 12]","[value - 13]",12";
        pool.query(sqli, data,  function (err, result) {
            if (err) throw err;
            console.log(result);
            //connection.release();

        });

        res.render(
            'index.html'
        );
    });
});

//404 handler *****MUST BE LAST*******
app.use(function (req, res, next) {
    res.status(404).sendFile(__dirname + '/public/404.html');
});