// controllers/profileController.js
const User = require('../models/User');
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcryptjs');

// Get user profile
exports.getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.userId).select('-password');
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.json(user);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Update user profile
exports.updateProfile = async (req, res) => {
  try {
    const { name, email, address, phone, currentPassword, newPassword } = req.body;
    
    const user = await User.findById(req.userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Check if email is being changed and if new email already exists
    if (email && email !== user.email) {
      const emailExists = await User.findOne({ email });
      if (emailExists) {
        return res.status(400).json({ message: 'Email already in use' });
      }
      user.email = email;
    }

    // Update basic info
    if (name) user.name = name;
    if (address) user.address = address;
    if (phone) user.phone = phone;

    // Handle password change if requested
    if (currentPassword && newPassword) {
      const isMatch = await user.comparePassword(currentPassword);
      if (!isMatch) {
        return res.status(401).json({ message: 'Current password is incorrect' });
      }
      user.password = newPassword;
    }

    await user.save();

    // Return updated user without password
    const updatedUser = await User.findById(req.userId).select('-password');
    res.json({
      message: 'Profile updated successfully',
      user: updatedUser
    });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Update profile picture
exports.updateProfilePicture = async (req, res) => {
  try {
    const user = await User.findById(req.userId);
    if (!user) {
      // Remove uploaded file if user not found
      if (req.file) fs.unlinkSync(req.file.path);
      return res.status(404).json({ message: 'User not found' });
    }

    // Delete old profile picture if exists
    if (user.profilePicture) {
      const oldPicturePath = path.join(__dirname, '../public', user.profilePicture);
      if (fs.existsSync(oldPicturePath)) {
        fs.unlinkSync(oldPicturePath);
      }
    }

    const picturePath = req.file.path.replace('public', '');

    user.profilePicture = picturePath;
    await user.save();

    res.status(200).json({ 
      message: 'Profile picture updated successfully',
      profilePicture: picturePath
    });
  } catch (err) {
    // Remove uploaded file if error occurs
    if (req.file) fs.unlinkSync(req.file.path);
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};
exports.deleteProfile = async (req, res) => {
  try {
    // Find and delete the user
    const deletedUser = await User.findByIdAndDelete(req.userId);
    
    if (!deletedUser) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Simple cleanup - just delete profile picture if exists
    if (deletedUser.profilePicture) {
      const picturePath = path.join(__dirname, '../public', deletedUser.profilePicture);
      if (fs.existsSync(picturePath)) {
        fs.unlinkSync(picturePath);
      }
    }

    res.json({ message: 'Profile deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};