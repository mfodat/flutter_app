import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
class BioManager {
  bool _isFingerBiometricSupported = false;
  LocalAuthentication biometricsAuth = new LocalAuthentication();

  Future<bool> _checkIsFingerBiometricSupported() async{
    bool canCheckBiometrics =  await _checkBiometrics();
    if(canCheckBiometrics){
      List<BiometricType>   availableBiometrics = await _getAvailableBiometrics ();
      for(BiometricType type in availableBiometrics){
        return type == BiometricType.fingerprint ;
      }
    }
    return false;
  }

  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics = false;
    try{
      canCheckBiometrics =await biometricsAuth.canCheckBiometrics;
    } on PlatformException catch(e){
      print(e);
      //Todo handle exception

    }
    return canCheckBiometrics;
  }

  Future<List<BiometricType> > _getAvailableBiometrics() async {
    List<BiometricType>   availableBiometrics ;
    try{
      availableBiometrics = await biometricsAuth.getAvailableBiometrics();
    } on PlatformException catch(e){
      print(e);
      //Todo handle exception
    }
    return availableBiometrics;

  }

  Future<bool> isFingerAuth() async {
    bool auth = false;

    try{
      auth =await biometricsAuth.authenticateWithBiometrics(localizedReason: 'scan your fingure',
          stickyAuth: true,
          useErrorDialogs: true);
    } on PlatformException catch(e){
      print(e);
      //Todo handle exception
    }
    return auth;
  }

}