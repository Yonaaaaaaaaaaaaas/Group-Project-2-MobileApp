const express = require('express');
const router = express.Router();
const {
  createRequest,
  getAllRequests,
  getUserRequests,
  updateStatus,
} = require('../controllers/requestController');
const { authenticate } = require('../middleware/auth');
const { adminOnly } = require('../middleware/admin');

router.post('/', authenticate, createRequest);
router.get('/', authenticate, adminOnly, getAllRequests);
router.get('/my-requests', authenticate, getUserRequests);
router.put('/:id', authenticate, adminOnly, updateStatus);

module.exports = router;