// routes/paymentRoutes.js
const express = require('express');
const router = express.Router();
const upload = require('../config/receiptUpload');
const {
  uploadReceipt,
  updatePaymentStatus,
  getPaymentDetails,
  getPendingPayments
} = require('../controllers/paymentController');
const { authenticate } = require('../middleware/auth');
const { adminOnly } = require('../middleware/admin');

// User routes
router.post('/upload', authenticate, upload.single('receipt'), uploadReceipt);
router.get('/details', authenticate, getPaymentDetails);

// Admin routes
router.get('/pending', authenticate, adminOnly, getPendingPayments);
router.put('/:userId/status', authenticate, adminOnly, updatePaymentStatus);

module.exports = router;