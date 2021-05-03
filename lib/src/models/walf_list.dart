import 'package:walf/src/models/base/walf_model.dart';

class WalfList extends WalfModel {
  final String key;
  final List value;
  WalfList(this.key, this.value)
      : super(key: key, type: "Walf Integer", value: value);

  @override
  String toString() {
    return value.toString();
  }
}
