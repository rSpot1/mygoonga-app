import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @navAnalyze.
  ///
  /// In fr, this message translates to:
  /// **'Analyser'**
  String get navAnalyze;

  /// No description provided for @navEvents.
  ///
  /// In fr, this message translates to:
  /// **'Événements'**
  String get navEvents;

  /// No description provided for @navProfile.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get navProfile;

  /// No description provided for @mediaHomeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Vérifier un média'**
  String get mediaHomeTitle;

  /// No description provided for @mediaHomeHeading.
  ///
  /// In fr, this message translates to:
  /// **'Une photo ou vidéo vous semble suspecte ?'**
  String get mediaHomeHeading;

  /// No description provided for @mediaHomeBody.
  ///
  /// In fr, this message translates to:
  /// **'Envoyez-la ici : nous examinons sa cohérence technique pour vous donner des indices, sans jamais trancher à votre place.'**
  String get mediaHomeBody;

  /// No description provided for @mediaHomeInfoMetadataTitle.
  ///
  /// In fr, this message translates to:
  /// **'Métadonnées'**
  String get mediaHomeInfoMetadataTitle;

  /// No description provided for @mediaHomeInfoMetadataSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Date, appareil, position, indices de capture d\'écran.'**
  String get mediaHomeInfoMetadataSubtitle;

  /// No description provided for @mediaHomeInfoElaTitle.
  ///
  /// In fr, this message translates to:
  /// **'Analyse par niveaux d\'erreur'**
  String get mediaHomeInfoElaTitle;

  /// No description provided for @mediaHomeInfoElaSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Recherche de zones potentiellement retouchées.'**
  String get mediaHomeInfoElaSubtitle;

  /// No description provided for @mediaHomeInfoReverseTitle.
  ///
  /// In fr, this message translates to:
  /// **'Recherche inversée'**
  String get mediaHomeInfoReverseTitle;

  /// No description provided for @mediaHomeInfoReverseSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Vérifie si le contenu a déjà été soumis ailleurs.'**
  String get mediaHomeInfoReverseSubtitle;

  /// No description provided for @mediaHomeChooseFileButton.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un fichier à analyser'**
  String get mediaHomeChooseFileButton;

  /// No description provided for @mediaHomeShareTip.
  ///
  /// In fr, this message translates to:
  /// **'Astuce : depuis WhatsApp ou votre galerie, utilisez \"Partager\" puis choisissez MyGoonga.'**
  String get mediaHomeShareTip;

  /// No description provided for @profileTitle.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @profileEmailLabel.
  ///
  /// In fr, this message translates to:
  /// **'E-mail'**
  String get profileEmailLabel;

  /// No description provided for @profileCityLabel.
  ///
  /// In fr, this message translates to:
  /// **'Ville déclarée'**
  String get profileCityLabel;

  /// No description provided for @profileCityUnknown.
  ///
  /// In fr, this message translates to:
  /// **'Non renseignée'**
  String get profileCityUnknown;

  /// No description provided for @profileReputationLabel.
  ///
  /// In fr, this message translates to:
  /// **'Réputation'**
  String get profileReputationLabel;

  /// No description provided for @profileLanguageLabel.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get profileLanguageLabel;

  /// No description provided for @profileLanguageFrench.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get profileLanguageFrench;

  /// No description provided for @profileLanguageEnglish.
  ///
  /// In fr, this message translates to:
  /// **'English'**
  String get profileLanguageEnglish;

  /// No description provided for @profileSignOut.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get profileSignOut;

  /// No description provided for @profileDefaultUser.
  ///
  /// In fr, this message translates to:
  /// **'Utilisateur'**
  String get profileDefaultUser;

  /// No description provided for @profileVerifierPending.
  ///
  /// In fr, this message translates to:
  /// **'Votre demande de statut vérificateur est en cours d\'examen.'**
  String get profileVerifierPending;

  /// No description provided for @profileVerifierRejected.
  ///
  /// In fr, this message translates to:
  /// **'Votre précédente demande de statut vérificateur n\'a pas été retenue.'**
  String get profileVerifierRejected;

  /// No description provided for @profileBecomeVerifierTitle.
  ///
  /// In fr, this message translates to:
  /// **'Devenir vérificateur'**
  String get profileBecomeVerifierTitle;

  /// No description provided for @profileBecomeVerifierSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez votre identité pour que vos témoignages comptent davantage.'**
  String get profileBecomeVerifierSubtitle;

  /// No description provided for @profileModerationQueueTitle.
  ///
  /// In fr, this message translates to:
  /// **'File de modération'**
  String get profileModerationQueueTitle;

  /// No description provided for @profileModerationQueueSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Examiner les demandes de statut vérificateur en attente.'**
  String get profileModerationQueueSubtitle;

  /// No description provided for @profileUserManagementTitle.
  ///
  /// In fr, this message translates to:
  /// **'Gestion des utilisateurs'**
  String get profileUserManagementTitle;

  /// No description provided for @profileUserManagementSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Attribuer ou modifier les rôles des comptes.'**
  String get profileUserManagementSubtitle;

  /// No description provided for @profileAuditLogTitle.
  ///
  /// In fr, this message translates to:
  /// **'Journal d\'audit'**
  String get profileAuditLogTitle;

  /// No description provided for @profileAuditLogSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Consulter les accès aux données sensibles.'**
  String get profileAuditLogSubtitle;

  /// No description provided for @commonRetry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get commonRetry;

  /// No description provided for @statusReliableLabel.
  ///
  /// In fr, this message translates to:
  /// **'Probablement fiable'**
  String get statusReliableLabel;

  /// No description provided for @statusReliableDescription.
  ///
  /// In fr, this message translates to:
  /// **'Confirmé par plusieurs témoins de proximité, dont des vérificateurs.'**
  String get statusReliableDescription;

  /// No description provided for @statusDoubtfulLabel.
  ///
  /// In fr, this message translates to:
  /// **'Probablement douteux'**
  String get statusDoubtfulLabel;

  /// No description provided for @statusDoubtfulDescription.
  ///
  /// In fr, this message translates to:
  /// **'Contesté par plusieurs témoins de proximité, dont des vérificateurs.'**
  String get statusDoubtfulDescription;

  /// No description provided for @statusInsufficientLabel.
  ///
  /// In fr, this message translates to:
  /// **'Pas assez d\'informations'**
  String get statusInsufficientLabel;

  /// No description provided for @statusInsufficientDescription.
  ///
  /// In fr, this message translates to:
  /// **'Trop peu de confirmations pour établir un statut fiable.'**
  String get statusInsufficientDescription;

  /// No description provided for @statusUnknownLabel.
  ///
  /// In fr, this message translates to:
  /// **'Statut inconnu'**
  String get statusUnknownLabel;

  /// No description provided for @roleStandard.
  ///
  /// In fr, this message translates to:
  /// **'Standard'**
  String get roleStandard;

  /// No description provided for @roleVerifier.
  ///
  /// In fr, this message translates to:
  /// **'Vérificateur'**
  String get roleVerifier;

  /// No description provided for @roleModerator.
  ///
  /// In fr, this message translates to:
  /// **'Modérateur'**
  String get roleModerator;

  /// No description provided for @roleAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Administrateur'**
  String get roleAdmin;

  /// No description provided for @flagNoMetadata.
  ///
  /// In fr, this message translates to:
  /// **'Aucune métadonnée EXIF'**
  String get flagNoMetadata;

  /// No description provided for @flagMissingExif.
  ///
  /// In fr, this message translates to:
  /// **'Métadonnées EXIF absentes'**
  String get flagMissingExif;

  /// No description provided for @flagPossibleScreenshot.
  ///
  /// In fr, this message translates to:
  /// **'Ressemble à une capture d\'écran'**
  String get flagPossibleScreenshot;

  /// No description provided for @flagElaAnomaly.
  ///
  /// In fr, this message translates to:
  /// **'Zone de compression incohérente'**
  String get flagElaAnomaly;

  /// No description provided for @flagReverseMatchFound.
  ///
  /// In fr, this message translates to:
  /// **'Contenu déjà vu ailleurs'**
  String get flagReverseMatchFound;

  /// No description provided for @flagLocationMismatch.
  ///
  /// In fr, this message translates to:
  /// **'Localisation incohérente'**
  String get flagLocationMismatch;

  /// No description provided for @flagSuspiciousDate.
  ///
  /// In fr, this message translates to:
  /// **'Date suspecte'**
  String get flagSuspiciousDate;

  /// No description provided for @flagUnparsableDate.
  ///
  /// In fr, this message translates to:
  /// **'Date illisible'**
  String get flagUnparsableDate;

  /// No description provided for @metadataScopeFront.
  ///
  /// In fr, this message translates to:
  /// **'CNI recto — '**
  String get metadataScopeFront;

  /// No description provided for @metadataScopeBack.
  ///
  /// In fr, this message translates to:
  /// **'CNI verso — '**
  String get metadataScopeBack;

  /// No description provided for @metadataScopeVerification.
  ///
  /// In fr, this message translates to:
  /// **'Photo de vérification — '**
  String get metadataScopeVerification;

  /// No description provided for @metadataCodeMissingExif.
  ///
  /// In fr, this message translates to:
  /// **'métadonnées absentes'**
  String get metadataCodeMissingExif;

  /// No description provided for @metadataCodePossibleScreenshot.
  ///
  /// In fr, this message translates to:
  /// **'ressemble à une capture d\'écran'**
  String get metadataCodePossibleScreenshot;

  /// No description provided for @metadataCodeLocationMismatch.
  ///
  /// In fr, this message translates to:
  /// **'localisation incohérente avec la ville déclarée'**
  String get metadataCodeLocationMismatch;

  /// No description provided for @metadataCodeSuspiciousDate.
  ///
  /// In fr, this message translates to:
  /// **'date manifestement ancienne'**
  String get metadataCodeSuspiciousDate;

  /// No description provided for @metadataCodeUnparsableDate.
  ///
  /// In fr, this message translates to:
  /// **'date illisible'**
  String get metadataCodeUnparsableDate;

  /// No description provided for @loginCreateAccountTitle.
  ///
  /// In fr, this message translates to:
  /// **'Créer un compte'**
  String get loginCreateAccountTitle;

  /// No description provided for @loginWelcomeBackTitle.
  ///
  /// In fr, this message translates to:
  /// **'Bon retour'**
  String get loginWelcomeBackTitle;

  /// No description provided for @loginRegisterSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Rejoignez la communauté de vérification MyGoonga.'**
  String get loginRegisterSubtitle;

  /// No description provided for @loginSignInSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Connectez-vous pour continuer.'**
  String get loginSignInSubtitle;

  /// No description provided for @loginEmailHint.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail'**
  String get loginEmailHint;

  /// No description provided for @loginEmailInvalid.
  ///
  /// In fr, this message translates to:
  /// **'E-mail invalide'**
  String get loginEmailInvalid;

  /// No description provided for @loginPasswordHint.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get loginPasswordHint;

  /// No description provided for @loginPasswordTooShort.
  ///
  /// In fr, this message translates to:
  /// **'6 caractères minimum'**
  String get loginPasswordTooShort;

  /// No description provided for @loginForgotPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get loginForgotPassword;

  /// No description provided for @loginEnterEmailForReset.
  ///
  /// In fr, this message translates to:
  /// **'Renseignez votre e-mail pour réinitialiser le mot de passe.'**
  String get loginEnterEmailForReset;

  /// No description provided for @loginResetEmailSent.
  ///
  /// In fr, this message translates to:
  /// **'E-mail de réinitialisation envoyé.'**
  String get loginResetEmailSent;

  /// No description provided for @loginCreateAccountButton.
  ///
  /// In fr, this message translates to:
  /// **'Créer mon compte'**
  String get loginCreateAccountButton;

  /// No description provided for @loginSignInButton.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get loginSignInButton;

  /// No description provided for @loginOrDivider.
  ///
  /// In fr, this message translates to:
  /// **'ou'**
  String get loginOrDivider;

  /// No description provided for @loginContinueWithGoogle.
  ///
  /// In fr, this message translates to:
  /// **'Continuer avec Google'**
  String get loginContinueWithGoogle;

  /// No description provided for @loginSwitchToSignIn.
  ///
  /// In fr, this message translates to:
  /// **'Vous avez déjà un compte ? Se connecter'**
  String get loginSwitchToSignIn;

  /// No description provided for @loginSwitchToRegister.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore de compte ? En créer un'**
  String get loginSwitchToRegister;

  /// No description provided for @loginGenericError.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue. Réessayez.'**
  String get loginGenericError;

  /// No description provided for @loginGoogleError.
  ///
  /// In fr, this message translates to:
  /// **'La connexion avec Google a échoué. Réessayez.'**
  String get loginGoogleError;

  /// No description provided for @loginErrorUserNotFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun compte ne correspond à cet e-mail.'**
  String get loginErrorUserNotFound;

  /// No description provided for @loginErrorWrongPassword.
  ///
  /// In fr, this message translates to:
  /// **'E-mail ou mot de passe incorrect.'**
  String get loginErrorWrongPassword;

  /// No description provided for @loginErrorEmailInUse.
  ///
  /// In fr, this message translates to:
  /// **'Un compte existe déjà avec cet e-mail.'**
  String get loginErrorEmailInUse;

  /// No description provided for @loginErrorWeakPassword.
  ///
  /// In fr, this message translates to:
  /// **'Le mot de passe doit contenir au moins 6 caractères.'**
  String get loginErrorWeakPassword;

  /// No description provided for @loginErrorInvalidEmail.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail invalide.'**
  String get loginErrorInvalidEmail;

  /// No description provided for @loginErrorGenericCode.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue ({code}).'**
  String loginErrorGenericCode(String code);

  /// No description provided for @verifierAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'Devenir vérificateur'**
  String get verifierAppBarTitle;

  /// No description provided for @verifierPrivacyNotice.
  ///
  /// In fr, this message translates to:
  /// **'Vos documents sont examinés uniquement par un modérateur habilité et ne sont jamais visibles par les autres utilisateurs.'**
  String get verifierPrivacyNotice;

  /// No description provided for @verifierPhotosRequiredError.
  ///
  /// In fr, this message translates to:
  /// **'Les trois photos sont requises.'**
  String get verifierPhotosRequiredError;

  /// No description provided for @verifierPhoneLabel.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de téléphone'**
  String get verifierPhoneLabel;

  /// No description provided for @verifierPhoneInvalid.
  ///
  /// In fr, this message translates to:
  /// **'Numéro invalide'**
  String get verifierPhoneInvalid;

  /// No description provided for @verifierCniFrontTitle.
  ///
  /// In fr, this message translates to:
  /// **'Carte d\'identité — recto'**
  String get verifierCniFrontTitle;

  /// No description provided for @verifierCniBackTitle.
  ///
  /// In fr, this message translates to:
  /// **'Carte d\'identité — verso'**
  String get verifierCniBackTitle;

  /// No description provided for @verifierPhotoTitle.
  ///
  /// In fr, this message translates to:
  /// **'Photo de vérification (selfie)'**
  String get verifierPhotoTitle;

  /// No description provided for @verifierSubmitButton.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer ma demande'**
  String get verifierSubmitButton;

  /// No description provided for @verifierRequestSentSnackbar.
  ///
  /// In fr, this message translates to:
  /// **'Demande envoyée. Un modérateur va l\'examiner.'**
  String get verifierRequestSentSnackbar;

  /// No description provided for @mediaAnalyzeAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle analyse'**
  String get mediaAnalyzeAppBarTitle;

  /// No description provided for @mediaAnalyzeCameraButton.
  ///
  /// In fr, this message translates to:
  /// **'Appareil photo'**
  String get mediaAnalyzeCameraButton;

  /// No description provided for @mediaAnalyzeGalleryButton.
  ///
  /// In fr, this message translates to:
  /// **'Galerie'**
  String get mediaAnalyzeGalleryButton;

  /// No description provided for @mediaAnalyzeOtherFileButton.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un autre fichier'**
  String get mediaAnalyzeOtherFileButton;

  /// No description provided for @mediaAnalyzeContextLabel.
  ///
  /// In fr, this message translates to:
  /// **'Contexte (facultatif)'**
  String get mediaAnalyzeContextLabel;

  /// No description provided for @mediaAnalyzeContextHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex : reçu sur WhatsApp, prétendument pris hier à Maroua...'**
  String get mediaAnalyzeContextHint;

  /// No description provided for @mediaAnalyzeSubmitButton.
  ///
  /// In fr, this message translates to:
  /// **'Lancer l\'analyse'**
  String get mediaAnalyzeSubmitButton;

  /// No description provided for @mediaAnalyzeNoFileSelected.
  ///
  /// In fr, this message translates to:
  /// **'Aucun fichier sélectionné'**
  String get mediaAnalyzeNoFileSelected;

  /// No description provided for @mediaResultAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'Résultat de l\'analyse'**
  String get mediaResultAppBarTitle;

  /// No description provided for @mediaResultLoading.
  ///
  /// In fr, this message translates to:
  /// **'Analyse en cours...'**
  String get mediaResultLoading;

  /// No description provided for @mediaResultNoAnomalies.
  ///
  /// In fr, this message translates to:
  /// **'Aucun signal d\'incohérence'**
  String get mediaResultNoAnomalies;

  /// No description provided for @mediaResultAiSectionTitle.
  ///
  /// In fr, this message translates to:
  /// **'Analyse'**
  String get mediaResultAiSectionTitle;

  /// No description provided for @mediaResultDetectedSignalsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Signaux détectés'**
  String get mediaResultDetectedSignalsTitle;

  /// No description provided for @mediaResultMatchesFoundTitle.
  ///
  /// In fr, this message translates to:
  /// **'Correspondances trouvées'**
  String get mediaResultMatchesFoundTitle;

  /// No description provided for @mediaResultDisclaimer.
  ///
  /// In fr, this message translates to:
  /// **'Ces indices ne constituent pas une preuve. Vous pouvez demander l\'avis d\'un modérateur humain pour un examen approfondi.'**
  String get mediaResultDisclaimer;

  /// No description provided for @mediaResultRequestReviewButton.
  ///
  /// In fr, this message translates to:
  /// **'Demander une revue humaine'**
  String get mediaResultRequestReviewButton;

  /// No description provided for @mediaResultRequestingReview.
  ///
  /// In fr, this message translates to:
  /// **'Envoi en cours...'**
  String get mediaResultRequestingReview;

  /// No description provided for @mediaResultReviewRequestedSnackbar.
  ///
  /// In fr, this message translates to:
  /// **'Une revue humaine a été demandée.'**
  String get mediaResultReviewRequestedSnackbar;

  /// No description provided for @mediaResultSignalsCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{1 signal détecté} other{{count} signaux détectés}}'**
  String mediaResultSignalsCount(int count);

  /// No description provided for @mediaResultSimilarityLabel.
  ///
  /// In fr, this message translates to:
  /// **'{similarity} % de similarité'**
  String mediaResultSimilarityLabel(String similarity);

  /// No description provided for @mediaResultSubmittedOnLabel.
  ///
  /// In fr, this message translates to:
  /// **'Envoyé le {date}'**
  String mediaResultSubmittedOnLabel(String date);

  /// No description provided for @eventsHomeAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'Événements locaux'**
  String get eventsHomeAppBarTitle;

  /// No description provided for @eventsHomeLoading.
  ///
  /// In fr, this message translates to:
  /// **'Recherche des événements à proximité...'**
  String get eventsHomeLoading;

  /// No description provided for @eventsHomeEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun événement à proximité'**
  String get eventsHomeEmptyTitle;

  /// No description provided for @eventsHomeEmptySubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Soyez le premier à signaler un fait vérifiable.'**
  String get eventsHomeEmptySubtitle;

  /// No description provided for @eventsHomeReportButton.
  ///
  /// In fr, this message translates to:
  /// **'Signaler'**
  String get eventsHomeReportButton;

  /// No description provided for @eventsHomeWitnessCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{1 témoin} other{{count} témoins}}'**
  String eventsHomeWitnessCount(int count);

  /// No description provided for @eventDetailAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'Détail de l\'événement'**
  String get eventDetailAppBarTitle;

  /// No description provided for @eventDetailYourTestimonyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Votre témoignage'**
  String get eventDetailYourTestimonyTitle;

  /// No description provided for @eventDetailYourTestimonySubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Si vous êtes à proximité ou avez connaissance de ce fait, indiquez ce que vous en savez.'**
  String get eventDetailYourTestimonySubtitle;

  /// No description provided for @eventDetailConfirmButton.
  ///
  /// In fr, this message translates to:
  /// **'Je confirme'**
  String get eventDetailConfirmButton;

  /// No description provided for @eventDetailDisputeButton.
  ///
  /// In fr, this message translates to:
  /// **'Je conteste'**
  String get eventDetailDisputeButton;

  /// No description provided for @eventDetailUnsureButton.
  ///
  /// In fr, this message translates to:
  /// **'Je ne sais pas'**
  String get eventDetailUnsureButton;

  /// No description provided for @eventDetailNoTestimonies.
  ///
  /// In fr, this message translates to:
  /// **'Aucun témoignage pour l\'instant.'**
  String get eventDetailNoTestimonies;

  /// No description provided for @eventDetailTestimoniesTitle.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{Témoignage (1)} other{Témoignages ({count})}}'**
  String eventDetailTestimoniesTitle(int count);

  /// No description provided for @eventDetailTestimonySentSnackbar.
  ///
  /// In fr, this message translates to:
  /// **'Merci, votre témoignage a été enregistré.'**
  String get eventDetailTestimonySentSnackbar;

  /// No description provided for @eventDetailFlagConfirmedLabel.
  ///
  /// In fr, this message translates to:
  /// **'A confirmé'**
  String get eventDetailFlagConfirmedLabel;

  /// No description provided for @eventDetailFlagDisputedLabel.
  ///
  /// In fr, this message translates to:
  /// **'A contesté'**
  String get eventDetailFlagDisputedLabel;

  /// No description provided for @eventDetailFlagUnsureLabel.
  ///
  /// In fr, this message translates to:
  /// **'Incertain'**
  String get eventDetailFlagUnsureLabel;

  /// No description provided for @reportEventAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'Signaler un événement'**
  String get reportEventAppBarTitle;

  /// No description provided for @reportEventDescriptionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get reportEventDescriptionLabel;

  /// No description provided for @reportEventDescriptionHint.
  ///
  /// In fr, this message translates to:
  /// **'Décrivez précisément ce que vous avez constaté...'**
  String get reportEventDescriptionHint;

  /// No description provided for @reportEventDescriptionTooShort.
  ///
  /// In fr, this message translates to:
  /// **'Décrivez le fait en quelques mots de plus'**
  String get reportEventDescriptionTooShort;

  /// No description provided for @reportEventCityLabel.
  ///
  /// In fr, this message translates to:
  /// **'Ville'**
  String get reportEventCityLabel;

  /// No description provided for @reportEventCityHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex : Maroua'**
  String get reportEventCityHint;

  /// No description provided for @reportEventCityRequired.
  ///
  /// In fr, this message translates to:
  /// **'Ville requise'**
  String get reportEventCityRequired;

  /// No description provided for @reportEventLocatingInProgress.
  ///
  /// In fr, this message translates to:
  /// **'Localisation en cours...'**
  String get reportEventLocatingInProgress;

  /// No description provided for @reportEventLocationAttached.
  ///
  /// In fr, this message translates to:
  /// **'Position actuelle jointe'**
  String get reportEventLocationAttached;

  /// No description provided for @reportEventAttachLocation.
  ///
  /// In fr, this message translates to:
  /// **'Joindre ma position actuelle'**
  String get reportEventAttachLocation;

  /// No description provided for @reportEventLocationUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'Position indisponible. Vérifiez les permissions de localisation.'**
  String get reportEventLocationUnavailable;

  /// No description provided for @reportEventSubmitButton.
  ///
  /// In fr, this message translates to:
  /// **'Publier le signalement'**
  String get reportEventSubmitButton;

  /// No description provided for @moderationQueueAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'File de modération'**
  String get moderationQueueAppBarTitle;

  /// No description provided for @moderationQueueEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucune demande en attente'**
  String get moderationQueueEmptyTitle;

  /// No description provided for @moderationQueueEmptySubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Toutes les demandes de statut vérificateur ont été traitées.'**
  String get moderationQueueEmptySubtitle;

  /// No description provided for @moderationQueueNoSignals.
  ///
  /// In fr, this message translates to:
  /// **'Aucun signal détecté'**
  String get moderationQueueNoSignals;

  /// No description provided for @moderationQueueRequestFrom.
  ///
  /// In fr, this message translates to:
  /// **'Demande de {userId}'**
  String moderationQueueRequestFrom(String userId);

  /// No description provided for @moderationQueueSignalsCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{1 signal détecté} other{{count} signaux détectés}}'**
  String moderationQueueSignalsCount(int count);

  /// No description provided for @applicationDetailAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'Demande vérificateur'**
  String get applicationDetailAppBarTitle;

  /// No description provided for @applicationDetailAccessNotice.
  ///
  /// In fr, this message translates to:
  /// **'Accès temporaire et journalisé. Ces documents ne sont pas stockés ni partagés au-delà de cette vérification.'**
  String get applicationDetailAccessNotice;

  /// No description provided for @applicationDetailPhoneLabel.
  ///
  /// In fr, this message translates to:
  /// **'Téléphone : {phoneNumber}'**
  String applicationDetailPhoneLabel(String phoneNumber);

  /// No description provided for @applicationDetailCniFrontTitle.
  ///
  /// In fr, this message translates to:
  /// **'Carte d\'identité — recto'**
  String get applicationDetailCniFrontTitle;

  /// No description provided for @applicationDetailCniBackTitle.
  ///
  /// In fr, this message translates to:
  /// **'Carte d\'identité — verso'**
  String get applicationDetailCniBackTitle;

  /// No description provided for @applicationDetailVerificationPhotoTitle.
  ///
  /// In fr, this message translates to:
  /// **'Photo de vérification'**
  String get applicationDetailVerificationPhotoTitle;

  /// No description provided for @applicationDetailAutoSignalsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Signaux automatiques'**
  String get applicationDetailAutoSignalsTitle;

  /// No description provided for @applicationDetailDecisionNotice.
  ///
  /// In fr, this message translates to:
  /// **'Ces signaux sont fournis à titre indicatif. La décision finale vous revient.'**
  String get applicationDetailDecisionNotice;

  /// No description provided for @applicationDetailRejectButton.
  ///
  /// In fr, this message translates to:
  /// **'Rejeter'**
  String get applicationDetailRejectButton;

  /// No description provided for @applicationDetailApproveButton.
  ///
  /// In fr, this message translates to:
  /// **'Approuver'**
  String get applicationDetailApproveButton;

  /// No description provided for @applicationDetailRejectReasonTitle.
  ///
  /// In fr, this message translates to:
  /// **'Motif du rejet'**
  String get applicationDetailRejectReasonTitle;

  /// No description provided for @applicationDetailRejectReasonHint.
  ///
  /// In fr, this message translates to:
  /// **'Expliquez brièvement la raison...'**
  String get applicationDetailRejectReasonHint;

  /// No description provided for @applicationDetailCancelButton.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get applicationDetailCancelButton;

  /// No description provided for @applicationDetailConfirmButton.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get applicationDetailConfirmButton;

  /// No description provided for @adminUsersAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'Utilisateurs'**
  String get adminUsersAppBarTitle;

  /// No description provided for @adminUsersChangeRoleTitle.
  ///
  /// In fr, this message translates to:
  /// **'Changer le rôle'**
  String get adminUsersChangeRoleTitle;

  /// No description provided for @auditLogAppBarTitle.
  ///
  /// In fr, this message translates to:
  /// **'Journal d\'audit'**
  String get auditLogAppBarTitle;

  /// No description provided for @auditLogEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucune entrée pour l\'instant'**
  String get auditLogEmptyTitle;

  /// No description provided for @auditLogByLabel.
  ///
  /// In fr, this message translates to:
  /// **'Par {accessedBy} · {targetCollection}/{targetId}'**
  String auditLogByLabel(
      String accessedBy, String targetCollection, String targetId);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
