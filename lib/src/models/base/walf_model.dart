import 'package:walf/src/models/walf_string.dart';

abstract class WalfModel {
  late final dynamic value;
  late final String key;
  late final String type;

  WalfModel({required this.value, required this.type, required this.key});
}
