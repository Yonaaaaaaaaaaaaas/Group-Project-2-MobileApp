// controllers/paymentController.js
const User = require('../models/User');
const fs = require('fs');
const path = require('path');

// Upload payment receipt
exports.uploadReceipt = async (req, res) => {
  try {
    const user = await User.findById(req.userId);
    if (!user) {
      // Remove uploaded file if user not found
      if (req.file) fs.unlinkSync(req.file.path);
      return res.status(404).json({ message: 'User not found' });
    }

    // Delete old receipt if exists
    if (user.paymentReceipt) {
      const oldReceiptPath = path.join(__dirname, '../public', user.paymentReceipt);
      if (fs.existsSync(oldReceiptPath)) {
        fs.unlinkSync(oldReceiptPath);
      }
    }

    const receiptPath = req.file.path.replace('public', '');

    user.paymentReceipt = receiptPath;
    user.paymentStatus = 'pending';
    await user.save();

    res.status(200).json({ 
      message: 'Receipt uploaded successfully',
      paymentStatus: user.paymentStatus,
      receiptUrl: receiptPath
    });
  } catch (err) {
    // Remove uploaded file if error occurs
    if (req.file) fs.unlinkSync(req.file.path);
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Update payment status (Admin only)
exports.updatePaymentStatus = async (req, res) => {
  try {
    const { userId } = req.params;
    const { status } = req.body;

    if (!['paid', 'unpaid'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status' });
    }

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    user.paymentStatus = status;
    if (status === 'paid') {
      user.paymentApprovedAt = new Date();
    } else {
      user.paymentApprovedAt = null;
    }

    await user.save();

    res.json({
      message: 'Payment status updated successfully',
      user: {
        _id: user._id,
        name: user.name,
        email: user.email,
        paymentStatus: user.paymentStatus,
        paymentApprovedAt: user.paymentApprovedAt
      }
    });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Get payment details
exports.getPaymentDetails = async (req, res) => {
  try {
    const user = await User.findById(req.userId)
      .select('paymentStatus paymentReceipt paymentApprovedAt');
      
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json({
      paymentStatus: user.paymentStatus,
      receiptUrl: user.paymentReceipt,
      paymentApprovedAt: user.paymentApprovedAt
    });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Get users with pending payments (Admin only)
exports.getPendingPayments = async (req, res) => {
  try {
    const users = await User.find({ paymentStatus: 'pending' })
      .select('name email paymentReceipt createdAt');
      
    res.json(users);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};