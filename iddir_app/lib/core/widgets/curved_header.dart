// class CurvedHeader extends StatelessWidget {
//   const CurvedHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ClipPath(
//       clipper: TopCurveClipper(),
//       child: Container(
//         height: 200, // Adjust as needed
//         color: const Color(0xFFEBF0F0), // Teal-ish color from image
//         child: Padding(
//           padding: const EdgeInsets.only(top: 50, left: 16),
//           child: Row(
//             children: [
//               const Icon(Icons.arrow_back, color: Colors.black, size: 28),
//               const SizedBox(width: 12),
//               const Text(
//                 'Announcement details',
//                 style: TextStyle(
//                   fontFamily: 'Instrument Sans',
//                   fontWeight: FontWeight.w600,
//                   fontSize: 24,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TopCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();

//     path.lineTo(0, size.height - 40); // Start down from top-left

//     // Make the curve start lower and rise to the right side
//     path.quadraticBezierTo(
//       size.width * 0.05,
//       size.height + 20, // Control point (swollen left)
//       size.width * 0.5,
//       size.height - 10, // Mid point (smoother center)
//     );

//     path.quadraticBezierTo(
//       size.width * 0.95,
//       size.height - 50, // Control point (gentle right)
//       size.width,
//       size.height - 20, // End at top-right
//     );

//     path.lineTo(size.width, 0); // Top-right corner
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }
