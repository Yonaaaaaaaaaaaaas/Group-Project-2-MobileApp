const express = require('express');
const router = express.Router();
const upload = require('../config/multer');
const {
  createAnnouncement,
  getAllAnnouncements,
  updateAnnouncement,
  deleteAnnouncement
} = require('../controllers/announcementController');
const { authenticate } = require('../middleware/auth');
const { adminOnly } = require('../middleware/admin');

// Admin routes
router.post('/', authenticate, adminOnly, upload.single('image'), createAnnouncement);
router.put('/:id', authenticate, adminOnly, upload.single('image'), updateAnnouncement);
router.delete('/:id', authenticate, adminOnly, deleteAnnouncement);

// Public route
router.get('/', getAllAnnouncements);

module.exports = router;