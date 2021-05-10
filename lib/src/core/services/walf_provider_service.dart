import 'dart:io';

import 'package:walf/src/core/services/database_file_service.dart';
import 'package:walf/src/core/services/encryption_services/encoding_decoding_service.dart';
import 'package:walf/src/logger/walf_logger.dart';

class WalfProviderService {
  DatabaseFileService _databaseFileService = DatabaseFileService();

  Future<String> _getSecretKey(File file) async {
    return _databaseFileService.getLine(file, 0);
  }

  Future<Map<String, dynamic>> getAllData(
      String database, String password) async {
    var file = await _databaseFileService.getFile(database);
    String content = await _databaseFileService.getFileContent(file);
    String secretKey = await _getSecretKey(file);
    return EncodingDecodingService.walfJsonDecode(content, secretKey, password);
  }

  Future<void> initDatabase(String databaseName, String password) async {
    WalfLogger.initialize();

    var data = getAllData(databaseName, password);
    WalfLogger.nullLog(
        data, "Walf Database Data is null. Please first create new database.");
  }

  Future<bool> existsDatabase(String databaseName) async {
    return await _databaseFileService.existDatabase(databaseName);
  }

  Future<void> createNewDatabase(String databaseName, String password) async {
    bool created =
        await _databaseFileService.createNewFile(databaseName, password);
    if (created) {
      WalfLogger.fine(databaseName + " Database Created.");
    } else {
      WalfLogger.warning(databaseName + " Not Created.");
    }
  }

  Future<void> updateData(String databaseName, String password, String key,
      dynamic newValue) async {
    Map<String, dynamic> data = await getAllData(databaseName, password);
    data[key] = newValue;
    var file = await _databaseFileService.getFile(databaseName);
    String secretKey = await _getSecretKey(file);
    _databaseFileService.fileClean(databaseName);
    _databaseFileService.writeFileContent(
      databaseName,
      EncodingDecodingService.walfJsonEncode(data, secretKey, password),
      secretKey,
    );
  }

  Future<void> removeData(String databaseName, String key, String pass) async {
    Map<String, dynamic> data = await getAllData(databaseName, pass);
    var file = await _databaseFileService.getFile(databaseName);
    String secretKey = await _getSecretKey(file);
    data.remove(key);
    _databaseFileService.fileClean(databaseName);

    _databaseFileService.writeFileContent(
      databaseName,
      EncodingDecodingService.walfJsonEncode(data, secretKey, pass),
      secretKey,
    );
  }
}
