import 'package:walf/src/models/base/walf_model.dart';

class WalfInt extends WalfModel {
  /// [WalfInt] based WalfModel class.
  ///
  final String key;
  final int value;
  WalfInt(this.key, this.value)
      : super(key: key, type: "Walf Integer", value: value);

  @override
  String toString() {
    return value.toString();
  }
}
