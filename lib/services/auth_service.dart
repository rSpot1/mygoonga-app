import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/api_client.dart';

/// Encapsule Firebase Auth (email/mot de passe + Google Sign-In) et la
/// synchronisation du profil applicatif via POST /auth/sync, appelee
/// systematiquement apres une connexion reussie.
class AuthService {
  AuthService._internal();
  static final AuthService instance = AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<UserCredential> registerWithEmail(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _syncProfile();
    return credential;
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    await _syncProfile();
    return credential;
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // annulé par l'utilisateur

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final result = await _auth.signInWithCredential(credential);
    await _syncProfile();
    return result;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  /// POST /auth/sync : cree ou retrouve le profil applicatif correspondant
  /// au compte Firebase qui vient de se connecter.
  Future<void> _syncProfile() async {
    try {
      await ApiClient.instance.dio.post('/auth/sync');
    } catch (_) {
      // Non bloquant pour la connexion elle-meme : le profil sera
      // re-synchronise a la prochaine tentative (ex: ecran Profil).
    }
  }
}
