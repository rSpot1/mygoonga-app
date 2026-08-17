import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user_profile.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

enum AuthStatus { unknown, signedOut, signedIn }

/// Etat global d'authentification et de profil applicatif, ecoute par toute
/// l'application (barre de navigation conditionnee par le role, acces aux
/// ecrans de moderation/administration, etc.)
class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _authService.authStateChanges.listen(_onAuthChanged);
  }

  final AuthService _authService = AuthService.instance;

  AuthStatus status = AuthStatus.unknown;
  User? firebaseUser;
  UserProfile? profile;
  bool isLoadingProfile = false;
  String? lastError;

  Future<void> _onAuthChanged(User? user) async {
    firebaseUser = user;
    if (user == null) {
      status = AuthStatus.signedOut;
      profile = null;
      notifyListeners();
      return;
    }
    status = AuthStatus.signedIn;
    notifyListeners();
    await refreshProfile();
  }

  Future<void> refreshProfile() async {
    isLoadingProfile = true;
    notifyListeners();
    try {
      profile = await UserService.instance.getMyProfile();
      lastError = null;
    } catch (e) {
      lastError = e.toString();
    } finally {
      isLoadingProfile = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
