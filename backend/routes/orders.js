const express = require('express');
const db = require('../db');
// const { authMiddleware } = require('../middleware/auth'); // Assuming middleware for user auth

const router = express.Router();

// Create a new order
// Endpoint: POST /api/orders
// A protected route, so we would use authMiddleware in a real app
router.post('/', /* authMiddleware, */ async (req, res) => {
  // Note: In a real app, user_id would come from the auth token (req.user.id)
  const { user_id, delivery_address, items } = req.body;

  if (!user_id || !delivery_address || !items || items.length === 0) {
    return res.status(400).json({ msg: 'Please provide user_id, address, and items.' });
  }

  const client = await db.pool.connect(); // Using the pool directly for transaction

  try {
    await client.query('BEGIN');

    // In a real app, you should recalculate the total price on the backend
    // to prevent tampering on the client side.
    // For this MVP, we'll just trust the client's total, or calculate it simply.
    let totalPrice = 0;
    for (const item of items) {
        const productResult = await client.query('SELECT price FROM products WHERE id = $1', [item.product_id]);
        if (productResult.rows.length === 0) {
            throw new Error(`Product with id ${item.product_id} not found.`);
        }
        totalPrice += productResult.rows[0].price * item.quantity;
    }

    // Insert into orders table
    const orderQuery = `
      INSERT INTO orders (user_id, delivery_address, total_price, status)
      VALUES ($1, $2, $3, 'pending')
      RETURNING id, created_at;
    `;
    const orderResult = await client.query(orderQuery, [user_id, delivery_address, totalPrice]);
    const newOrderId = orderResult.rows[0].id;

    // Insert into order_items table
    const itemInsertQuery = `
      INSERT INTO order_items (order_id, product_id, quantity, price_per_unit)
      VALUES ($1, $2, $3, $4);
    `;
    for (const item of items) {
      // Get the price from the DB again to ensure it's correct
      const productResult = await client.query('SELECT price FROM products WHERE id = $1', [item.product_id]);
      const pricePerUnit = productResult.rows[0].price;
      await client.query(itemInsertQuery, [newOrderId, item.product_id, item.quantity, pricePerUnit]);
    }

    await client.query('COMMIT');

    res.status(201).json({
      msg: 'Order created successfully!',
      order_id: newOrderId,
    });

  } catch (err) {
    await client.query('ROLLBACK');
    console.error(err.message);
    res.status(500).send('Server Error');
  } finally {
    client.release();
  }
});

module.exports = router;
