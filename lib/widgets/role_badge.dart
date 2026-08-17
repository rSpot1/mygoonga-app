import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';

class RoleBadge extends StatelessWidget {
  final String role;

  const RoleBadge({super.key, required this.role});

  ({Color color, IconData icon}) get _style {
    switch (role) {
      case 'verifier':
        return (color: AppColors.verifierGold, icon: Icons.verified);
      case 'moderator':
        return (color: AppColors.brand, icon: Icons.shield_outlined);
      case 'admin':
        return (color: AppColors.brandDark, icon: Icons.admin_panel_settings_outlined);
      default:
        return (color: AppColors.textMuted, icon: Icons.person_outline);
    }
  }

  String _label(AppLocalizations l10n) {
    switch (role) {
      case 'verifier':
        return l10n.roleVerifier;
      case 'moderator':
        return l10n.roleModerator;
      case 'admin':
        return l10n.roleAdmin;
      default:
        return l10n.roleStandard;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _style;
    final label = _label(AppLocalizations.of(context)!);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: s.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(s.icon, size: 14, color: s.color),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: s.color, fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }
}
