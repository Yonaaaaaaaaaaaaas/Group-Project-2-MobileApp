import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../models/payment_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart'; // For Uint8List

class PaymentRemoteDatasource {
  final Dio dio;
  PaymentRemoteDatasource(this.dio);

  Future<PaymentDetails> getPaymentDetails(String token) async {
    try {
      final response = await dio.get('/payments/details', options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));
      
      return PaymentDetails.fromJson(response.data);
    } on DioException catch (e) {
      print('GetPaymentDetails error: ${e.response?.data}');
      throw 'Failed to get payment details: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<List<PaymentModel>> getPendingPayments(String token) async {
    try {
      final response = await dio.get('/payments/pending', options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));
      
      print('Raw pending payments response: ${response.data}');

      final List<dynamic> paymentsJson = response.data;
      return paymentsJson.map((json) => PaymentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      print('GetPendingPayments error: ${e.response?.data}');
      throw 'Failed to get pending payments: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<bool> updatePaymentStatus({
    required String token,
    required String userId,
    required String status,
  }) async {
    try {
      await dio.put(
        '/payments/$userId/status',
        data: {'status': status},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return true;
    } on DioException catch (e) {
      print('UpdatePaymentStatus error: ${e.response?.data}');
      throw 'Failed to update payment status: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred';
    }
  }

  Future<String> uploadReceipt({
    required String token,
    String? filePath,
    Uint8List? imageBytes,
    String? fileName,
  }) async {
    try {
      MultipartFile? receiptFile;
      String? actualFileName;

      if (kIsWeb) {
        if (imageBytes == null || fileName == null) {
          throw 'Image bytes or file name are missing for web upload.';
        }
        final fileType = fileName.split('.').last;
        receiptFile = MultipartFile.fromBytes(
          imageBytes,
          filename: fileName,
          contentType: MediaType('image', fileType),
        );
        actualFileName = fileName;
      } else {
        if (filePath == null) {
          throw 'File path is missing for non-web upload.';
        }
        actualFileName = filePath.split('/').last;
        final fileType = actualFileName.split('.').last;
        receiptFile = await MultipartFile.fromFile(
          filePath,
          filename: actualFileName,
          contentType: MediaType('image', fileType),
        );
      }

      final formData = FormData.fromMap({
        'receipt': receiptFile,
      });

      final response = await dio.post(
        '/payments/upload',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      
      return response.data['receiptUrl'];
    } on DioException catch (e) {
      print('UploadReceipt error: ${e.response?.data}');
      throw 'Failed to upload receipt: ${e.message}';
    } catch (e) {
      print('Unexpected error: $e');
      throw 'An unexpected error occurred: $e';
    }
  }
}
