import 'package:flutter_air/flash/display/shape.dart';
import 'package:flutter_air/flash/display/sprite.dart';

class MaskTest extends Sprite {
  MaskTest() {
    Shape shape = Shape();
    shape.graphics.beginFill(0xFFFF00, 1.0);
    shape.graphics.drawRect(0, 0, 500, 500);
    shape.graphics.endFill();
    shape.x = 100;
    shape.y = 100;
    addChild(shape);

    var shapeContainer = Sprite();
    shapeContainer.x = 60;
    shapeContainer.y = -50;
    addChild(shapeContainer);
    shapeContainer.addChild(shape);

    Shape mask1 = Shape();
    mask1.graphics.beginFill(0xFF0000, 1.0);
    mask1.graphics.drawRect(0, 0, 200, 200);
    mask1.graphics.drawRect(40, 40, 200, 200);
    mask1.graphics.drawRect(80, 80, 200, 200);
    mask1.graphics.endFill();
    mask1.x = 100;
    mask1.y = 100;
    mask1.scaleX = 2;
    mask1.scaleY = 0.8;

    var maskContainer = Sprite();
    maskContainer.addChild(mask1);
    maskContainer.x = 70;
    maskContainer.y = 70;
    maskContainer.scaleX = 0.9;
    maskContainer.scaleY = 1.2;

    var maskContainer2 = Sprite();
    addChild(maskContainer2);
    maskContainer2.addChild(maskContainer);

    var mask2 = Shape();
    mask2.graphics.beginFill(0x00ff00);
    mask2.graphics.drawCircle(100, 100, 100);
    mask2.graphics.endFill();
    mask2.x = 100;
    mask2.y = 100;
    mask2.scaleX = 2;
    maskContainer2.addChild(mask2);
    maskContainer2.x = 50;
    maskContainer2.y = 50;

    shape.mask = maskContainer2;
  }
}
