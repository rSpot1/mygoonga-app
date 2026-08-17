class UserProfile {
  final String userId;
  final String? email;
  final String? displayName;
  final String role; // standard | verifier | moderator | admin
  final String verifierStatus; // none | pending | approved | rejected
  final int reputationScore;
  final String? declaredCity;
  final String preferredLanguage; // "fr" | "en"

  UserProfile({
    required this.userId,
    this.email,
    this.displayName,
    required this.role,
    required this.verifierStatus,
    required this.reputationScore,
    this.declaredCity,
    this.preferredLanguage = 'fr',
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      role: json['role'] as String? ?? 'standard',
      verifierStatus: json['verifierStatus'] as String? ?? 'none',
      reputationScore: (json['reputationScore'] as num?)?.toInt() ?? 0,
      declaredCity: json['declaredCity'] as String?,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'fr',
    );
  }

  bool get isVerifier => role == 'verifier' || role == 'moderator' || role == 'admin';
  bool get isModerator => role == 'moderator' || role == 'admin';
  bool get isAdmin => role == 'admin';
  bool get canApplyAsVerifier => role == 'standard' && verifierStatus != 'pending';
}
