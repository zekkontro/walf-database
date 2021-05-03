import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:walf/src/core/services/encryption_services/encoding_decoding_service.dart';

class DatabaseFileService {
  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  Future<String?> _getDirectoryPath() async {
    String? path = Platform.isAndroid
        ? (await getExternalStorageDirectory())!.path
        : (await getApplicationSupportDirectory()).path;
    return path;
  }

  Future<File> getFile(String fileName) async {
    String? directory = await _getDirectoryPath();
    return File(directory! + "/" + fileName + ".wfdb");
  }

  Future<String> getLine(File file, int index) async {
    List<String> lines = await file.readAsLines();
    print(lines);
    return lines[index];
  }

  Future<bool> createNewFile(String fileName) async {
    String? directory = await _getDirectoryPath();
    print(directory);
    File file = File(directory! + "/" + fileName + ".wfdb");
    await file.create(recursive: true);
    String password = getRandomString(16);
    await writeFileContent(
      fileName,
      EncodingDecodingService.walfJsonEncode({}, password),
      password,
    );
    return file.exists();
  }

  Future<void> deleteFile(File file) async {
    await file.delete(recursive: true);
  }

  Future<String> getFileContent(File file) async {
    List<String> lines = await file.readAsLines();
    print(lines.length);
    lines.removeAt(0);
    print(lines.length);
    String line = "";
    lines.forEach((element) {
      line = line + element;
    });
    return line;
  }

  Future<bool> existDatabase(String fileName) async {
    String? directory = await _getDirectoryPath();
    return File(directory! + "/" + fileName + ".wfdb").exists();
  }

  Future<void> writeFileContent(
      String fileName, String content, String password) async {
    print(password + "\n" + content);
    await File((await _getDirectoryPath())! + "/$fileName" + ".wfdb")
        .writeAsString(password + "\n" + content, mode: FileMode.writeOnly);
  }
}
