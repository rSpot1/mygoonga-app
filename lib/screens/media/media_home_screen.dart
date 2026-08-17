import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_colors.dart';
import 'media_analyze_screen.dart';

class MediaHomeScreen extends StatelessWidget {
  const MediaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.mediaHomeTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              // Image heros remplacant l'icone Material placeholder. Placez le
              // fichier fourni dans assets/icons/analyze_hero.png (voir README,
              // section "Image héro"). Si le fichier est absent, on retombe sur
              // l'icone d'origine pour ne jamais casser l'ecran.
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/icons/analyze_hero.png',
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 64,
                    width: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.brand.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.image_search, size: 32, color: AppColors.brand),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.mediaHomeHeading,
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.mediaHomeBody,
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
              ),
              const SizedBox(height: 28),
              _InfoRow(
                icon: Icons.fingerprint,
                title: l10n.mediaHomeInfoMetadataTitle,
                subtitle: l10n.mediaHomeInfoMetadataSubtitle,
              ),
              const SizedBox(height: 14),
              _InfoRow(
                icon: Icons.grid_view_outlined,
                title: l10n.mediaHomeInfoElaTitle,
                subtitle: l10n.mediaHomeInfoElaSubtitle,
              ),
              const SizedBox(height: 14),
              _InfoRow(
                icon: Icons.travel_explore_outlined,
                title: l10n.mediaHomeInfoReverseTitle,
                subtitle: l10n.mediaHomeInfoReverseSubtitle,
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MediaAnalyzeScreen()),
                ),
                icon: const Icon(Icons.add_photo_alternate_outlined, size: 20),
                label: Text(l10n.mediaHomeChooseFileButton),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  l10n.mediaHomeShareTip,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoRow({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 19, color: AppColors.brand),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}
