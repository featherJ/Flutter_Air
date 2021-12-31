import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_air/flash/display/sprite.dart';
import 'package:flutter_air/flutter_air.dart';

void main() => MyApp();

class MyApp extends Stage {
  MyApp() {
    // Shape shape1 = Shape();
    // shape1.graphics.beginFill(0xff0000, 0.7);
    // shape1.graphics.lineStyle(10.0, 0, 0.5);
    // shape1.graphics.drawRect(20, 20, 200, 200);
    // shape1.graphics.endFill();
    // addChild(shape1);

    // Shape shape2 = Shape();
    // shape2.graphics.lineStyle(10.0, 0);
    // shape2.graphics.beginFill(0x00ff00, 0.5);
    // shape2.graphics.drawCircle(400, 400, 300);
    // shape2.graphics.endFill();
    // addChild(shape2);

    // Shape shape4 = Shape();
    // shape4.graphics.beginFill(0x00cccc);
    // shape4.graphics.drawRect(150, 300, 200, 200);
    // shape4.graphics.endFill();
    // shape4.graphics.beginFill(0xff33ff, 0.8);
    // shape4.graphics.drawEllipse(250, 400, 300, 150);
    // shape4.graphics.endFill();
    // addChild(shape4);

    Sprite sprite = Sprite();
    // sprite.alpha = 0.5;
    sprite.x = 0;
    sprite.y = 0;
    addChild(sprite);

    Shape shape5 = Shape();
    shape5.graphics.beginFill(0xFF0000, 1.0);
    shape5.graphics.drawRect(0, 0, 200, 200);
    shape5.graphics.drawRect(40, 40, 200, 200);
    shape5.graphics.drawRect(80, 80, 200, 200);
    shape5.graphics.endFill();
    shape5.x = 100;
    shape5.y = 100;
    shape5.alpha = 0.5;
    sprite.addChild(shape5);

    // Shape shape6 = Shape();
    // shape6.graphics.beginFill(0xFF0000, 1.0);
    // shape6.graphics.moveTo(500, 500);
    // shape6.graphics.lineTo(500, 400);
    // shape6.graphics.lineTo(300, 400);
    // shape6.graphics.lineTo(300, 600);
    // shape6.graphics.lineTo(500, 600);
    // shape6.graphics.lineTo(500, 500);
    // shape6.graphics.lineTo(400, 500);
    // shape6.graphics.lineTo(400, 700);
    // shape6.graphics.lineTo(600, 700);
    // shape6.graphics.lineTo(600, 500);
    // shape6.graphics.lineTo(500, 500);
    // shape6.graphics.endFill();
    // // shape6.x = -100;
    // // shape6.y = -200;
    // sprite.addChild(shape6);

    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   shape4.graphics.clear();
    // });

    // Future.delayed(const Duration(milliseconds: 3000), () {
    //   shape4.graphics.beginFill(0x00cccc);
    //   shape4.graphics.drawRect(150, 300, 200, 200);
    //   shape4.graphics.endFill();
    // });

    // Future.delayed(const Duration(milliseconds: 5000), () {
    //   removeChild(shape4);
    // });
  }
}
