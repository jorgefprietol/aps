const express = require('express');
const morgan = require('morgan');
const path = require('path');
const exphbs = require('express-handlebars');
const session = require('express-session');
const validator = require('express-validator');
const passport = require('passport');
const flash = require('connect-flash');
const MySQLStore = require('express-mysql-session')(session);
const bodyParser = require('body-parser');
const NodeTable = require("nodetable");

const { database } = require('./keys');



// Intializations
const app = express();
require('./lib/passport');

// Settings
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
  defaultLayout: 'main',
  layoutsDir: path.join(app.get('views'), 'layouts'),
  partialsDir: path.join(app.get('views'), 'partials'),
  extname: '.hbs',
  helpers: require('./lib/handlebars')
}))
app.set('view engine', '.hbs');

// Middlewares
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

app.use(session({
  secret: 'jfpl15812417Calabozo',
  resave: false,
  saveUninitialized: false,
  store: new MySQLStore(database)
}));
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());
app.use(validator());

// Global variables
app.use((req, res, next) => {
  app.locals.message = req.flash('message');
  app.locals.success = req.flash('success');
  app.locals.user = req.user;
  next();
});
// Homepage route
app.get("/mostrar", (req, res, next) => {
  res.sendFile(path.join(__dirname + "/views/personas/index.html"));
});
// Datatable route to get the data
app.get("/data", (req, res, next) => {

  // Get the query string paramters sent by Datatable
  const requestQuery = req.query;

  /**
   * This is array of objects which maps 
   * the database columns with the Datatables columns
   * db - represents the exact name of the column in your table
   * dt - represents the order in which you want to display your fetched values
   * If your want any column to display in your datatable then
   * you have to put an enrty in the array , in the specified format
   * carefully setup this structure to avoid any errors
   */
  let columnsMap = [
    {
      db: "id",
      dt: 0
    },
    {
      db: "name",
      dt: 1
    },
    {
      db: "email",
      dt: 2
    },
    {
      db: "phone",
      dt: 3
    }
  ];

  // our database table name
  // const tableName = "personas"

  // Custome SQL query
  const query = "SELECT * FROM personas"

  // NodeTable requires table's primary key to work properly
  const primaryKey = "id"
  const db = new MySQLStore(database)
  const nodeTable = new NodeTable(requestQuery, db, query, primaryKey, columnsMap);
 
  nodeTable.output((err, data)=>{
    if (err) {
      console.log(err);
      return;
    }

    // Directly send this data as output to Datatable
    res.send(data)
  })
  
});
// Routes
app.use(require('./routes/index'));
app.use(require('./routes/authentication'));
app.use('/personas', require('./routes/personas'));

// Public
app.use(express.static(path.join(__dirname, 'public')));

// Starting
app.listen(app.get('port'), () => {
  console.log('Server is in port', app.get('port'));
});
