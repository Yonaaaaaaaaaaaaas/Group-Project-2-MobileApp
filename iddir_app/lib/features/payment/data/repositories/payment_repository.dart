import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../models/payment_model.dart';
import '../data_sources/payment_remote_datasource.dart';
import 'package:flutter/services.dart'; // For Uint8List

part 'payment_repository.g.dart';

@riverpod
class PaymentRepository extends _$PaymentRepository {
  late final PaymentRemoteDatasource _datasource;

  @override
  PaymentRemoteDatasource build(Dio dio) {
    _datasource = PaymentRemoteDatasource(dio);
    return _datasource;
  }

  Future<PaymentDetails?> getPaymentDetails({required String token}) async {
    try {
      return await _datasource.getPaymentDetails(token);
    } catch (e) {
      return null;
    }
  }

  Future<List<PaymentModel>?> getPendingPayments({required String token}) async {
    try {
      return await _datasource.getPendingPayments(token);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updatePaymentStatus({
    required String token,
    required String userId,
    required String status,
  }) async {
    try {
      return await _datasource.updatePaymentStatus(
        token: token,
        userId: userId,
        status: status,
      );
    } catch (e) {
      return false;
    }
  }

  Future<String?> uploadReceipt({
    required String token,
    String? filePath,
    Uint8List? imageBytes,
    String? fileName,
  }) async {
    try {
      return await _datasource.uploadReceipt(
        token: token,
        filePath: filePath,
        imageBytes: imageBytes,
        fileName: fileName,
      );
    } catch (e) {
      return null;
    }
  }
}
