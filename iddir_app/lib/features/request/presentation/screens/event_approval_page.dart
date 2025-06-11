import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/widgets/admin_bottom_navbar.dart';
import 'package:iddir_app/features/request/data/model/request_model.dart';
import '../providers/request_provider.dart';

class EventApprovalPage extends ConsumerStatefulWidget {
  const EventApprovalPage({super.key});

  @override
  ConsumerState<EventApprovalPage> createState() => _EventApprovalPageState();
}

class _EventApprovalPageState extends ConsumerState<EventApprovalPage> {
  @override
  void initState() {
    super.initState();
    // Fetch requests when the page loads
    Future.microtask(() =>
      ref.read(requestProvider.notifier).getAllRequests()
    );
  }

  @override
  Widget build(BuildContext context) {
    final requestsAsync = ref.watch(requestProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CurvedHeader(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: requestsAsync.when(
                data: (requests) => Column(
                  children: requests
                      .where((r) => r.status != 'rejected') // Hide rejected
                      .map((request) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CustomApprovalCard(
                              request: request,
                              showButtons: request.status == 'pending',
                              onApprove: () async {
                                final success = await ref
                                    .read(requestProvider.notifier)
                                    .updateRequestStatus(request.id, 'approved');
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Request approved')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Failed to approve request')),
                                  );
                                }
                              },
                              onReject: () async {
                                final success = await ref
                                    .read(requestProvider.notifier)
                                    .updateRequestStatus(request.id, 'rejected');
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Request rejected')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Failed to reject request')),
                                  );
                                }
                              },
                            ),
                          ))
                      .toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AdminBottomNavBar(),
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
        height: 200,
        color: const Color(0xFFEBF0F0),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16),
          child: Row(
            children: const [
              Icon(Icons.arrow_back, color: Colors.black, size: 28),
              SizedBox(width: 12),
              Text(
                'Event Request',
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
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height + 20,
      size.width * 0.5,
      size.height - 10,
    );
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height - 50,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CustomApprovalCard extends StatelessWidget {
  final RequestModel request;
  final bool showButtons;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  const CustomApprovalCard({
    super.key,
    required this.request,
    this.showButtons = true,
    this.onApprove,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 408,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(102, 116, 114, 114),
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            request.name,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            request.eventType,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ETB ${request.amount}',
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          if (showButtons) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 146,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: onApprove,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF08B9AF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Approve',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 146,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: onReject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00524D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}