import '../core/api_client.dart';
import '../models/user_profile.dart';

class UserService {
  UserService._internal();
  static final UserService instance = UserService._internal();

  final _client = ApiClient.instance;

  Future<UserProfile> getMyProfile() async {
    try {
      final response = await _client.dio.get('/users/me');
      return UserProfile.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw _client.mapError(e);
    }
  }

  Future<UserProfile> updateMyProfile({
    String? displayName,
    String? declaredCity,
    String? preferredLanguage,
  }) async {
    try {
      final response = await _client.dio.patch(
        '/users/me',
        data: {
          if (displayName != null) 'displayName': displayName,
          if (declaredCity != null) 'declaredCity': declaredCity,
          if (preferredLanguage != null) 'preferredLanguage': preferredLanguage,
        },
      );
      return UserProfile.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw _client.mapError(e);
    }
  }
}
