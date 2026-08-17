import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

class VerifierApplicationSummary {
  final String applicationId;
  final String userId;
  final String submittedAt;
  final List<String> metadataFlags;

  VerifierApplicationSummary({
    required this.applicationId,
    required this.userId,
    required this.submittedAt,
    required this.metadataFlags,
  });

  factory VerifierApplicationSummary.fromJson(Map<String, dynamic> json) {
    return VerifierApplicationSummary(
      applicationId: json['applicationId'] as String,
      userId: json['userId'] as String,
      submittedAt: json['submittedAt'] as String? ?? '',
      metadataFlags: (json['metadataFlags'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class VerifierApplicationDetail {
  final String applicationId;
  final String cniFrontUrl;
  final String cniBackUrl;
  final String verificationPhotoUrl;
  final List<String> metadataFlags;
  final String phoneNumber;

  VerifierApplicationDetail({
    required this.applicationId,
    required this.cniFrontUrl,
    required this.cniBackUrl,
    required this.verificationPhotoUrl,
    required this.metadataFlags,
    required this.phoneNumber,
  });

  factory VerifierApplicationDetail.fromJson(Map<String, dynamic> json) {
    return VerifierApplicationDetail(
      applicationId: json['applicationId'] as String,
      cniFrontUrl: json['cniFrontUrl'] as String,
      cniBackUrl: json['cniBackUrl'] as String,
      verificationPhotoUrl: json['verificationPhotoUrl'] as String,
      metadataFlags: (json['metadataFlags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      phoneNumber: json['phoneNumber'] as String? ?? '',
    );
  }
}

/// Traduction localisée (FR/EN) des signaux automatiques (nécessite BuildContext).
String metadataFlagLabel(BuildContext context, String flag) {
  final l10n = AppLocalizations.of(context)!;
  final parts = flag.split(':');
  final scope = parts.length > 1 ? parts[0] : null;
  final code = parts.length > 1 ? parts[1] : parts[0];

  String scopeLabel = '';
  switch (scope) {
    case 'front':
      scopeLabel = l10n.metadataScopeFront;
      break;
    case 'back':
      scopeLabel = l10n.metadataScopeBack;
      break;
    case 'verification':
      scopeLabel = l10n.metadataScopeVerification;
      break;
  }

  String codeLabel;
  switch (code) {
    case 'missingExif':
      codeLabel = l10n.metadataCodeMissingExif;
      break;
    case 'possibleScreenshot':
      codeLabel = l10n.metadataCodePossibleScreenshot;
      break;
    case 'locationMismatch':
      codeLabel = l10n.metadataCodeLocationMismatch;
      break;
    case 'suspiciousDate':
      codeLabel = l10n.metadataCodeSuspiciousDate;
      break;
    case 'unparsableDate':
      codeLabel = l10n.metadataCodeUnparsableDate;
      break;
    default:
      codeLabel = code;
  }
  return '$scopeLabel$codeLabel';
}
