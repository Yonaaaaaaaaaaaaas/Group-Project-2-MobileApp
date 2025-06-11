import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/widgets/bottom_navbar.dart';
import 'package:iddir_app/features/announcement/data/models/announcement_model.dart';
import '../providers/announcement_provider.dart';

class AnnouncementPage extends ConsumerStatefulWidget {
  const AnnouncementPage({super.key});

  @override
  ConsumerState<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends ConsumerState<AnnouncementPage> {
  @override
  void initState() {
    super.initState();
    // Fetch announcements when the page is first opened
    Future.microtask(
      () => ref.read(announcementProvider.notifier).getAllAnnouncements(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final announcementsState = ref.watch(announcementProvider);
    return Scaffold(
      body: announcementsState.when(
        data:
            (announcements) => SingleChildScrollView(
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
                    ...announcements.map(
                      (announcement) => Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: 395,
                          height: 351,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF0F0),
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
                                // Top left date/time label
                                Positioned(
                                  top: 19,
                                  left: 15,
                                  child: SizedBox(
                                    width: 356,
                                    height: 16,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _formatDate(announcement.date),
                                            style: const TextStyle(
                                              fontFamily: 'Product Sans',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              letterSpacing: 1.0,
                                              color: Color(0xFF022F2A),
                                              height: 1.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
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
                                // Center title text
                                Positioned(
                                  top: 45,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        announcement.title,
                                        style: const TextStyle(
                                          fontFamily: 'Instrument Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 32,
                                          height: 1.0,
                                          letterSpacing: 0,
                                          color: Color(0xFF022F2A),
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                // Row with image and info box
                                Positioned(
                                  top: 100,
                                  left: 25,
                                  child: SizedBox(
                                    width: 345, // Adjusted to prevent overflow
                                    height: 182,
                                    child: Row(
                                      children: [
                                        // Announcement image
                                        SizedBox(
                                          width: 163,
                                          height: 167,
                                          child: Container(
                                            color: const Color(
                                              0xFFE8E8E8,
                                            ).withOpacity(0.68),
                                            child:
                                                announcement.image != null &&
                                                        announcement
                                                                .fullImageUrl !=
                                                            null
                                                    ? Image.network(
                                                      announcement
                                                          .fullImageUrl!,
                                                      height: 167,
                                                      width: 163,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => const Icon(
                                                            Icons
                                                                .image_not_supported,
                                                            size: 48,
                                                          ),
                                                    )
                                                    : const Icon(
                                                      Icons.image_not_supported,
                                                      size: 48,
                                                    ),
                                          ),
                                        ),
                                        const SizedBox(width: 13),
                                        // Info container
                                        Expanded(
                                          child: SizedBox(
                                            height: 182,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _formatDate(
                                                      announcement.date,
                                                    ),
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          'Instrument Sans',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18,
                                                      height: 1.0,
                                                      letterSpacing: 0,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Text(
                                                    announcement.location,
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          'Instrument Sans',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18,
                                                      height: 1.0,
                                                      letterSpacing: 0,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Dropdown icon
                                Positioned(
                                  top: 237,
                                  left: 267,
                                  child: GestureDetector(
                                    onTap:
                                        () => showAnnouncementDetailsModal(
                                          context,
                                          announcement,
                                        ),
                                    child: Container(
                                      width: 36,
                                      height: 22,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 1,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          238,
                                          236,
                                          236,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 15),
                  const EventCard(),
                  const SizedBox(height: 15),
                  const EventCard2(),
                  const SizedBox(height: 15),
                  const EventCard3(),
                ],
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed:
                        () =>
                            ref
                                .read(announcementProvider.notifier)
                                .getAllAnnouncements(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 395,
        height: 351,
        decoration: BoxDecoration(
          color: const Color(0xFFEBF0F0), // #E8E8E8AD
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000), // #00000040
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Top left date/time label
            Positioned(
              top: 19,
              left: 15,
              child: Container(
                width: 356,
                height: 16,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'DECEMBER 16, 9:10 PM',
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        letterSpacing:
                            1.0, // Flutter's letterSpacing is in logical pixels
                        color: Color(0xFF022F2A),
                        height: 1.0,
                      ),
                    ),
                    SizedBox(width: 5), // Space between text and circle

                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFFB0000,
                        ), // Teal-ish color from image
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Center title text
            Positioned(
              top: 45,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    'Funeral Service',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color(0xFF022F2A),
                    ),
                  ),
                ),
              ),
            ),

            // Row with image and info box
            Positioned(
              top: 100,
              left: 25,
              child: Row(
                children: [
                  // Image placeholder
                  Container(
                    width: 163,
                    height: 167,
                    color: Color(
                      0xFFE8E8E8,
                    ).withOpacity(0.68), // Replace with actual image
                    child: Image.asset(
                      'assets/images/profile.png',
                      height: 167,
                      width: 163,
                    ),
                  ),
                  const SizedBox(width: 13),

                  // Info container
                  Container(
                    width: 171,
                    height: 182,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          '10 Jan 2023',
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            height: 1.0,
                            letterSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Shiromeda church',
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            height: 1.0,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Dropdown icon
            Positioned(
              top: 237,
              left: 267,
              child: Container(
                width: 36,
                height: 22,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 236, 236),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard2 extends StatelessWidget {
  const EventCard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 395,
        decoration: BoxDecoration(
          color: const Color(0xFFEBF0F0),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top date/time
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'DECEMBER 16, 9:10 PM',
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    letterSpacing: 1.0,
                    color: Color(0xFF022F2A),
                    height: 1.0,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Title
              Center(
                child: Text(
                  'MONTHLY GATHERING',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    height: 1.0,
                    letterSpacing: 0,
                    color: Color(0xFF022F2A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              // Paragraph container (auto-height)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'We gather to discuss about annual payment. All members are requested to pay their respects and participate in the service.',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    height: 1.4,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventCard3 extends StatelessWidget {
  const EventCard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 395,
        decoration: BoxDecoration(
          color: const Color(
            0xFF367B36,
          ).withOpacity(0.8), // Light green background
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top date/time
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'DECEMBER 16, 9:10 PM',
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        letterSpacing: 1.0,
                        color: Colors.white,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'Notice',
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        letterSpacing: 1.0,
                        color: Color(0xFFC31D1D),
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Title
              Center(
                child: Text(
                  'MONTHLY GATHERING',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    height: 1.0,
                    letterSpacing: 0,
                    color: Color(0xFF022F2A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              // Paragraph container (auto-height)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'We ask you kindly to pay 200 birr for your monthly fee in a week, if you pass the due date 50 additional fee is required',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    height: 1.4,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showAnnouncementDetailsModal(
  BuildContext context,
  AnnouncementModel announcement,
) {
  showDialog(
    context: context,
    builder:
        (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
                  if (announcement.image != null &&
                      announcement.fullImageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        announcement.fullImageUrl!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.image_not_supported,
                              size: 80,
                              color: Colors.grey,
                            ),
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
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 80,
                        color: Colors.grey,
                      ),
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
                      const Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        announcement.date.toString().split(' ')[0],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 18),
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          announcement.location,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
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
                        'Posted by ${announcement.postedBy.name.isNotEmpty ? announcement.postedBy.name : 'Member'}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
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
