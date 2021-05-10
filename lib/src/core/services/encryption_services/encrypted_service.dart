import 'dart:math';
import 'package:encrypt/encrypt.dart';

class EncryptionService {
  static String _getModifiedPasswordFrom(String initialKey, String password) {
    var paddingNeeded = 32 - initialKey.length;

    return paddingNeeded == 0
        ? initialKey
        : initialKey + password.substring(0, paddingNeeded);
  }

  static String _getModifiedIvPasswordFrom(String initialIV, String password) {
    initialIV = initialIV.substring(0, min(6, initialIV.length));
    var paddingNeeded = 8 - initialIV.length;
    return initialIV + password.substring(0, paddingNeeded);
  }

  static String decrypt(String password, String key, String base64Data) {
    final decryptionPass = _getModifiedPasswordFrom(key, password);
    final iv = IV.fromUtf8(_getModifiedIvPasswordFrom(key, password));

    final encrypter = Encrypter(
      Salsa20(Key.fromUtf8(decryptionPass)),
    );

    return encrypter.decrypt64(base64Data, iv: iv);
  }

  static String encrypt(String key, String password, String data) {
    final encryptionPassword = _getModifiedPasswordFrom(key, password);
    final iv = IV.fromUtf8(_getModifiedIvPasswordFrom(key, password));

    final encrypter = Encrypter(
      Salsa20(Key.fromUtf8(encryptionPassword)),
    );

    return encrypter.encrypt(data, iv: iv).base64;
  }
}
