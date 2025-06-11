const Request = require('../models/Request');
const User = require('../models/User');

// Create a new request
exports.createRequest = async (req, res) => {
  try {
    const { eventType, amount } = req.body;
    const user = await User.findById(req.userId);

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    const newRequest = new Request({
      user: req.userId,
      name: user.name,
      eventType,
      amount
    });

    await newRequest.save();
    res.status(201).json(newRequest);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Get all requests (admin)
exports.getAllRequests = async (req, res) => {
  try {
    const requests = await Request.find().sort({ createdAt: -1 }).populate('user', 'name email');
    res.json(requests);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Get requests for current user
exports.getUserRequests = async (req, res) => {
  try {
    const requests = await Request.find({ user: req.userId }).sort({ createdAt: -1 });
    res.json(requests);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Update status (approve/reject)
exports.updateStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    const updatedRequest = await Request.findByIdAndUpdate(
      id, 
      { status }, 
      { new: true }
    ).populate('user', 'name email');

    if (!updatedRequest) {
      return res.status(404).json({ message: 'Request not found' });
    }

    res.json(updatedRequest);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};