const express = require('express');
const db = require('../db');

const router = express.Router();

// GET all categories
// Endpoint: GET /api/catalog/categories
router.get('/categories', async (req, res) => {
  try {
    const { rows } = await db.query('SELECT id, name, description FROM categories ORDER BY id ASC');
    res.json(rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

// GET all products, optionally filtered by category_id
// Endpoint: GET /api/catalog/products?category=1
router.get('/products', async (req, res) => {
  const { category } = req.query;

  try {
    let query;
    let params = [];

    if (category) {
      query = 'SELECT * FROM products WHERE category_id = $1 ORDER BY name ASC';
      params = [category];
    } else {
      query = 'SELECT * FROM products ORDER BY name ASC';
    }

    const { rows } = await db.query(query, params);
    res.json(rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

// GET a single product by ID
// Endpoint: GET /api/catalog/products/1
router.get('/products/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const { rows } = await db.query('SELECT * FROM products WHERE id = $1', [id]);
    if (rows.length === 0) {
      return res.status(404).json({ msg: 'Product not found' });
    }
    res.json(rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});


module.exports = router;
