import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  /// Verifica se o serviço de localização está habilitado
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Verifica se a permissão de localização foi concedida
  Future<bool> hasLocationPermission() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }

  /// Solicita permissão de localização
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  /// Obtém a localização atual do usuário
  /// 
  /// Retorna null se a localização não puder ser obtida
  Future<Position?> getCurrentLocation() async {
    try {
      // Verifica se o serviço de localização está habilitado
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      // Verifica se a permissão de localização foi concedida
      final hasPermission = await hasLocationPermission();
      if (!hasPermission) {
        final permissionGranted = await requestLocationPermission();
        if (!permissionGranted) {
          return null;
        }
      }

      // Obtém a localização atual
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Erro ao obter localização: $e');
      return null;
    }
  }
}
