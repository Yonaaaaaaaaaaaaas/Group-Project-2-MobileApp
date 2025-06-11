const Announcement = require('../models/Announcement');
const fs = require('fs');
const path = require('path');

// Create announcement (Admin only)
exports.createAnnouncement = async (req, res) => {
  try {
    const { title, description, date, location } = req.body;
    
    let imagePath = null;
    if (req.file) {
      imagePath = req.file.path.replace('public', '');
    }

    const announcement = new Announcement({
      title,
      description,
      date,
      location,
      image: imagePath,
      postedBy: req.userId
    });

    await announcement.save();

    res.status(201).json(announcement);
  } catch (err) {
    // Remove uploaded file if error occurs
    if (req.file) {
      fs.unlinkSync(req.file.path);
    }
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Update announcement (Admin only)
exports.updateAnnouncement = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, description, date, location } = req.body;
    
    const announcement = await Announcement.findById(id);
    if (!announcement) {
      return res.status(404).json({ message: 'Announcement not found' });
    }

    let imagePath = announcement.image;
    if (req.file) {
      // Delete old image if exists
      if (announcement.image) {
        const oldImagePath = path.join(__dirname, '../public', announcement.image);
        if (fs.existsSync(oldImagePath)) {
          fs.unlinkSync(oldImagePath);
        }
      }
      imagePath = req.file.path.replace('public', '');
    }

    const updatedAnnouncement = await Announcement.findByIdAndUpdate(
      id,
      { 
        title, 
        description, 
        date, 
        location,
        image: imagePath
      },
      { new: true }
    ).populate('postedBy', 'name');

    res.json(updatedAnnouncement);
  } catch (err) {
    // Remove uploaded file if error occurs
    if (req.file) {
      fs.unlinkSync(req.file.path);
    }
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Delete announcement (Admin only)
exports.deleteAnnouncement = async (req, res) => {
  try {
    const { id } = req.params;

    const announcement = await Announcement.findByIdAndDelete(id);
    if (!announcement) {
      return res.status(404).json({ message: 'Announcement not found' });
    }

    // Delete associated image if exists
    if (announcement.image) {
      const imagePath = path.join(__dirname, '../public', announcement.image);
      if (fs.existsSync(imagePath)) {
        fs.unlinkSync(imagePath);
      }
    }

    res.json({ message: 'Announcement deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
  
};
// Get all announcements (public)
exports.getAllAnnouncements = async (req, res) => {
  try {
    const announcements = await Announcement.find()
      .populate('postedBy', 'name')
      .sort({ createdAt: -1 });
    res.json(announcements);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};


// ... (keep existing getAllAnnouncements method)