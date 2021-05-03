import 'dart:io';

import 'package:walf/src/core/services/database_file_service.dart';
import 'package:walf/src/core/services/encryption_services/encoding_decoding_service.dart';
import 'package:walf/src/logger/walf_logger.dart';

class WalfProviderService {
  File? _databaseFile;
  DatabaseFileService _databaseFileService = DatabaseFileService();

  Future<String> _getPassword(File file) async {
    return _databaseFileService.getLine(file, 0);
  }

  Future<Map<String, dynamic>> getAllData(String database) async {
    var file = await _databaseFileService.getFile(database);
    String content = await _databaseFileService.getFileContent(file);
    String password = await _getPassword(file);
    return EncodingDecodingService.walfJsonDecode(content, password);
  }

  Future<void> initDatabase(String databaseName) async {
    WalfLogger.initialize();
    _databaseFile = await _databaseFileService.getFile(databaseName);
    var data = getAllData(databaseName);
    WalfLogger.nullLog(
        data, "Walf Database Data is null. Please first create new database.");
  }

  Future<bool> existsDatabase(String databaseName) async {
    return await _databaseFileService.existDatabase(databaseName);
  }

  Future<void> createNewDatabase(String databaseName) async {
    bool created = await _databaseFileService.createNewFile(databaseName);
    print(created);
    if (created) {
      WalfLogger.fine(databaseName + " Database Created.");
    } else {
      WalfLogger.warning(databaseName + " Not Created.");
    }
  }

  Future<void> updateData(
      String databaseName, String key, dynamic newValue) async {
    Map<String, dynamic> data = await getAllData(databaseName);
    data[key] = newValue;
    var file = await _databaseFileService.getFile(databaseName);
    String password = await _getPassword(file);
    _databaseFileService.writeFileContent(
      databaseName,
      EncodingDecodingService.walfJsonEncode(data, password),
      password,
    );
  }

  Future<void> removeData(String databaseName, String key) async {
    Map<String, dynamic> data = await getAllData(databaseName);
    var file = await _databaseFileService.getFile(databaseName);
    String password = await _getPassword(file);
    data.remove(key);
    _databaseFileService.writeFileContent(
      databaseName,
      EncodingDecodingService.walfJsonEncode(data, password),
      password,
    );
  }
}
