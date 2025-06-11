import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    @JsonKey(name: '_id') required String id,
    required String? name,
    required String? email,
    @JsonKey(name: 'paymentStatus') required String? paymentStatus,
    String? paymentReceipt,
    @JsonKey(name: 'paymentApprovedAt') DateTime? paymentApprovedAt,
    @JsonKey(name: 'createdAt') required DateTime? createdAt,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);
}

extension PaymentModelExtension on PaymentModel {
  String? get fullReceiptUrl {
    if (paymentReceipt == null) return null;
    final baseUrl = 'http://localhost:5000'; // Your backend base URL

    // 1. Replace all backslashes with forward slashes
    final cleanedPath = paymentReceipt!.replaceAll("\\", '/');

    // 2. Remove any leading slash if it exists, to prevent double slashes (e.g., //uploads)
    final imagePath = cleanedPath.startsWith('/') ? cleanedPath.substring(1) : cleanedPath;

    // 3. Combine with baseUrl and the /public/ prefix
    return '$baseUrl/public/' + imagePath;
  }
}

@freezed
class PaymentDetails with _$PaymentDetails {
  const factory PaymentDetails({
    required String? paymentStatus,
    String? receiptUrl,
    DateTime? paymentApprovedAt,
  }) = _PaymentDetails;

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => _$PaymentDetailsFromJson(json);
}

@freezed
class PaymentStatistics with _$PaymentStatistics {
  const factory PaymentStatistics({
    required double inBank,
    required double overdue,
    required double pending,
  }) = _PaymentStatistics;

  factory PaymentStatistics.fromJson(Map<String, dynamic> json) => _$PaymentStatisticsFromJson(json);
}
