const express = require('express');
const router = express.Router();
const { getAllUsers, getUser, deleteUser } = require('../controllers/userController');
const { authenticate } = require('../middleware/auth');
const { adminOnly } = require('../middleware/admin');

router.get('/', authenticate, adminOnly, getAllUsers);
router.get('/:id', authenticate, adminOnly, getUser);
router.delete('/:id', authenticate, adminOnly, deleteUser);

module.exports = router;