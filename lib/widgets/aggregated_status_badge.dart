import 'package:flutter/material.dart';

import '../models/local_event.dart';
import '../theme/app_colors.dart';

class AggregatedStatusBadge extends StatelessWidget {
  final String status;
  final bool compact;

  const AggregatedStatusBadge({super.key, required this.status, this.compact = false});

  ({Color fg, Color bg, IconData icon}) get _style {
    switch (status) {
      case 'likely_reliable':
        return (fg: AppColors.reliable, bg: AppColors.reliableBg, icon: Icons.verified_outlined);
      case 'likely_doubtful':
        return (fg: AppColors.doubtful, bg: AppColors.doubtfulBg, icon: Icons.error_outline);
      default:
        return (fg: AppColors.insufficient, bg: AppColors.insufficientBg, icon: Icons.help_outline);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _style;
    final info = AggregatedStatusInfo.of(context, status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12, vertical: compact ? 4 : 7),
      decoration: BoxDecoration(color: s.bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(s.icon, size: compact ? 14 : 16, color: s.fg),
          const SizedBox(width: 5),
          Text(
            info.label,
            style: TextStyle(
              color: s.fg,
              fontWeight: FontWeight.w600,
              fontSize: compact ? 12 : 13,
            ),
          ),
        ],
      ),
    );
  }
}
