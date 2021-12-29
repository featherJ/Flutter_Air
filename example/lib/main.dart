import 'dart:ui';

import 'package:flutter_air/flutter_air.dart';

void main() => MyApp();

class MyApp extends Stage {
  MyApp() {
    Shape shape1 = Shape();
    shape1.graphics.beginFill(0xff0000, 0.7);
    shape1.graphics.lineStyle(10.0, 0, 0.5);
    shape1.graphics.drawRect(20, 20, 200, 200);
    shape1.graphics.endFill();
    addChild(shape1);

    Shape shape2 = Shape();
    shape2.graphics.lineStyle(10.0, 0, 0.5);
    shape2.graphics.beginFill(0x00ff00, 0.5);
    shape2.graphics.drawCircle(400, 400, 300);
    shape2.graphics.endFill();
    addChild(shape2);

    Shape shape4 = Shape();
    shape4.graphics.beginFill(0x00cccc);
    shape4.graphics.drawRect(150, 300, 200, 200);
    shape4.graphics.endFill();
    shape4.graphics.beginFill(0xff33ff, 0.8);
    shape4.graphics.drawEllipse(250, 400, 300, 150);
    shape4.graphics.endFill();
    addChild(shape4);

    Future.delayed(const Duration(milliseconds: 1000), () {
      shape4.graphics.clear();
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      shape4.graphics.beginFill(0x00cccc);
      shape4.graphics.drawRect(150, 300, 200, 200);
      shape4.graphics.endFill();
    });

    Future.delayed(const Duration(milliseconds: 5000), () {
      removeChild(shape4);
    });
  }
}
