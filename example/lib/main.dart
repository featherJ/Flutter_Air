import 'dart:math' as math;
import 'package:example/test/graphics_test.dart';
import 'package:flutter_air/flash/display/gradient_type.dart';
import 'package:flutter_air/flash/display/interpolation_method.dart';
import 'package:flutter_air/flash/display/spread_method.dart';
import 'package:flutter_air/flash/geom/matrix.dart';
import 'package:flutter_air/flutter_air.dart';

void main() {
  MyApp();
}

class MyApp extends Stage {
  MyApp() {
    addChild(GraphicsTest());
  }
}
