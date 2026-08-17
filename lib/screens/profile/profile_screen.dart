import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';
import '../../services/user_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/role_badge.dart';
import '../admin/admin_users_screen.dart';
import '../admin/audit_log_screen.dart';
import '../moderation/moderation_queue_screen.dart';
import '../verifier/become_verifier_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _changeLanguage(BuildContext context, String code) async {
    // Applique immediatement en local (persistance locale via LocaleProvider),
    // puis synchronise avec le profil serveur en arriere-plan. Si la
    // synchronisation serveur echoue (ex: hors-ligne), la langue reste
    // appliquee localement : on ne bloque jamais l'utilisateur pour ca.
    await context.read<LocaleProvider>().setLanguageCode(code);
    try {
      await UserService.instance.updateMyProfile(preferredLanguage: code);
      if (context.mounted) {
        await context.read<AuthProvider>().refreshProfile();
      }
    } catch (_) {
      // Echec silencieux : la preference reste appliquee localement.
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final profile = auth.profile;
    final l10n = AppLocalizations.of(context)!;
    final currentLanguage = context.watch<LocaleProvider>().locale.languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: SafeArea(
        child: auth.isLoadingProfile && profile == null
            ? const Center(child: CircularProgressIndicator(strokeWidth: 2.4))
            : RefreshIndicator(
                onRefresh: auth.refreshProfile,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.brand.withValues(alpha: 0.12),
                          child: Text(
                            (profile?.displayName?.isNotEmpty == true
                                    ? profile!.displayName![0]
                                    : (profile?.email?.isNotEmpty == true ? profile!.email![0] : '?'))
                                .toUpperCase(),
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.brand),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile?.displayName ?? profile?.email ?? l10n.profileDefaultUser,
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              if (profile != null) RoleBadge(role: profile.role),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    if (profile != null) ...[
                      _ProfileInfoTile(
                        icon: Icons.mail_outline,
                        label: l10n.profileEmailLabel,
                        value: profile.email ?? '—',
                      ),
                      _ProfileInfoTile(
                        icon: Icons.location_city_outlined,
                        label: l10n.profileCityLabel,
                        value: profile.declaredCity ?? l10n.profileCityUnknown,
                      ),
                      _ProfileInfoTile(
                        icon: Icons.star_outline,
                        label: l10n.profileReputationLabel,
                        value: '${profile.reputationScore}',
                      ),
                      const SizedBox(height: 10),
                      _LanguageTile(
                        label: l10n.profileLanguageLabel,
                        currentLanguage: currentLanguage,
                        frenchLabel: l10n.profileLanguageFrench,
                        englishLabel: l10n.profileLanguageEnglish,
                        onChanged: (code) => _changeLanguage(context, code),
                      ),
                      const SizedBox(height: 20),
                      if (profile.verifierStatus == 'pending')
                        _StatusBanner(
                          icon: Icons.hourglass_top_outlined,
                          color: AppColors.insufficient,
                          text: l10n.profileVerifierPending,
                        )
                      else if (profile.verifierStatus == 'rejected')
                        _StatusBanner(
                          icon: Icons.info_outline,
                          color: AppColors.doubtful,
                          text: l10n.profileVerifierRejected,
                        )
                      else if (profile.canApplyAsVerifier)
                        _ActionCard(
                          icon: Icons.verified_outlined,
                          title: l10n.profileBecomeVerifierTitle,
                          subtitle: l10n.profileBecomeVerifierSubtitle,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const BecomeVerifierScreen()),
                          ),
                        ),
                      if (profile.isModerator) ...[
                        const SizedBox(height: 10),
                        _ActionCard(
                          icon: Icons.fact_check_outlined,
                          title: l10n.profileModerationQueueTitle,
                          subtitle: l10n.profileModerationQueueSubtitle,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ModerationQueueScreen()),
                          ),
                        ),
                      ],
                      if (profile.isAdmin) ...[
                        const SizedBox(height: 10),
                        _ActionCard(
                          icon: Icons.manage_accounts_outlined,
                          title: l10n.profileUserManagementTitle,
                          subtitle: l10n.profileUserManagementSubtitle,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const AdminUsersScreen()),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _ActionCard(
                          icon: Icons.history_outlined,
                          title: l10n.profileAuditLogTitle,
                          subtitle: l10n.profileAuditLogSubtitle,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const AuditLogScreen()),
                          ),
                        ),
                      ],
                    ],
                    const SizedBox(height: 28),
                    OutlinedButton.icon(
                      onPressed: () => context.read<AuthProvider>().signOut(),
                      icon: const Icon(Icons.logout, size: 18, color: AppColors.doubtful),
                      label: Text(l10n.profileSignOut, style: const TextStyle(color: AppColors.doubtful)),
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.doubtfulBg)),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileInfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 19, color: AppColors.textMuted),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

/// Selecteur de langue (FR/EN), style boutons segmentes coherent avec le
/// reste des tuiles du profil.
class _LanguageTile extends StatelessWidget {
  final String label;
  final String currentLanguage;
  final String frenchLabel;
  final String englishLabel;
  final ValueChanged<String> onChanged;

  const _LanguageTile({
    required this.label,
    required this.currentLanguage,
    required this.frenchLabel,
    required this.englishLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.language_outlined, size: 19, color: AppColors.textMuted),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary)),
        const Spacer(),
        _LanguageSegmentedButton(
          currentLanguage: currentLanguage,
          frenchLabel: frenchLabel,
          englishLabel: englishLabel,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _LanguageSegmentedButton extends StatelessWidget {
  final String currentLanguage;
  final String frenchLabel;
  final String englishLabel;
  final ValueChanged<String> onChanged;

  const _LanguageSegmentedButton({
    required this.currentLanguage,
    required this.frenchLabel,
    required this.englishLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageOptionChip(
            label: 'FR',
            selected: currentLanguage == 'fr',
            onTap: () => onChanged('fr'),
          ),
          _LanguageOptionChip(
            label: 'EN',
            selected: currentLanguage == 'en',
            onTap: () => onChanged('en'),
          ),
        ],
      ),
    );
  }
}

class _LanguageOptionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOptionChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.brand : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _StatusBanner({required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: color))),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.brand.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 21, color: AppColors.brand),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
