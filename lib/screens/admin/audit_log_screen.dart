import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/admin_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({super.key});

  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  List<Map<String, dynamic>>? _entries;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final entries = await AdminService.instance.auditLog();
      if (mounted) setState(() => _entries = entries);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.auditLogAppBarTitle)),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _load,
          child: _error != null
              ? ErrorBanner(message: _error!, onRetry: _load)
              : _entries == null
                  ? const CenteredLoader()
                  : _entries!.isEmpty
                      ? ListView(
                          children: [
                            const SizedBox(height: 80),
                            EmptyState(icon: Icons.history_outlined, title: l10n.auditLogEmptyTitle),
                          ],
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _entries!.length,
                          separatorBuilder: (_, __) => const Divider(height: 20),
                          itemBuilder: (context, index) {
                            final e = _entries![index];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.fingerprint, size: 18, color: AppColors.textMuted),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${e['action'] ?? ''}',
                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        l10n.auditLogByLabel(
                                          '${e['accessedBy'] ?? '—'}',
                                          '${e['targetCollection'] ?? ''}',
                                          '${e['targetId'] ?? ''}',
                                        ),
                                        style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted),
                                      ),
                                      Text(
                                        '${e['accessedAt'] ?? ''}',
                                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
        ),
      ),
    );
  }
}
