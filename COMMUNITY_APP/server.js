const express = require('express');
const path = require('path');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();
const connectDB = require('./config/db');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use('/public', express.static(path.join(__dirname, 'public'))); 

// Connect to DB3
connectDB();

// Create admin user if not exists (run once)
const createAdmin = async () => {
  const User = require('./models/User');
  const adminEmail = process.env.ADMIN_EMAIL || 'admin@example.com';
  const adminPassword = process.env.ADMIN_PASSWORD || 'admin123';
  
  const adminExists = await User.findOne({ email: adminEmail });
  if (!adminExists) {
    const admin = new User({
      name: 'Admin',
      email: adminEmail,
      password: adminPassword,
      address: 'Admin Address',
      phone: '0000000000',
      role: 'admin'
    });
    await admin.save();
    console.log('Admin user created');
  }
};

// Routes
app.use('/api/auth', require('./routes/authRoutes'));
app.use('/api/users', require('./routes/userRoutes'));
app.use('/api/requests', require('./routes/requestRoutes'));
app.use('/api/announcements', require('./routes/announcementRoutes'));
app.use('/api/payments', require('./routes/paymentRoutes')); 
app.use('/api/profile', require('./routes/profileRoutes'));

// Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, async () => {
  console.log(`Server running on port ${PORT}`);
  await createAdmin();
});