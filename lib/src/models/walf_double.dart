import 'package:walf/src/models/base/walf_model.dart';

class WalfDouble extends WalfModel {
  final String key;
  final double value;
  WalfDouble(this.key, this.value)
      : super(key: key, type: "Walf Double", value: value);
}
