import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/verifier_application.dart';
import '../../services/verifier_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import 'application_detail_screen.dart';

class ModerationQueueScreen extends StatefulWidget {
  const ModerationQueueScreen({super.key});

  @override
  State<ModerationQueueScreen> createState() => _ModerationQueueScreenState();
}

class _ModerationQueueScreenState extends State<ModerationQueueScreen> {
  List<VerifierApplicationSummary>? _applications;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final apps = await VerifierService.instance.listPending();
      if (mounted) setState(() => _applications = apps);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.moderationQueueAppBarTitle)),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _load,
          child: _error != null
              ? ErrorBanner(message: _error!, onRetry: _load)
              : _applications == null
                  ? const CenteredLoader()
                  : _applications!.isEmpty
                      ? ListView(
                          children: [
                            const SizedBox(height: 80),
                            EmptyState(
                              icon: Icons.fact_check_outlined,
                              title: l10n.moderationQueueEmptyTitle,
                              subtitle: l10n.moderationQueueEmptySubtitle,
                            ),
                          ],
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _applications!.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final app = _applications![index];
                            return Card(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ApplicationDetailScreen(applicationId: app.applicationId),
                                    ),
                                  );
                                  _load();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 42,
                                        height: 42,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.insufficientBg,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(Icons.badge_outlined, color: AppColors.insufficient),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              l10n.moderationQueueRequestFrom(app.userId),
                                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              app.metadataFlags.isEmpty
                                                  ? l10n.moderationQueueNoSignals
                                                  : l10n.moderationQueueSignalsCount(app.metadataFlags.length),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: app.metadataFlags.isEmpty
                                                    ? AppColors.textMuted
                                                    : AppColors.insufficient,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.chevron_right, color: AppColors.textMuted),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
        ),
      ),
    );
  }
}
