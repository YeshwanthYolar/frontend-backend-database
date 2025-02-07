const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');

const app = express();

// Enable CORS for all origins
app.use(cors());

// Parse incoming JSON requests
app.use(express.json());

// MySQL database connection
const db = mysql.createConnection({
  host: 'private_ip',  // Replace with your MySQL server IP
  user: 'admin',        // Replace with your MySQL username
  password: 'adminpassword',  // Replace with your MySQL password
  database: 'user_data_db'  // Replace with your MySQL database name
});

// Test the database connection
db.connect((err) => {
  if (err) {
    console.error('Error connecting to the database: ', err);
    return;
  }
  console.log('Connected to the MySQL database.');
});

// POST route to handle form submission
app.post('/submit', (req, res) => {
  const { name, age, email } = req.body;

  // SQL query to insert data into the database
  const sql = 'INSERT INTO users (name, age, email) VALUES (?, ?, ?)';

  db.query(sql, [name, age, email], (err, result) => {
    if (err) {
      console.error('Error inserting data into database:', err);
      return res.status(500).json({ message: 'Error inserting data into database' });
    }

    // Send success response
    res.json({ message: 'Data submitted successfully', data: { name, age, email } });
  });
});

// Start the server on port 3000 and explicitly bind to IPv4
app.listen(3000, '0.0.0.0', () => {
  console.log('Backend API running on http://0.0.0.0:3000');
});
