import 'dart:async';

import 'package:dio/dio.dart';

import '../core/api_client.dart';
import '../models/media_analysis.dart';

class MediaService {
  MediaService._internal();
  static final MediaService instance = MediaService._internal();

  final _client = ApiClient.instance;

  /// POST /media/analyze (multipart) : soumet un fichier, avec un contexte
  /// optionnel decrivant d'ou provient le contenu (ex: "reçu sur WhatsApp").
  Future<String> submitMedia({required String filePath, String? context, String? fileName}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
        if (context != null && context.isNotEmpty) 'context': context,
      });
      final response = await _client.dio.post('/media/analyze', data: formData);
      return response.data['analysisId'] as String;
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  Future<MediaAnalysis> getAnalysis(String analysisId) async {
    try {
      final response = await _client.dio.get('/media/analyze/$analysisId');
      return MediaAnalysis.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  /// Interroge periodiquement le resultat jusqu'a ce que l'analyse (traitement
  /// asynchrone cote serveur) soit terminee, ou jusqu'au delai maximal.
  Future<MediaAnalysis> waitForResult(
    String analysisId, {
    Duration interval = const Duration(seconds: 2),
    Duration timeout = const Duration(seconds: 45),
  }) async {
    final deadline = DateTime.now().add(timeout);
    MediaAnalysis last = await getAnalysis(analysisId);
    while (last.isProcessing && DateTime.now().isBefore(deadline)) {
      await Future.delayed(interval);
      last = await getAnalysis(analysisId);
    }
    return last;
  }

  Future<void> requestHumanReview(String analysisId) async {
    try {
      await _client.dio.post('/media/analyze/$analysisId/request-human-review');
    } catch (e) {
      throw _client.mapError(e);
    }
  }
}
