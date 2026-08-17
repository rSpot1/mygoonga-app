import 'package:dio/dio.dart';

import '../core/api_client.dart';
import '../models/verifier_application.dart';

class VerifierService {
  VerifierService._internal();
  static final VerifierService instance = VerifierService._internal();

  final _client = ApiClient.instance;

  /// POST /verifiers/apply (multipart) : soumet une demande de statut
  /// verificateur avec les trois pieces requises (§7.2 du cahier des charges).
  Future<String> apply({
    required String phoneNumber,
    required String cniFrontPath,
    required String cniBackPath,
    required String verificationPhotoPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'phoneNumber': phoneNumber,
        'cniFront': await MultipartFile.fromFile(cniFrontPath),
        'cniBack': await MultipartFile.fromFile(cniBackPath),
        'verificationPhoto': await MultipartFile.fromFile(verificationPhotoPath),
      });
      final response = await _client.dio.post('/verifiers/apply', data: formData);
      return response.data['applicationId'] as String;
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  /// GET /verifiers/applications — reserve aux modérateurs et admins.
  Future<List<VerifierApplicationSummary>> listPending() async {
    try {
      final response = await _client.dio.get('/verifiers/applications');
      return (response.data as List)
          .map((e) => VerifierApplicationSummary.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  Future<VerifierApplicationDetail> getDetail(String applicationId) async {
    try {
      final response = await _client.dio.get('/verifiers/applications/$applicationId');
      return VerifierApplicationDetail.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  Future<void> review(String applicationId, {required String decision, String? reason}) async {
    try {
      await _client.dio.post(
        '/verifiers/applications/$applicationId/review',
        data: {'decision': decision, if (reason != null && reason.isNotEmpty) 'reason': reason},
      );
    } catch (e) {
      throw _client.mapError(e);
    }
  }
}
