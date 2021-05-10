/// Import packages for WalfDatabase class
import 'package:walf/src/core/core.dart';
import 'package:walf/src/logger/logger.dart';
import 'package:walf/src/models/models.dart';

/// Exports all files
export 'package:walf/src/models/models.dart';
export 'package:walf/src/logger/logger.dart';
export 'package:walf/src/core/core.dart';

/// Create a [Walf Database]
class WalfDatabase {
  /// Walf is a secure and fast key-value based database based on JSON.
  /// It uses 'AES-256 CBC' encryption algorithm for Walf security.
  /// Keeps all data in a customized JSON file with ".wfdb" extension in the device.
  final String databaseName;
  final String password;

  /// Get database name

  WalfDatabase(this.databaseName, {required this.password});

  /// Instance [WalfProviderService]
  WalfProviderService _providerService = WalfProviderService();

  Future<void> initDatabase() async {
    /// This future for database initialize
    await _providerService.initDatabase(databaseName, password);
  }

  Future<Map<String, dynamic>> getAllJSONData() async {
    return (await _providerService.getAllData(databaseName, password));
  }

  _getData(String key, String databaseName) async {
    /// getAllData for other futures so private function
    return (await _providerService.getAllData(databaseName, password))[key];
  }

  removeData(String key) {
    /// Database remove data
    _providerService.removeData(databaseName, key, password);
  }

  Future<bool> existDatabase() async {
    /// For check database exist
    return _providerService.existsDatabase(databaseName);
  }

  createDatabase() {
    /// Create new database and write first data
    _providerService.createNewDatabase(databaseName, password);
  }

  setString(String key, String value) {
    /// Insert String data to named database
    _providerService.updateData(
      databaseName,
      password,
      key,
      value,
    );
  }

  Future<WalfString> getString(String key) async {
    var data = await _getData(key, databaseName);

    /// Get all datas from named database.
    if (data.runtimeType == String) {
      ///Check data type
      return WalfString(key, data);

      /// if true, return json data
    } else {
      WalfLogger.warning("$key: String data not found");

      /// if false, warn developper by WalfLogger
      return WalfString(key, "");

      /// if false, return empty
    }
  }

  setInt(String key, int value) {
    /// Insert Integer data to named database

    _providerService.updateData(
      databaseName,
      password,
      key,
      value,
    );
  }

  Future<WalfInt> getInt(String key) async {
    var data = await _getData(key, databaseName);

    /// Get all datas from named database.
    if (data.runtimeType == int) {
      ///Check data type

      return WalfInt(key, data);

      /// if true, return json data
    } else {
      WalfLogger.warning("$key: Integer data not found");

      /// if false, warn developper by WalfLogger
      return WalfInt(key, 0);

      /// if false, return empty
    }
  }

  setDouble(String key, double value) {
    /// Insert Double data to named database

    _providerService.updateData(
      databaseName,
      password,
      key,
      value,
    );
  }

  Future<WalfDouble>? getDouble(String key) async {
    var data = await _getData(key, databaseName);

    /// Get all datas from named database.
    if (data.runtimeType == double) {
      ///Check data type

      return WalfDouble(key, data);

      /// if true, return json data
    } else {
      WalfLogger.warning("$key: Double data not found");

      /// if false, warn developper by WalfLogger
      return WalfDouble(key, 0);

      /// if false, return 0
    }
  }

  setBool(String key, bool value) {
    /// Insert Bool data to named database

    _providerService.updateData(
      databaseName,
      password,
      key,
      value,
    );
  }

  Future<WalfBool> getBool(String key) async {
    var data = _getData(key, databaseName);

    /// Get all datas from named database.
    if (data.runtimeType == bool) {
      return WalfBool(key, data);

      /// if true, return json data
    } else {
      WalfLogger.warning("$key: Double data not found");

      /// if false, warn developper by WalfLogger
      return WalfBool(key, false);

      /// if false, return FALSE
    }
  }

  setArray(String key, List value) {
    /// Insert Array data to named database

    _providerService.updateData(
      databaseName,
      password,
      key,
      value,
    );
  }

  Future<WalfList> getArray(String key) async {
    var data = _getData(key, databaseName);

    /// Get all datas from named database.
    if (data.runtimeType == List) {
      return WalfList(key, data);

      /// if true, return json data
    } else {
      WalfLogger.warning("$key: List data not found");

      /// if false, warn developper by WalfLogger
      return WalfList(key, []);

      /// if false, return empty
    }
  }

  setMap(String key, Map value) {
    /// Insert String data to named database

    _providerService.updateData(
      databaseName,
      password,
      key,
      value,
    );
  }

  Future<WalfMap> getMap(String key) async {
    var data = _getData(key, databaseName);

    /// Get all datas from named database.
    if (data.runtimeType == Map) {
      return WalfMap(key, data);

      /// if true, return json data
    } else {
      WalfLogger.warning("$key: Double data not found");

      /// if false, warn developper by WalfLogger
      return WalfMap(key, {});

      /// if false, return empty
    }
  }
}
