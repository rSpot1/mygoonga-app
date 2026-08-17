import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/media_analysis.dart';
import '../../services/media_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';

class MediaResultScreen extends StatefulWidget {
  final String analysisId;

  const MediaResultScreen({super.key, required this.analysisId});

  @override
  State<MediaResultScreen> createState() => _MediaResultScreenState();
}

class _MediaResultScreenState extends State<MediaResultScreen> {
  MediaAnalysis? _result;
  String? _error;
  bool _isRequestingReview = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final result = await MediaService.instance.waitForResult(widget.analysisId);
      if (mounted) setState(() => _result = result);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _requestHumanReview() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isRequestingReview = true);
    try {
      await MediaService.instance.requestHumanReview(widget.analysisId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.mediaResultReviewRequestedSnackbar)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _isRequestingReview = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.mediaResultAppBarTitle)),
      body: SafeArea(
        child: _error != null
            ? ErrorBanner(message: _error!, onRetry: _load)
            : _result == null
                ? CenteredLoader(label: l10n.mediaResultLoading)
                : _ResultBody(
                    result: _result!,
                    isRequestingReview: _isRequestingReview,
                    onRequestReview: _requestHumanReview,
                  ),
      ),
    );
  }
}

class _ResultBody extends StatelessWidget {
  final MediaAnalysis result;
  final bool isRequestingReview;
  final VoidCallback onRequestReview;

  const _ResultBody({
    required this.result,
    required this.isRequestingReview,
    required this.onRequestReview,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasAnomalies = result.hasAnomalies;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: hasAnomalies ? AppColors.insufficientBg : AppColors.reliableBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  hasAnomalies ? Icons.report_gmailerrorred_outlined : Icons.task_alt,
                  color: hasAnomalies ? AppColors.insufficient : AppColors.reliable,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasAnomalies
                            ? l10n.mediaResultSignalsCount(result.coherenceFlags.length)
                            : l10n.mediaResultNoAnomalies,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: hasAnomalies ? AppColors.insufficient : AppColors.reliable,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (!result.hasAiDescription)
                        Text(
                          result.explanation,
                          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (result.hasAiDescription) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome_outlined, size: 18, color: AppColors.brand),
                      const SizedBox(width: 8),
                      Text(
                        l10n.mediaResultAiSectionTitle,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    result.aiDescription!,
                    style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
          if (hasAnomalies) ...[
            const SizedBox(height: 20),
            Text(l10n.mediaResultDetectedSignalsTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            ...result.coherenceFlags.map(
              (flag) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.flag_outlined, size: 18, color: AppColors.insufficient),
                      const SizedBox(width: 10),
                      Expanded(child: Text(coherenceFlagLabel(context, flag), style: const TextStyle(fontSize: 13.5))),
                    ],
                  ),
                ),
              ),
            ),
          ],
          if (result.reverseMatches.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(l10n.mediaResultMatchesFoundTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            ...result.reverseMatches.map(
              (match) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.travel_explore_outlined, color: AppColors.brand),
                  title: Text(l10n.mediaResultSimilarityLabel(
                    ((match['similarity'] as num?)?.toDouble() ?? 0 * 100).toStringAsFixed(0),
                  )),
                  subtitle: Text(l10n.mediaResultSubmittedOnLabel('${match['submittedAt'] ?? '—'}')),
                ),
              ),
            ),
          ],
          const SizedBox(height: 28),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.groups_outlined, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.mediaResultDisclaimer,
                  style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary, height: 1.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: isRequestingReview ? null : onRequestReview,
            icon: const Icon(Icons.support_agent_outlined, size: 18),
            label: Text(isRequestingReview ? l10n.mediaResultRequestingReview : l10n.mediaResultRequestReviewButton),
          ),
        ],
      ),
    );
  }
}
