const express = require('express');
const db = require('../db');
const bcrypt = require('bcryptjs'); // Assuming this is installed
const jwt = require('jsonwebtoken'); // Assuming this is installed

const router = express.Router();

// User Registration
// Endpoint: POST /api/auth/register
router.post('/register', async (req, res) => {
  const { phone_number, password } = req.body;

  if (!phone_number || !password) {
    return res.status(400).json({ msg: 'Please provide a phone number and password.' });
  }

  try {
    // Check if user already exists
    const userCheck = await db.query('SELECT * FROM users WHERE phone_number = $1', [phone_number]);
    if (userCheck.rows.length > 0) {
      return res.status(400).json({ msg: 'User with this phone number already exists.' });
    }

    // Hash the password
    // In a real app, the salt rounds would be in a config file
    const salt = await bcrypt.genSalt(10);
    const password_hash = await bcrypt.hash(password, salt);

    // Save the user to the database
    const newUser = await db.query(
      'INSERT INTO users (phone_number, password_hash) VALUES ($1, $2) RETURNING id, phone_number',
      [phone_number, password_hash]
    );

    res.status(201).json({
      msg: 'User registered successfully!',
      user: newUser.rows[0],
    });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

// User Login
// Endpoint: POST /api/auth/login
router.post('/login', async (req, res) => {
  const { phone_number, password } = req.body;

  if (!phone_number || !password) {
    return res.status(400).json({ msg: 'Please provide a phone number and password.' });
  }

  try {
    // Check if user exists
    const userResult = await db.query('SELECT * FROM users WHERE phone_number = $1', [phone_number]);
    if (userResult.rows.length === 0) {
      return res.status(400).json({ msg: 'Invalid credentials.' });
    }

    const user = userResult.rows[0];

    // Compare password
    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) {
      return res.status(400).json({ msg: 'Invalid credentials.' });
    }

    // Create JWT Payload
    const payload = {
      user: {
        id: user.id,
      },
    };

    // Sign and return token
    // JWT secret should be in an environment variable
    jwt.sign(
      payload,
      process.env.JWT_SECRET || 'a-very-secret-key',
      { expiresIn: 3600 }, // Expires in 1 hour
      (err, token) => {
        if (err) throw err;
        res.json({ token });
      }
    );

  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

module.exports = router;
