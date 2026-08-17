import 'dart:async';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';

/// Ecoute le contenu partage depuis d'autres applications (WhatsApp, galerie,
/// navigateur...) vers MyGoonga, via le mecanisme de partage natif Android /
/// iOS ("Partager -> MyGoonga"). Voir README pour la configuration native
/// requise (intent-filter Android, Share Extension iOS).
class ShareIntentService {
  ShareIntentService._internal();
  static final ShareIntentService instance = ShareIntentService._internal();

  StreamSubscription? _mediaSub;

  /// Fichiers partages recus alors que l'app etait fermee (cold start).
  Future<List<SharedMediaFile>> getInitialSharedFiles() async {
    final initial = await ReceiveSharingIntent.instance.getInitialMedia();
    return initial;
  }

  /// Ecoute les partages recus alors que l'app est deja ouverte.
  void listen(void Function(List<SharedMediaFile> files) onReceive) {
    _mediaSub?.cancel();
    _mediaSub = ReceiveSharingIntent.instance.getMediaStream().listen(onReceive);
  }

  void resetIntent() {
    ReceiveSharingIntent.instance.reset();
  }

  void dispose() {
    _mediaSub?.cancel();
  }
}
