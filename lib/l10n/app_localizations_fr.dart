// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navAnalyze => 'Analyser';

  @override
  String get navEvents => 'Événements';

  @override
  String get navProfile => 'Profil';

  @override
  String get mediaHomeTitle => 'Vérifier un média';

  @override
  String get mediaHomeHeading => 'Une photo ou vidéo vous semble suspecte ?';

  @override
  String get mediaHomeBody =>
      'Envoyez-la ici : nous examinons sa cohérence technique pour vous donner des indices, sans jamais trancher à votre place.';

  @override
  String get mediaHomeInfoMetadataTitle => 'Métadonnées';

  @override
  String get mediaHomeInfoMetadataSubtitle =>
      'Date, appareil, position, indices de capture d\'écran.';

  @override
  String get mediaHomeInfoElaTitle => 'Analyse par niveaux d\'erreur';

  @override
  String get mediaHomeInfoElaSubtitle =>
      'Recherche de zones potentiellement retouchées.';

  @override
  String get mediaHomeInfoReverseTitle => 'Recherche inversée';

  @override
  String get mediaHomeInfoReverseSubtitle =>
      'Vérifie si le contenu a déjà été soumis ailleurs.';

  @override
  String get mediaHomeChooseFileButton => 'Choisir un fichier à analyser';

  @override
  String get mediaHomeShareTip =>
      'Astuce : depuis WhatsApp ou votre galerie, utilisez \"Partager\" puis choisissez MyGoonga.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileEmailLabel => 'E-mail';

  @override
  String get profileCityLabel => 'Ville déclarée';

  @override
  String get profileCityUnknown => 'Non renseignée';

  @override
  String get profileReputationLabel => 'Réputation';

  @override
  String get profileLanguageLabel => 'Langue';

  @override
  String get profileLanguageFrench => 'Français';

  @override
  String get profileLanguageEnglish => 'English';

  @override
  String get profileSignOut => 'Se déconnecter';

  @override
  String get profileDefaultUser => 'Utilisateur';

  @override
  String get profileVerifierPending =>
      'Votre demande de statut vérificateur est en cours d\'examen.';

  @override
  String get profileVerifierRejected =>
      'Votre précédente demande de statut vérificateur n\'a pas été retenue.';

  @override
  String get profileBecomeVerifierTitle => 'Devenir vérificateur';

  @override
  String get profileBecomeVerifierSubtitle =>
      'Confirmez votre identité pour que vos témoignages comptent davantage.';

  @override
  String get profileModerationQueueTitle => 'File de modération';

  @override
  String get profileModerationQueueSubtitle =>
      'Examiner les demandes de statut vérificateur en attente.';

  @override
  String get profileUserManagementTitle => 'Gestion des utilisateurs';

  @override
  String get profileUserManagementSubtitle =>
      'Attribuer ou modifier les rôles des comptes.';

  @override
  String get profileAuditLogTitle => 'Journal d\'audit';

  @override
  String get profileAuditLogSubtitle =>
      'Consulter les accès aux données sensibles.';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get statusReliableLabel => 'Probablement fiable';

  @override
  String get statusReliableDescription =>
      'Confirmé par plusieurs témoins de proximité, dont des vérificateurs.';

  @override
  String get statusDoubtfulLabel => 'Probablement douteux';

  @override
  String get statusDoubtfulDescription =>
      'Contesté par plusieurs témoins de proximité, dont des vérificateurs.';

  @override
  String get statusInsufficientLabel => 'Pas assez d\'informations';

  @override
  String get statusInsufficientDescription =>
      'Trop peu de confirmations pour établir un statut fiable.';

  @override
  String get statusUnknownLabel => 'Statut inconnu';

  @override
  String get roleStandard => 'Standard';

  @override
  String get roleVerifier => 'Vérificateur';

  @override
  String get roleModerator => 'Modérateur';

  @override
  String get roleAdmin => 'Administrateur';

  @override
  String get flagNoMetadata => 'Aucune métadonnée EXIF';

  @override
  String get flagMissingExif => 'Métadonnées EXIF absentes';

  @override
  String get flagPossibleScreenshot => 'Ressemble à une capture d\'écran';

  @override
  String get flagElaAnomaly => 'Zone de compression incohérente';

  @override
  String get flagReverseMatchFound => 'Contenu déjà vu ailleurs';

  @override
  String get flagLocationMismatch => 'Localisation incohérente';

  @override
  String get flagSuspiciousDate => 'Date suspecte';

  @override
  String get flagUnparsableDate => 'Date illisible';

  @override
  String get metadataScopeFront => 'CNI recto — ';

  @override
  String get metadataScopeBack => 'CNI verso — ';

  @override
  String get metadataScopeVerification => 'Photo de vérification — ';

  @override
  String get metadataCodeMissingExif => 'métadonnées absentes';

  @override
  String get metadataCodePossibleScreenshot =>
      'ressemble à une capture d\'écran';

  @override
  String get metadataCodeLocationMismatch =>
      'localisation incohérente avec la ville déclarée';

  @override
  String get metadataCodeSuspiciousDate => 'date manifestement ancienne';

  @override
  String get metadataCodeUnparsableDate => 'date illisible';

  @override
  String get loginCreateAccountTitle => 'Créer un compte';

  @override
  String get loginWelcomeBackTitle => 'Bon retour';

  @override
  String get loginRegisterSubtitle =>
      'Rejoignez la communauté de vérification MyGoonga.';

  @override
  String get loginSignInSubtitle => 'Connectez-vous pour continuer.';

  @override
  String get loginEmailHint => 'Adresse e-mail';

  @override
  String get loginEmailInvalid => 'E-mail invalide';

  @override
  String get loginPasswordHint => 'Mot de passe';

  @override
  String get loginPasswordTooShort => '6 caractères minimum';

  @override
  String get loginForgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginEnterEmailForReset =>
      'Renseignez votre e-mail pour réinitialiser le mot de passe.';

  @override
  String get loginResetEmailSent => 'E-mail de réinitialisation envoyé.';

  @override
  String get loginCreateAccountButton => 'Créer mon compte';

  @override
  String get loginSignInButton => 'Se connecter';

  @override
  String get loginOrDivider => 'ou';

  @override
  String get loginContinueWithGoogle => 'Continuer avec Google';

  @override
  String get loginSwitchToSignIn => 'Vous avez déjà un compte ? Se connecter';

  @override
  String get loginSwitchToRegister => 'Pas encore de compte ? En créer un';

  @override
  String get loginGenericError => 'Une erreur est survenue. Réessayez.';

  @override
  String get loginGoogleError =>
      'La connexion avec Google a échoué. Réessayez.';

  @override
  String get loginErrorUserNotFound =>
      'Aucun compte ne correspond à cet e-mail.';

  @override
  String get loginErrorWrongPassword => 'E-mail ou mot de passe incorrect.';

  @override
  String get loginErrorEmailInUse => 'Un compte existe déjà avec cet e-mail.';

  @override
  String get loginErrorWeakPassword =>
      'Le mot de passe doit contenir au moins 6 caractères.';

  @override
  String get loginErrorInvalidEmail => 'Adresse e-mail invalide.';

  @override
  String loginErrorGenericCode(String code) {
    return 'Une erreur est survenue ($code).';
  }

  @override
  String get verifierAppBarTitle => 'Devenir vérificateur';

  @override
  String get verifierPrivacyNotice =>
      'Vos documents sont examinés uniquement par un modérateur habilité et ne sont jamais visibles par les autres utilisateurs.';

  @override
  String get verifierPhotosRequiredError => 'Les trois photos sont requises.';

  @override
  String get verifierPhoneLabel => 'Numéro de téléphone';

  @override
  String get verifierPhoneInvalid => 'Numéro invalide';

  @override
  String get verifierCniFrontTitle => 'Carte d\'identité — recto';

  @override
  String get verifierCniBackTitle => 'Carte d\'identité — verso';

  @override
  String get verifierPhotoTitle => 'Photo de vérification (selfie)';

  @override
  String get verifierSubmitButton => 'Envoyer ma demande';

  @override
  String get verifierRequestSentSnackbar =>
      'Demande envoyée. Un modérateur va l\'examiner.';

  @override
  String get mediaAnalyzeAppBarTitle => 'Nouvelle analyse';

  @override
  String get mediaAnalyzeCameraButton => 'Appareil photo';

  @override
  String get mediaAnalyzeGalleryButton => 'Galerie';

  @override
  String get mediaAnalyzeOtherFileButton => 'Choisir un autre fichier';

  @override
  String get mediaAnalyzeContextLabel => 'Contexte (facultatif)';

  @override
  String get mediaAnalyzeContextHint =>
      'Ex : reçu sur WhatsApp, prétendument pris hier à Maroua...';

  @override
  String get mediaAnalyzeSubmitButton => 'Lancer l\'analyse';

  @override
  String get mediaAnalyzeNoFileSelected => 'Aucun fichier sélectionné';

  @override
  String get mediaResultAppBarTitle => 'Résultat de l\'analyse';

  @override
  String get mediaResultLoading => 'Analyse en cours...';

  @override
  String get mediaResultNoAnomalies => 'Aucun signal d\'incohérence';

  @override
  String get mediaResultAiSectionTitle => 'Analyse';

  @override
  String get mediaResultDetectedSignalsTitle => 'Signaux détectés';

  @override
  String get mediaResultMatchesFoundTitle => 'Correspondances trouvées';

  @override
  String get mediaResultDisclaimer =>
      'Ces indices ne constituent pas une preuve. Vous pouvez demander l\'avis d\'un modérateur humain pour un examen approfondi.';

  @override
  String get mediaResultRequestReviewButton => 'Demander une revue humaine';

  @override
  String get mediaResultRequestingReview => 'Envoi en cours...';

  @override
  String get mediaResultReviewRequestedSnackbar =>
      'Une revue humaine a été demandée.';

  @override
  String mediaResultSignalsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count signaux détectés',
      one: '1 signal détecté',
    );
    return '$_temp0';
  }

  @override
  String mediaResultSimilarityLabel(String similarity) {
    return '$similarity % de similarité';
  }

  @override
  String mediaResultSubmittedOnLabel(String date) {
    return 'Envoyé le $date';
  }

  @override
  String get eventsHomeAppBarTitle => 'Événements locaux';

  @override
  String get eventsHomeLoading => 'Recherche des événements à proximité...';

  @override
  String get eventsHomeEmptyTitle => 'Aucun événement à proximité';

  @override
  String get eventsHomeEmptySubtitle =>
      'Soyez le premier à signaler un fait vérifiable.';

  @override
  String get eventsHomeReportButton => 'Signaler';

  @override
  String eventsHomeWitnessCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count témoins',
      one: '1 témoin',
    );
    return '$_temp0';
  }

  @override
  String get eventDetailAppBarTitle => 'Détail de l\'événement';

  @override
  String get eventDetailYourTestimonyTitle => 'Votre témoignage';

  @override
  String get eventDetailYourTestimonySubtitle =>
      'Si vous êtes à proximité ou avez connaissance de ce fait, indiquez ce que vous en savez.';

  @override
  String get eventDetailConfirmButton => 'Je confirme';

  @override
  String get eventDetailDisputeButton => 'Je conteste';

  @override
  String get eventDetailUnsureButton => 'Je ne sais pas';

  @override
  String get eventDetailNoTestimonies => 'Aucun témoignage pour l\'instant.';

  @override
  String eventDetailTestimoniesTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Témoignages ($count)',
      one: 'Témoignage (1)',
    );
    return '$_temp0';
  }

  @override
  String get eventDetailTestimonySentSnackbar =>
      'Merci, votre témoignage a été enregistré.';

  @override
  String get eventDetailFlagConfirmedLabel => 'A confirmé';

  @override
  String get eventDetailFlagDisputedLabel => 'A contesté';

  @override
  String get eventDetailFlagUnsureLabel => 'Incertain';

  @override
  String get reportEventAppBarTitle => 'Signaler un événement';

  @override
  String get reportEventDescriptionLabel => 'Description';

  @override
  String get reportEventDescriptionHint =>
      'Décrivez précisément ce que vous avez constaté...';

  @override
  String get reportEventDescriptionTooShort =>
      'Décrivez le fait en quelques mots de plus';

  @override
  String get reportEventCityLabel => 'Ville';

  @override
  String get reportEventCityHint => 'Ex : Maroua';

  @override
  String get reportEventCityRequired => 'Ville requise';

  @override
  String get reportEventLocatingInProgress => 'Localisation en cours...';

  @override
  String get reportEventLocationAttached => 'Position actuelle jointe';

  @override
  String get reportEventAttachLocation => 'Joindre ma position actuelle';

  @override
  String get reportEventLocationUnavailable =>
      'Position indisponible. Vérifiez les permissions de localisation.';

  @override
  String get reportEventSubmitButton => 'Publier le signalement';

  @override
  String get moderationQueueAppBarTitle => 'File de modération';

  @override
  String get moderationQueueEmptyTitle => 'Aucune demande en attente';

  @override
  String get moderationQueueEmptySubtitle =>
      'Toutes les demandes de statut vérificateur ont été traitées.';

  @override
  String get moderationQueueNoSignals => 'Aucun signal détecté';

  @override
  String moderationQueueRequestFrom(String userId) {
    return 'Demande de $userId';
  }

  @override
  String moderationQueueSignalsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count signaux détectés',
      one: '1 signal détecté',
    );
    return '$_temp0';
  }

  @override
  String get applicationDetailAppBarTitle => 'Demande vérificateur';

  @override
  String get applicationDetailAccessNotice =>
      'Accès temporaire et journalisé. Ces documents ne sont pas stockés ni partagés au-delà de cette vérification.';

  @override
  String applicationDetailPhoneLabel(String phoneNumber) {
    return 'Téléphone : $phoneNumber';
  }

  @override
  String get applicationDetailCniFrontTitle => 'Carte d\'identité — recto';

  @override
  String get applicationDetailCniBackTitle => 'Carte d\'identité — verso';

  @override
  String get applicationDetailVerificationPhotoTitle => 'Photo de vérification';

  @override
  String get applicationDetailAutoSignalsTitle => 'Signaux automatiques';

  @override
  String get applicationDetailDecisionNotice =>
      'Ces signaux sont fournis à titre indicatif. La décision finale vous revient.';

  @override
  String get applicationDetailRejectButton => 'Rejeter';

  @override
  String get applicationDetailApproveButton => 'Approuver';

  @override
  String get applicationDetailRejectReasonTitle => 'Motif du rejet';

  @override
  String get applicationDetailRejectReasonHint =>
      'Expliquez brièvement la raison...';

  @override
  String get applicationDetailCancelButton => 'Annuler';

  @override
  String get applicationDetailConfirmButton => 'Confirmer';

  @override
  String get adminUsersAppBarTitle => 'Utilisateurs';

  @override
  String get adminUsersChangeRoleTitle => 'Changer le rôle';

  @override
  String get auditLogAppBarTitle => 'Journal d\'audit';

  @override
  String get auditLogEmptyTitle => 'Aucune entrée pour l\'instant';

  @override
  String auditLogByLabel(
      String accessedBy, String targetCollection, String targetId) {
    return 'Par $accessedBy · $targetCollection/$targetId';
  }
}
