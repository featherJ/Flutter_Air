import 'package:flutter_air/flutter_air.dart';

void main() => MyApp();

class MyApp extends Stage {
  MyApp() {
    Shape shape1 = Shape();
    shape1.graphics.beginFill(0xffff0000);
    shape1.graphics.drawRect(0, 0, 200, 200);
    shape1.graphics.endFill();
    addChild(shape1);

    Shape shape2 = Shape();
    shape2.graphics.beginFill(0xff00ff00);
    shape2.graphics.drawRect(100, 100, 150, 150);
    shape2.graphics.endFill();
    addChild(shape2);

    Shape shape3 = Shape();
    shape3.graphics.beginFill(0xff00cccc);
    shape3.graphics.drawRect(150, 300, 200, 200);
    shape3.graphics.endFill();
    shape3.graphics.beginFill(0xffff33ff);
    shape3.graphics.drawRect(250, 400, 150, 150);
    shape3.graphics.endFill();
    addChild(shape3);
  }
}
