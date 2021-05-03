import 'dart:convert';
import 'package:walf/src/core/services/encryption_services/encrypted_service.dart';

class EncodingDecodingService {
  static String walfJsonEncode(Map<String, dynamic> data, String password) {
    String encodedString = jsonEncode(data);

    return EncryptionService.encrypt(password, encodedString);
  }

  static Map<String, dynamic> walfJsonDecode(String data, String password) {
    String decryptedString = EncryptionService.decrypt(password, data);

    return jsonDecode(decryptedString);
  }
}
