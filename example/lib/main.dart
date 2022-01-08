import 'package:example/test/graphics_test.dart';
import 'package:flutter_air/flutter_air.dart';

void main() {
  MyApp();
}

class MyApp extends Stage {
  MyApp() {
    addChild(GraphicsTest());
  }
}
