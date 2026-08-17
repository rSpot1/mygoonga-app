import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/verifier_application.dart';
import '../../services/verifier_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';

class ApplicationDetailScreen extends StatefulWidget {
  final String applicationId;

  const ApplicationDetailScreen({super.key, required this.applicationId});

  @override
  State<ApplicationDetailScreen> createState() => _ApplicationDetailScreenState();
}

class _ApplicationDetailScreenState extends State<ApplicationDetailScreen> {
  VerifierApplicationDetail? _detail;
  String? _error;
  bool _isDeciding = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final detail = await VerifierService.instance.getDetail(widget.applicationId);
      if (mounted) setState(() => _detail = detail);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _decide(String decision) async {
    String? reason;
    if (decision == 'rejected') {
      reason = await _promptReason();
      if (reason == null) return; // annulé
    }
    setState(() => _isDeciding = true);
    try {
      await VerifierService.instance.review(widget.applicationId, decision: decision, reason: reason);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isDeciding = false);
    }
  }

  Future<String?> _promptReason() async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.applicationDetailRejectReasonTitle),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(hintText: l10n.applicationDetailRejectReasonHint),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.applicationDetailCancelButton)),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: Text(l10n.applicationDetailConfirmButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.applicationDetailAppBarTitle)),
      body: SafeArea(
        child: _error != null
            ? ErrorBanner(message: _error!, onRetry: _load)
            : _detail == null
                ? const CenteredLoader()
                : _DetailBody(
                    detail: _detail!,
                    isDeciding: _isDeciding,
                    onApprove: () => _decide('approved'),
                    onReject: () => _decide('rejected'),
                  ),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  final VerifierApplicationDetail detail;
  final bool isDeciding;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _DetailBody({
    required this.detail,
    required this.isDeciding,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.insufficientBg, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Icon(Icons.lock_outline, size: 18, color: AppColors.insufficient),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.applicationDetailAccessNotice,
                    style: const TextStyle(fontSize: 12, color: AppColors.insufficient),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(l10n.applicationDetailPhoneLabel(detail.phoneNumber), style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 18),
          _DocImage(title: l10n.applicationDetailCniFrontTitle, url: detail.cniFrontUrl),
          const SizedBox(height: 12),
          _DocImage(title: l10n.applicationDetailCniBackTitle, url: detail.cniBackUrl),
          const SizedBox(height: 12),
          _DocImage(title: l10n.applicationDetailVerificationPhotoTitle, url: detail.verificationPhotoUrl),
          const SizedBox(height: 24),
          if (detail.metadataFlags.isNotEmpty) ...[
            Text(l10n.applicationDetailAutoSignalsTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            ...detail.metadataFlags.map(
              (flag) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.flag_outlined, size: 16, color: AppColors.insufficient),
                    const SizedBox(width: 8),
                    Expanded(child: Text(metadataFlagLabel(context, flag), style: const TextStyle(fontSize: 13))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 12),
          Text(
            l10n.applicationDetailDecisionNotice,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isDeciding ? null : onReject,
                  icon: const Icon(Icons.close, size: 18, color: AppColors.doubtful),
                  label: Text(l10n.applicationDetailRejectButton, style: const TextStyle(color: AppColors.doubtful)),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.doubtful)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: isDeciding ? null : onApprove,
                  icon: const Icon(Icons.check, size: 18),
                  label: Text(l10n.applicationDetailApproveButton),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.reliable),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocImage extends StatelessWidget {
  final String title;
  final String url;

  const _DocImage({required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: CachedNetworkImage(
            imageUrl: url,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, _) => Container(
              height: 200,
              color: AppColors.surfaceAlt,
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            errorWidget: (context, _, __) => Container(
              height: 200,
              color: AppColors.surfaceAlt,
              child: const Center(child: Icon(Icons.broken_image_outlined, color: AppColors.textMuted)),
            ),
          ),
        ),
      ],
    );
  }
}
