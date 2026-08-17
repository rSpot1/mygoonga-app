import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/local_event.dart';
import '../../services/event_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/aggregated_status_badge.dart';
import '../../widgets/common.dart';

class EventDetailScreen extends StatefulWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  EventDetail? _event;
  String? _error;
  bool _isFlagging = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final event = await EventService.instance.getDetail(widget.eventId);
      if (mounted) setState(() => _event = event);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _submitFlag(String type) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isFlagging = true);
    try {
      await EventService.instance.flag(widget.eventId, type: type);
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.eventDetailTestimonySentSnackbar)),
        );
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isFlagging = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.eventDetailAppBarTitle)),
      body: SafeArea(
        child: _error != null
            ? ErrorBanner(message: _error!, onRetry: _load)
            : _event == null
                ? const CenteredLoader()
                : _DetailBody(event: _event!, isFlagging: _isFlagging, onFlag: _submitFlag),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  final EventDetail event;
  final bool isFlagging;
  final void Function(String type) onFlag;

  const _DetailBody({required this.event, required this.isFlagging, required this.onFlag});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AggregatedStatusBadge(status: event.aggregatedStatus),
          const SizedBox(height: 14),
          Text(event.description, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, height: 1.4)),
          const SizedBox(height: 8),
          Text(
            AggregatedStatusInfo.of(context, event.aggregatedStatus).description,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 28),
          Text(l10n.eventDetailYourTestimonyTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 6),
          Text(
            l10n.eventDetailYourTestimonySubtitle,
            style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _FlagButton(
                  icon: Icons.check_circle_outline,
                  label: l10n.eventDetailConfirmButton,
                  color: AppColors.reliable,
                  enabled: !isFlagging,
                  onTap: () => onFlag('confirm'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FlagButton(
                  icon: Icons.cancel_outlined,
                  label: l10n.eventDetailDisputeButton,
                  color: AppColors.doubtful,
                  enabled: !isFlagging,
                  onTap: () => onFlag('dispute'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _FlagButton(
            icon: Icons.help_outline,
            label: l10n.eventDetailUnsureButton,
            color: AppColors.insufficient,
            enabled: !isFlagging,
            onTap: () => onFlag('unsure'),
            fullWidth: true,
          ),
          const SizedBox(height: 32),
          Text(l10n.eventDetailTestimoniesTitle(event.flags.length), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          if (event.flags.isEmpty)
            Text(l10n.eventDetailNoTestimonies, style: const TextStyle(fontSize: 13, color: AppColors.textMuted))
          else
            ...event.flags.map((f) => _FlagTile(flag: f)),
        ],
      ),
    );
  }
}

class _FlagButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool enabled;
  final VoidCallback onTap;
  final bool fullWidth;

  const _FlagButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.enabled,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: OutlinedButton.icon(
        onPressed: enabled ? onTap : null,
        icon: Icon(icon, size: 18, color: color),
        label: Text(label, style: TextStyle(color: color)),
        style: OutlinedButton.styleFrom(side: BorderSide(color: color.withValues(alpha: 0.4))),
      ),
    );
  }
}

class _FlagTile extends StatelessWidget {
  final EventFlag flag;

  const _FlagTile({required this.flag});

  ({IconData icon, Color color}) get _style {
    switch (flag.type) {
      case 'confirm':
        return (icon: Icons.check_circle_outline, color: AppColors.reliable);
      case 'dispute':
        return (icon: Icons.cancel_outlined, color: AppColors.doubtful);
      default:
        return (icon: Icons.help_outline, color: AppColors.insufficient);
    }
  }

  String _label(AppLocalizations l10n) {
    switch (flag.type) {
      case 'confirm':
        return l10n.eventDetailFlagConfirmedLabel;
      case 'dispute':
        return l10n.eventDetailFlagDisputedLabel;
      default:
        return l10n.eventDetailFlagUnsureLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _style;
    final label = _label(AppLocalizations.of(context)!);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(s.icon, size: 18, color: s.color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: s.color)),
                    if (flag.weight > 1) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.verified, size: 12, color: AppColors.verifierGold),
                    ],
                  ],
                ),
                if (flag.comment != null && flag.comment!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(flag.comment!, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
