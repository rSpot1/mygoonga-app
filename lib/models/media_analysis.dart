import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

class MediaAnalysis {
  final String analysisId;
  final String status; // processing | done
  final List<String> coherenceFlags;
  final List<Map<String, dynamic>> reverseMatches;
  final String explanation;
  final String? aiDescription;

  MediaAnalysis({
    required this.analysisId,
    required this.status,
    required this.coherenceFlags,
    required this.reverseMatches,
    required this.explanation,
    this.aiDescription,
  });

  factory MediaAnalysis.fromJson(Map<String, dynamic> json) {
    return MediaAnalysis(
      analysisId: json['analysisId'] as String,
      status: json['status'] as String? ?? 'processing',
      coherenceFlags: (json['coherenceFlags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      reverseMatches: (json['reverseMatches'] as List?)?.cast<Map<String, dynamic>>() ?? [],
      explanation: json['explanation'] as String? ?? '',
      aiDescription: json['aiDescription'] as String?,
    );
  }

  bool get hasAiDescription => aiDescription != null && aiDescription!.trim().isNotEmpty;

  bool get isProcessing => status == 'processing';
  bool get hasAnomalies => coherenceFlags.isNotEmpty;
}

/// Traduction localisée (FR/EN) des codes de signaux techniques renvoyes par l'API.
String coherenceFlagLabel(BuildContext context, String flag) {
  final l10n = AppLocalizations.of(context)!;
  switch (flag) {
    case 'noMetadata':
      return l10n.flagNoMetadata;
    case 'missingExif':
      return l10n.flagMissingExif;
    case 'possibleScreenshot':
      return l10n.flagPossibleScreenshot;
    case 'elaAnomaly':
      return l10n.flagElaAnomaly;
    case 'reverseMatchFound':
      return l10n.flagReverseMatchFound;
    case 'locationMismatch':
      return l10n.flagLocationMismatch;
    case 'suspiciousDate':
      return l10n.flagSuspiciousDate;
    case 'unparsableDate':
      return l10n.flagUnparsableDate;
    default:
      return flag;
  }
}
