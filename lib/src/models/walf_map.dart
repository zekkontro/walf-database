import 'package:walf/src/models/base/walf_model.dart';

class WalfMap extends WalfModel {
  final String key;
  final Map value;
  WalfMap(this.key, this.value)
      : super(key: key, type: "Walf Map", value: value);
}
