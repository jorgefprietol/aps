const express = require('express');
const router = express.Router();

const pool = require('../database');

const { isLoggedIn } = require('../lib/auth');

router.get('/add', (req, res) => {
    res.render('personas/add');
});



var options = {
    valueNames: [ 'name', 'city' ]
};

// Datatable route to get the data
router.get("/data", (req, res, next) => {

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
        db: "name",
        dt: 0
      },
      {
        db: "email",
        dt: 1
      },
      {
        db: "contact",
        dt: 2
      },
      {
        db: "birthdate",
        dt: 3
      },
      {
        db: "address",
        dt: 4
      }
    ];
  
    // our database table name
    // const tableName = "users"
  
    // Custome SQL query
    const query = "SELECT * FROM users WHERE active = 1"
  
    // NodeTable requires table's primary key to work properly
    const primaryKey = "user_id"
    
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

router.post('/add', async (req, res) => {
    const { name, email, phone } = req.body;
    const newpersona = {
        name,
        email,
        phone,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO personas set ?', [newpersona]);
    req.flash('success', 'Persona Saved Successfully');
    res.redirect('/mostrar');
});

router.get('/', isLoggedIn, async (req, res) => {
    const personas = await pool.query('SELECT * FROM personas WHERE user_id = ?', [req.user.id]);
    res.render('personas/list', { personas });
});

router.get('/delete/:id', async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM personas WHERE ID = ?', [id]);
    req.flash('success', 'Persona Removed Successfully');
    res.redirect('/mostrar');
});

router.get('/edit/:id', async (req, res) => {
    const { id } = req.params;
    const personas = await pool.query('SELECT * FROM personas WHERE id = ?', [id]);
    console.log(personas);
    res.render('personas/edit', {persona: personas[0]});
});

router.post('/edit/:id', async (req, res) => {
    const { id } = req.params;
    const { name, email, phone} = req.body; 
    const newpersona = {
        name,
        email,
        phone
    };
    await pool.query('UPDATE personas set ? WHERE id = ?', [newpersona, id]);
    req.flash('success', 'Persona Updated Successfully');
    res.redirect('/mostrar');
});

module.exports = router;