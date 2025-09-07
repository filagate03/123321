const express = require('express');
const db = require('./db');
const authRoutes = require('./routes/auth');
const catalogRoutes = require('./routes/catalog');
const orderRoutes = require('./routes/orders'); // Import the new order routes

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/catalog', catalogRoutes);
app.use('/api/orders', orderRoutes); // Use the new order routes

app.get('/', (req, res) => {
  res.send('Шашлык-Машлык Backend is running!');
});

// Start the server
// We can't actually run this, but it's the standard way to start the server.
if (process.env.NODE_ENV !== 'test') {
  app.listen(port, () => {
    console.log(`Server listening on port ${port}`);
  });
}

module.exports = app; // For potential testing later
