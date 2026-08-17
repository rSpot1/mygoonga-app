// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navAnalyze => 'Analyze';

  @override
  String get navEvents => 'Events';

  @override
  String get navProfile => 'Profile';

  @override
  String get mediaHomeTitle => 'Verify a media file';

  @override
  String get mediaHomeHeading =>
      'Does a photo or video seem suspicious to you?';

  @override
  String get mediaHomeBody =>
      'Send it here: we examine its metadata and technical consistency to give you clues, without ever deciding for you.';

  @override
  String get mediaHomeInfoMetadataTitle => 'Metadata';

  @override
  String get mediaHomeInfoMetadataSubtitle =>
      'Date, device, location, screenshot indicators.';

  @override
  String get mediaHomeInfoElaTitle => 'Error level analysis';

  @override
  String get mediaHomeInfoElaSubtitle => 'Looks for potentially edited areas.';

  @override
  String get mediaHomeInfoReverseTitle => 'Reverse search';

  @override
  String get mediaHomeInfoReverseSubtitle =>
      'Checks whether the content has already been submitted elsewhere.';

  @override
  String get mediaHomeChooseFileButton => 'Choose a file to analyze';

  @override
  String get mediaHomeShareTip =>
      'Tip: from WhatsApp or your gallery, use \"Share\" then choose MyGoonga.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileEmailLabel => 'Email';

  @override
  String get profileCityLabel => 'Declared city';

  @override
  String get profileCityUnknown => 'Not provided';

  @override
  String get profileReputationLabel => 'Reputation';

  @override
  String get profileLanguageLabel => 'Language';

  @override
  String get profileLanguageFrench => 'Français';

  @override
  String get profileLanguageEnglish => 'English';

  @override
  String get profileSignOut => 'Sign out';

  @override
  String get profileDefaultUser => 'User';

  @override
  String get profileVerifierPending =>
      'Your verifier status request is currently under review.';

  @override
  String get profileVerifierRejected =>
      'Your previous verifier status request was not approved.';

  @override
  String get profileBecomeVerifierTitle => 'Become a verifier';

  @override
  String get profileBecomeVerifierSubtitle =>
      'Confirm your identity so your reports carry more weight.';

  @override
  String get profileModerationQueueTitle => 'Moderation queue';

  @override
  String get profileModerationQueueSubtitle =>
      'Review pending verifier status requests.';

  @override
  String get profileUserManagementTitle => 'User management';

  @override
  String get profileUserManagementSubtitle => 'Assign or change account roles.';

  @override
  String get profileAuditLogTitle => 'Audit log';

  @override
  String get profileAuditLogSubtitle => 'Review access to sensitive data.';

  @override
  String get commonRetry => 'Retry';

  @override
  String get statusReliableLabel => 'Likely reliable';

  @override
  String get statusReliableDescription =>
      'Confirmed by several nearby witnesses, including verifiers.';

  @override
  String get statusDoubtfulLabel => 'Likely doubtful';

  @override
  String get statusDoubtfulDescription =>
      'Disputed by several nearby witnesses, including verifiers.';

  @override
  String get statusInsufficientLabel => 'Not enough information';

  @override
  String get statusInsufficientDescription =>
      'Too few confirmations to establish a reliable status.';

  @override
  String get statusUnknownLabel => 'Unknown status';

  @override
  String get roleStandard => 'Standard';

  @override
  String get roleVerifier => 'Verifier';

  @override
  String get roleModerator => 'Moderator';

  @override
  String get roleAdmin => 'Administrator';

  @override
  String get flagNoMetadata => 'No EXIF metadata';

  @override
  String get flagMissingExif => 'Missing EXIF metadata';

  @override
  String get flagPossibleScreenshot => 'Looks like a screenshot';

  @override
  String get flagElaAnomaly => 'Inconsistent compression area';

  @override
  String get flagReverseMatchFound => 'Content already seen elsewhere';

  @override
  String get flagLocationMismatch => 'Inconsistent location';

  @override
  String get flagSuspiciousDate => 'Suspicious date';

  @override
  String get flagUnparsableDate => 'Unreadable date';

  @override
  String get metadataScopeFront => 'ID card front — ';

  @override
  String get metadataScopeBack => 'ID card back — ';

  @override
  String get metadataScopeVerification => 'Verification photo — ';

  @override
  String get metadataCodeMissingExif => 'missing metadata';

  @override
  String get metadataCodePossibleScreenshot => 'looks like a screenshot';

  @override
  String get metadataCodeLocationMismatch =>
      'location inconsistent with declared city';

  @override
  String get metadataCodeSuspiciousDate => 'clearly old date';

  @override
  String get metadataCodeUnparsableDate => 'unreadable date';

  @override
  String get loginCreateAccountTitle => 'Create an account';

  @override
  String get loginWelcomeBackTitle => 'Welcome back';

  @override
  String get loginRegisterSubtitle =>
      'Join the MyGoonga verification community.';

  @override
  String get loginSignInSubtitle => 'Sign in to continue.';

  @override
  String get loginEmailHint => 'Email address';

  @override
  String get loginEmailInvalid => 'Invalid email';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginPasswordTooShort => '6 characters minimum';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginEnterEmailForReset =>
      'Enter your email to reset your password.';

  @override
  String get loginResetEmailSent => 'Reset email sent.';

  @override
  String get loginCreateAccountButton => 'Create my account';

  @override
  String get loginSignInButton => 'Sign in';

  @override
  String get loginOrDivider => 'or';

  @override
  String get loginContinueWithGoogle => 'Continue with Google';

  @override
  String get loginSwitchToSignIn => 'Already have an account? Sign in';

  @override
  String get loginSwitchToRegister => 'No account yet? Create one';

  @override
  String get loginGenericError => 'Something went wrong. Please try again.';

  @override
  String get loginGoogleError => 'Google sign-in failed. Please try again.';

  @override
  String get loginErrorUserNotFound => 'No account matches this email.';

  @override
  String get loginErrorWrongPassword => 'Incorrect email or password.';

  @override
  String get loginErrorEmailInUse =>
      'An account already exists with this email.';

  @override
  String get loginErrorWeakPassword =>
      'Password must be at least 6 characters.';

  @override
  String get loginErrorInvalidEmail => 'Invalid email address.';

  @override
  String loginErrorGenericCode(String code) {
    return 'Something went wrong ($code).';
  }

  @override
  String get verifierAppBarTitle => 'Become a verifier';

  @override
  String get verifierPrivacyNotice =>
      'Your documents are reviewed only by an authorized moderator and are never visible to other users.';

  @override
  String get verifierPhotosRequiredError => 'All three photos are required.';

  @override
  String get verifierPhoneLabel => 'Phone number';

  @override
  String get verifierPhoneInvalid => 'Invalid number';

  @override
  String get verifierCniFrontTitle => 'ID card — front';

  @override
  String get verifierCniBackTitle => 'ID card — back';

  @override
  String get verifierPhotoTitle => 'Verification photo (selfie)';

  @override
  String get verifierSubmitButton => 'Submit my request';

  @override
  String get verifierRequestSentSnackbar =>
      'Request sent. A moderator will review it.';

  @override
  String get mediaAnalyzeAppBarTitle => 'New analysis';

  @override
  String get mediaAnalyzeCameraButton => 'Camera';

  @override
  String get mediaAnalyzeGalleryButton => 'Gallery';

  @override
  String get mediaAnalyzeOtherFileButton => 'Choose another file';

  @override
  String get mediaAnalyzeContextLabel => 'Context (optional)';

  @override
  String get mediaAnalyzeContextHint =>
      'E.g.: received on WhatsApp, allegedly taken yesterday in Maroua...';

  @override
  String get mediaAnalyzeSubmitButton => 'Start analysis';

  @override
  String get mediaAnalyzeNoFileSelected => 'No file selected';

  @override
  String get mediaResultAppBarTitle => 'Analysis result';

  @override
  String get mediaResultLoading => 'Analysis in progress...';

  @override
  String get mediaResultNoAnomalies => 'No inconsistency signals';

  @override
  String get mediaResultAiSectionTitle => 'Analysis';

  @override
  String get mediaResultDetectedSignalsTitle => 'Detected signals';

  @override
  String get mediaResultMatchesFoundTitle => 'Matches found';

  @override
  String get mediaResultDisclaimer =>
      'These clues are not proof. You can ask for a human moderator\'s opinion for a thorough review.';

  @override
  String get mediaResultRequestReviewButton => 'Request human review';

  @override
  String get mediaResultRequestingReview => 'Sending...';

  @override
  String get mediaResultReviewRequestedSnackbar =>
      'A human review has been requested.';

  @override
  String mediaResultSignalsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count signals detected',
      one: '1 signal detected',
    );
    return '$_temp0';
  }

  @override
  String mediaResultSimilarityLabel(String similarity) {
    return '$similarity% similarity';
  }

  @override
  String mediaResultSubmittedOnLabel(String date) {
    return 'Submitted on $date';
  }

  @override
  String get eventsHomeAppBarTitle => 'Local events';

  @override
  String get eventsHomeLoading => 'Searching for nearby events...';

  @override
  String get eventsHomeEmptyTitle => 'No nearby events';

  @override
  String get eventsHomeEmptySubtitle =>
      'Be the first to report a verifiable fact.';

  @override
  String get eventsHomeReportButton => 'Report';

  @override
  String eventsHomeWitnessCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count witnesses',
      one: '1 witness',
    );
    return '$_temp0';
  }

  @override
  String get eventDetailAppBarTitle => 'Event details';

  @override
  String get eventDetailYourTestimonyTitle => 'Your testimony';

  @override
  String get eventDetailYourTestimonySubtitle =>
      'If you are nearby or have knowledge of this fact, let us know what you know.';

  @override
  String get eventDetailConfirmButton => 'I confirm';

  @override
  String get eventDetailDisputeButton => 'I dispute';

  @override
  String get eventDetailUnsureButton => 'I don\'t know';

  @override
  String get eventDetailNoTestimonies => 'No testimonies yet.';

  @override
  String eventDetailTestimoniesTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Testimonies ($count)',
      one: 'Testimony (1)',
    );
    return '$_temp0';
  }

  @override
  String get eventDetailTestimonySentSnackbar =>
      'Thank you, your testimony has been recorded.';

  @override
  String get eventDetailFlagConfirmedLabel => 'Confirmed';

  @override
  String get eventDetailFlagDisputedLabel => 'Disputed';

  @override
  String get eventDetailFlagUnsureLabel => 'Unsure';

  @override
  String get reportEventAppBarTitle => 'Report an event';

  @override
  String get reportEventDescriptionLabel => 'Description';

  @override
  String get reportEventDescriptionHint =>
      'Describe precisely what you observed...';

  @override
  String get reportEventDescriptionTooShort =>
      'Describe the fact in a few more words';

  @override
  String get reportEventCityLabel => 'City';

  @override
  String get reportEventCityHint => 'E.g.: Maroua';

  @override
  String get reportEventCityRequired => 'City required';

  @override
  String get reportEventLocatingInProgress => 'Locating...';

  @override
  String get reportEventLocationAttached => 'Current position attached';

  @override
  String get reportEventAttachLocation => 'Attach my current position';

  @override
  String get reportEventLocationUnavailable =>
      'Location unavailable. Check location permissions.';

  @override
  String get reportEventSubmitButton => 'Publish report';

  @override
  String get moderationQueueAppBarTitle => 'Moderation queue';

  @override
  String get moderationQueueEmptyTitle => 'No pending requests';

  @override
  String get moderationQueueEmptySubtitle =>
      'All verifier status requests have been processed.';

  @override
  String get moderationQueueNoSignals => 'No signals detected';

  @override
  String moderationQueueRequestFrom(String userId) {
    return 'Request from $userId';
  }

  @override
  String moderationQueueSignalsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count signals detected',
      one: '1 signal detected',
    );
    return '$_temp0';
  }

  @override
  String get applicationDetailAppBarTitle => 'Verifier request';

  @override
  String get applicationDetailAccessNotice =>
      'Temporary and logged access. These documents are not stored or shared beyond this verification.';

  @override
  String applicationDetailPhoneLabel(String phoneNumber) {
    return 'Phone: $phoneNumber';
  }

  @override
  String get applicationDetailCniFrontTitle => 'ID card — front';

  @override
  String get applicationDetailCniBackTitle => 'ID card — back';

  @override
  String get applicationDetailVerificationPhotoTitle => 'Verification photo';

  @override
  String get applicationDetailAutoSignalsTitle => 'Automatic signals';

  @override
  String get applicationDetailDecisionNotice =>
      'These signals are provided for guidance only. The final decision is yours.';

  @override
  String get applicationDetailRejectButton => 'Reject';

  @override
  String get applicationDetailApproveButton => 'Approve';

  @override
  String get applicationDetailRejectReasonTitle => 'Reason for rejection';

  @override
  String get applicationDetailRejectReasonHint =>
      'Briefly explain the reason...';

  @override
  String get applicationDetailCancelButton => 'Cancel';

  @override
  String get applicationDetailConfirmButton => 'Confirm';

  @override
  String get adminUsersAppBarTitle => 'Users';

  @override
  String get adminUsersChangeRoleTitle => 'Change role';

  @override
  String get auditLogAppBarTitle => 'Audit log';

  @override
  String get auditLogEmptyTitle => 'No entries yet';

  @override
  String auditLogByLabel(
      String accessedBy, String targetCollection, String targetId) {
    return 'By $accessedBy · $targetCollection/$targetId';
  }
}
