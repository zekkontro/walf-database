import 'package:walf/src/models/base/walf_model.dart';

class WalfBool extends WalfModel {
  final String key;
  final bool value;
  WalfBool(this.key, this.value)
      : super(key: key, type: "Walf Bool", value: value);

  @override
  String toString() {
    return value.toString();
  }
}
