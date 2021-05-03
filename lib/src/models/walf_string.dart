import 'package:walf/src/models/base/walf_model.dart';

class WalfString extends WalfModel {
  final String key;
  final String value;
  WalfString(this.key, this.value)
      : super(key: key, type: "Walf String", value: value);

  @override
  String toString() {
    return value.toString();
  }
}
