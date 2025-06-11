import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/widgets/admin_bottom_navbar.dart';
import '../providers/announcement_provider.dart';
import '../../data/models/announcement_model.dart';

class AdminAnnouncementsPage extends ConsumerStatefulWidget {
  const AdminAnnouncementsPage({super.key});

  @override
  ConsumerState<AdminAnnouncementsPage> createState() => _AdminAnnouncementsPageState();
}

class _AdminAnnouncementsPageState extends ConsumerState<AdminAnnouncementsPage> {
  @override
  void initState() {
    super.initState();
    // Load announcements when the page is first opened
    Future.microtask(() => ref.read(announcementProvider.notifier).getAllAnnouncements());
  }

  @override
  Widget build(BuildContext context) {
    final announcementsState = ref.watch(announcementProvider);

    return Scaffold(
      body: announcementsState.when(
        data: (announcements) => SingleChildScrollView(
          child: Column(
            children: [
              const CurvedHeader(),
              const SizedBox(height: 25),
              if (announcements.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'No announcements yet',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              else
                ...announcements.map((announcement) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      child: AnnouncementCard(
                        announcement: announcement,
                        onEdit: () => _handleEdit(announcement),
                        onDelete: () => _handleDelete(announcement),
                        onViewDetails: () => _handleViewDetails(announcement),
                      ),
                    )),
              const SizedBox(height: 20),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
              ElevatedButton(
                onPressed: () => ref.read(announcementProvider.notifier).getAllAnnouncements(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AnnounceFAB(onPressed: () {
        Navigator.pushNamed(context, '/add-announcement');
      }),
      bottomNavigationBar: const AdminBottomNavBar(),
    );
  }

  void _handleEdit(AnnouncementModel announcement) {
    Navigator.pushNamed(
      context,
      '/add-announcement',
      arguments: announcement,
    );
  }

  Future<void> _handleDelete(AnnouncementModel announcement) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Announcement'),
        content: const Text('Are you sure you want to delete this announcement?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final notifier = ref.read(announcementProvider.notifier);
      final success = await notifier.deleteAnnouncement(announcement.id);
      if (success) {
        // Optionally refresh the list (not strictly needed if provider updates state correctly)
        await notifier.getAllAnnouncements();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Announcement deleted successfully')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete announcement')),
          );
        }
      }
    }
  }

  void _handleViewDetails(AnnouncementModel announcement) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image
                if (announcement.image != null && announcement.fullImageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      announcement.fullImageUrl!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                    ),
                  )
                else
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                  ),
                const SizedBox(height: 20),
                // Title
                Text(
                  announcement.title,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Color(0xFF022F2A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                // Date & Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 18, color: Colors.black54),
                    const SizedBox(width: 6),
                    Text(
                      '${announcement.date.day}/${announcement.date.month}/${announcement.date.year}',
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(width: 18),
                    const Icon(Icons.location_on, size: 18, color: Colors.black54),
                    const SizedBox(width: 6),
                    Text(
                      announcement.location,
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    announcement.description,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 18),
                // Posted By
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, size: 18, color: Colors.black54),
                    const SizedBox(width: 6),
                    Text(
                      announcement.postedBy.name.isNotEmpty ? announcement.postedBy.name : 'Unknown',
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF08B9AF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurvedHeader extends StatelessWidget {
  const CurvedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopCurveClipper(),
      child: Container(
        height: 200, // Adjust as needed
        color: const Color(0xFFEBF0F0), // Teal-ish color from image
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16),
          child: Row(
            children: [
              const Icon(Icons.arrow_back, color: Colors.black, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Announcements',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 40); // Start down from top-left

    // Make the curve start lower and rise to the right side
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height + 20, // Control point (swollen left)
      size.width * 0.5,
      size.height - 10, // Mid point (smoother center)
    );

    path.quadraticBezierTo(
      size.width * 0.95,
      size.height - 50, // Control point (gentle right)
      size.width,
      size.height - 20, // End at top-right
    );

    path.lineTo(size.width, 0); // Top-right corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onViewDetails;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    required this.onEdit,
    required this.onDelete,
    required this.onViewDetails,
  });

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 395,
      height: 351,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Top label
          Positioned(
            top: 19,
            left: 15,
            child: SizedBox(
              width: 356,
              height: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDate(announcement.date),
                    style: const TextStyle(
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 1.0,
                      color: Color(0xFF022F2A),
                      height: 1.0,
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFB0000),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Title
          Positioned(
            top: 45,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                announcement.title,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: Color(0xFF022F2A),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),

          // Image + info
          Positioned(
            top: 100,
            left: 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Container(
                  width: 100,
                  height: 100,
                  color: const Color(0xFFE8E8E8),
                  child: announcement.image != null && announcement.fullImageUrl != null
                      ? Image.network(
                          announcement.fullImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        )
                      : const Icon(Icons.image_not_supported),
                ),
                const SizedBox(width: 13),

                // Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Date:',
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ' ${_formatDate(announcement.date)}',
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Location:',
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ' ${announcement.location}',
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom row: View details + icons
          Positioned(
            bottom: 20,
            left: 25,
            right: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // View Details Button
                GestureDetector(
                  onTap: onViewDetails,
                  child: Container(
                    width: 233,
                    height: 49,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: const Center(
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),

                // Icons
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.black),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnnounceFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const AnnounceFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: SizedBox(
          width: 170,
          height: 56,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF08B9AF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              shadowColor: Colors.black.withOpacity(0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Announce',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.4,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
