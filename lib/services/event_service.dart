import '../core/api_client.dart';
import '../models/local_event.dart';

class EventService {
  EventService._internal();
  static final EventService instance = EventService._internal();

  final _client = ApiClient.instance;

  Future<String> reportEvent({
    required String description,
    required String city,
    double? lat,
    double? lng,
    String? mediaUrl,
  }) async {
    try {
      final response = await _client.dio.post(
        '/events/report',
        data: {
          'description': description,
          'city': city,
          if (lat != null && lng != null) 'coordinates': {'lat': lat, 'lng': lng},
          if (mediaUrl != null) 'mediaUrl': mediaUrl,
        },
      );
      return response.data['eventId'] as String;
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  Future<List<EventSummary>> nearby({required double lat, required double lng, double? radiusKm}) async {
    try {
      final response = await _client.dio.get(
        '/events/nearby',
        queryParameters: {
          'lat': lat,
          'lng': lng,
          if (radiusKm != null) 'radiusKm': radiusKm,
        },
      );
      return (response.data as List)
          .map((e) => EventSummary.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  Future<EventDetail> getDetail(String eventId) async {
    try {
      final response = await _client.dio.get('/events/$eventId');
      return EventDetail.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  Future<String> flag(String eventId, {required String type, String? comment}) async {
    try {
      final response = await _client.dio.post(
        '/events/$eventId/flag',
        data: {'type': type, if (comment != null && comment.isNotEmpty) 'comment': comment},
      );
      return response.data['newAggregatedStatus'] as String;
    } catch (e) {
      throw _client.mapError(e);
    }
  }
}
