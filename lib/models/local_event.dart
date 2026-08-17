import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

class EventFlag {
  final String type; // confirm | dispute | unsure
  final int weight;
  final String? comment;
  final String createdAt;

  EventFlag({required this.type, required this.weight, this.comment, required this.createdAt});

  factory EventFlag.fromJson(Map<String, dynamic> json) {
    return EventFlag(
      type: json['type'] as String,
      weight: (json['weight'] as num).toInt(),
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
    );
  }
}

class EventSummary {
  final String eventId;
  final String description;
  final String city;
  final String aggregatedStatus;
  final int flagCount;

  EventSummary({
    required this.eventId,
    required this.description,
    required this.city,
    required this.aggregatedStatus,
    required this.flagCount,
  });

  factory EventSummary.fromJson(Map<String, dynamic> json) {
    return EventSummary(
      eventId: json['eventId'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      aggregatedStatus: json['aggregatedStatus'] as String? ?? 'insufficient_data',
      flagCount: (json['flagCount'] as num?)?.toInt() ?? 0,
    );
  }
}

class EventDetail {
  final String eventId;
  final String description;
  final String aggregatedStatus;
  final List<EventFlag> flags;

  EventDetail({
    required this.eventId,
    required this.description,
    required this.aggregatedStatus,
    required this.flags,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      eventId: json['eventId'] as String,
      description: json['description'] as String,
      aggregatedStatus: json['aggregatedStatus'] as String? ?? 'insufficient_data',
      flags: (json['flags'] as List? ?? [])
          .map((e) => EventFlag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Traduction localisée (FR/EN) + couleur/icone associees au statut agrege.
class AggregatedStatusInfo {
  final String label;
  final String description;

  const AggregatedStatusInfo(this.label, this.description);

  static AggregatedStatusInfo of(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case 'likely_reliable':
        return AggregatedStatusInfo(l10n.statusReliableLabel, l10n.statusReliableDescription);
      case 'likely_doubtful':
        return AggregatedStatusInfo(l10n.statusDoubtfulLabel, l10n.statusDoubtfulDescription);
      case 'insufficient_data':
        return AggregatedStatusInfo(l10n.statusInsufficientLabel, l10n.statusInsufficientDescription);
      default:
        return AggregatedStatusInfo(l10n.statusUnknownLabel, '');
    }
  }
}
