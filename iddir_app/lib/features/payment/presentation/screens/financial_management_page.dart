import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/widgets/admin_bottom_navbar.dart';
import 'package:iddir_app/features/payment/data/models/payment_model.dart'; // Import PaymentModel
import '../providers/payment_provider.dart';

class FinancialManagementPage extends ConsumerStatefulWidget {
  const FinancialManagementPage({super.key});

  @override
  ConsumerState<FinancialManagementPage> createState() => _FinancialManagementPageState();
}

class _FinancialManagementPageState extends ConsumerState<FinancialManagementPage> {
  @override
  void initState() {
    super.initState();
    // Initialize data
    Future.microtask(() {
      ref.read(paymentDetailsProvider.notifier).getPaymentDetails();
      ref.read(pendingPaymentsProvider.notifier).getPendingPayments();
    });
  }

  void _showReceiptModal(BuildContext context, PaymentModel payment) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Consumer(builder: (context, ref, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Payment from ${payment.name ?? 'Unknown User'}',
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (payment.fullReceiptUrl != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          payment.fullReceiptUrl!,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.contain, // Use contain to see full image
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ] else ...[
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'No receipt image available.',
                            style: TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    Text(
                      'Amount: ETB 5,000', // TODO: Get actual amount from backend
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(dialogContext).pop(); // Close modal
                              final success = await ref
                                  .read(pendingPaymentsProvider.notifier)
                                  .updatePaymentStatus(payment.id, 'paid');
                              if (success && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Payment approved successfully'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF08B9AF), // Approve color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Approve',
                              style: TextStyle(
                                fontFamily: 'Instrument Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white, // Changed to white for better contrast
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(dialogContext).pop(); // Close modal
                              final success = await ref
                                  .read(pendingPaymentsProvider.notifier)
                                  .updatePaymentStatus(payment.id, 'unpaid');
                              if (success && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Payment rejected'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Reject',
                              style: TextStyle(
                                fontFamily: 'Instrument Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentDetails = ref.watch(paymentDetailsProvider);
    final pendingPayments = ref.watch(pendingPaymentsProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(paymentDetailsProvider.notifier).getPaymentDetails();
          await ref.read(pendingPaymentsProvider.notifier).getPendingPayments();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CurvedHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    paymentDetails.when(
                      data: (details) => Column(
                        children: [
                          CustomBankCard(
                            icon: Icons.money_off_outlined,
                            label: 'In the Bank',
                            amount: 'ETB 10,000', // TODO: Get from backend
                          ),
                          const SizedBox(height: 20),
                          CustomBankCard(
                            icon: Icons.money,
                            label: 'Overdue',
                            amount: 'ETB 50,000', // TODO: Get from backend
                          ),
                          const SizedBox(height: 20),
                          CustomBankCard(
                            icon: Icons.money_off,
                            label: 'Pending',
                            amount: 'ETB 20,000', // TODO: Get from backend
                          ),
                        ],
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pending Payments',
                            style: TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          pendingPayments.when(
                            data: (payments) {
                              if (payments == null || payments.isEmpty) {
                                return const Center(
                                  child: Text('No pending payments'),
                                );
                              }
                              return Column(
                                children: payments.map((payment) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => _showReceiptModal(context, payment),
                                              child: payment.fullReceiptUrl != null
                                                  ? ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Image.network(
                                                        payment.fullReceiptUrl!,
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                                          Icons.broken_image,
                                                          size: 30,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: const Icon(
                                                        Icons.image,
                                                        size: 30,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  payment.name ?? 'N/A',
                                                  style: const TextStyle(
                                                    fontFamily: 'Instrument Sans',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'ETB 5,000', // TODO: Get actual amount from backend
                                                  style: const TextStyle(
                                                    fontFamily: 'Instrument Sans',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Move the buttons inside the modal
                                        ElevatedButton(
                                          onPressed: () => _showReceiptModal(context, payment),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF08B9AF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Check',
                                            style: TextStyle(
                                              fontFamily: 'Instrument Sans',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                            loading: () => const Center(child: CircularProgressIndicator()),
                            error: (error, stack) => Center(child: Text('Error: $error')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
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
        height: 200, // Adjust as needed
        color: const Color(0xFFEBF0F0), // Teal-ish color from image
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16),
          child: Row(
            children: [
              const Icon(Icons.arrow_back, color: Colors.black, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Financial Management',
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

class CustomBankCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;
  final Color backgroundColor;
  final Color iconColor;

  const CustomBankCard({
    super.key,
    required this.icon,
    required this.label,
    required this.amount,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 408,
      height: 111,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000), // #0000004D
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Color(0x42000000), // #00000026
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  amount,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
