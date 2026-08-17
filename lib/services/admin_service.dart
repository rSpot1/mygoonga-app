import '../core/api_client.dart';
import '../models/user_profile.dart';

class AdminService {
  AdminService._internal();
  static final AdminService instance = AdminService._internal();

  final _client = ApiClient.instance;

  Future<List<UserProfile>> listUsers({String? role}) async {
    try {
      final response = await _client.dio.get(
        '/admin/users',
        queryParameters: {if (role != null) 'role': role},
      );
      return (response.data as List)
          .map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  Future<UserProfile> updateRole(String userId, {required String role, String? reason}) async {
    try {
      final response = await _client.dio.patch(
        '/admin/users/$userId/role',
        data: {'role': role, if (reason != null && reason.isNotEmpty) 'reason': reason},
      );
      return UserProfile.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  Future<List<Map<String, dynamic>>> auditLog() async {
    try {
      final response = await _client.dio.get('/admin/audit-log');
      return (response.data as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw _client.mapError(e);
    }
  }
}
