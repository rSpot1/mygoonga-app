import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationService._internal();
  static final LocationService instance = LocationService._internal();

  /// Renvoie la position actuelle, en demandant la permission si besoin.
  /// Renvoie null si la permission est refusee ou le service desactive :
  /// les ecrans appelants doivent alors proposer une saisie manuelle de ville.
  Future<Position?> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (_) {
      return null;
    }
  }
}
