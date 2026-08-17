import 'package:flutter/material.dart';

/// Palette inspiree des messageries de reference (bleu profond type Telegram,
/// vert sobre type WhatsApp) mais recomposee pour une identite propre a MyGoonga :
/// un bleu-teal profond comme couleur de marque, des surfaces neutres et
/// generalement claires, des accents de statut nets (fiable / douteux / incertain).
class AppColors {
  AppColors._();

  // Couleur de marque
  static const Color brand = Color(0xFF0E7C7B); // teal profond
  static const Color brandDark = Color(0xFF0A5F5E);
  static const Color brandLight = Color(0xFF14A3A1);

  // Neutres (mode clair)
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFEFF2F5);
  static const Color border = Color(0xFFE2E6EA);
  static const Color textPrimary = Color(0xFF13202B);
  static const Color textSecondary = Color(0xFF5B6A76);
  static const Color textMuted = Color(0xFF8B98A3);

  // Neutres (mode sombre)
  static const Color backgroundDark = Color(0xFF0E1621);
  static const Color surfaceDark = Color(0xFF17212B);
  static const Color surfaceAltDark = Color(0xFF1E2A36);
  static const Color borderDark = Color(0xFF263340);
  static const Color textPrimaryDark = Color(0xFFF3F6F8);
  static const Color textSecondaryDark = Color(0xFFA8B6C1);
  static const Color textMutedDark = Color(0xFF71818D);

  // Statuts (bulles de statut agrege des evenements / cohérence media)
  static const Color reliable = Color(0xFF1FA971);
  static const Color reliableBg = Color(0xFFE4F7EE);
  static const Color doubtful = Color(0xFFD64545);
  static const Color doubtfulBg = Color(0xFFFBEAEA);
  static const Color insufficient = Color(0xFFB8860B);
  static const Color insufficientBg = Color(0xFFFBF3DE);

  static const Color verifierGold = Color(0xFFC79A2E);
  static const Color danger = Color(0xFFD64545);
  static const Color success = Color(0xFF1FA971);
}
