import 'dart:math' as math;
import 'package:flutter_air/flash/display/gradient_type.dart';
import 'package:flutter_air/flash/display/interpolation_method.dart';
import 'package:flutter_air/flash/display/shape.dart';
import 'package:flutter_air/flash/display/spread_method.dart';
import 'package:flutter_air/flash/display/sprite.dart';
import 'package:flutter_air/flash/geom/matrix.dart';

class GraphicsTest extends Sprite {
  GraphicsTest() {
    scaleX = 2;
    scaleY = 2;
    testLinear();
    testRadial();
    testSweep();
    testStrokeLinear();
  }

  void testLinear() {
    var shape = Shape();
    var color = [0xff0000, 0x00ff00, 0x0000ff]; //设置颜色数组
    var alphaAr = [1.0, 1.0, 1.0]; //透明度数组
    var rotios = [0, 127, 255]; //偏移量，数组
    var matrix = Matrix(); //矩阵
    matrix.createGradientBox(200, 100, 45 / 180 * math.pi, 0, 0);
    var matrix2 = Matrix();
    matrix2.rotate(45 / 180 * math.pi);
    matrix.concat(matrix2);

    shape.graphics.beginGradientFill(GradientType.LINEAR, color, alphaAr,
        rotios, matrix, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, 1, 0);
    shape.graphics.drawRect(0, 0, 200, 200);
    shape.graphics.endFill();
    addChild(shape);
  }

  void testRadial() {
    var shape = Shape();
    var color = [0xff0000, 0x00ff00, 0x0000ff]; //设置颜色数组
    var alphaAr = [1.0, 1.0, 1.0]; //透明度数组
    var rotios = [0, 127, 255]; //偏移量，数组
    var matrix = Matrix(); //矩阵
    matrix.createGradientBox(200, 100, 45 / 180 * math.pi, 0, 0);
    var matrix2 = Matrix();
    matrix2.rotate(45 / 180 * math.pi);
    matrix.concat(matrix2);

    shape.graphics.beginGradientFill(GradientType.RADIAL, color, alphaAr,
        rotios, matrix, SpreadMethod.REPEAT, InterpolationMethod.RGB, 0.5, 0.5);
    shape.graphics.drawRect(0, 0, 200, 200);
    shape.graphics.endFill();
    shape.x = 200;
    addChild(shape);
  }

  void testSweep() {
    var shape = Shape();
    var color = [0xff0000, 0x00ff00, 0x0000ff]; //设置颜色数组
    var alphaAr = [1.0, 1.0, 1.0]; //透明度数组
    var rotios = [0, 127, 255]; //偏移量，数组
    var matrix = Matrix(); //矩阵
    matrix.createGradientBox(200, 100, 45 / 180 * math.pi, 0, 0);
    var matrix2 = Matrix();
    matrix2.rotate(45 / 180 * math.pi);
    matrix.concat(matrix2);

    shape.graphics.beginGradientFill(GradientType.SWEEP, color, alphaAr, rotios,
        matrix, SpreadMethod.REFLECT, InterpolationMethod.RGB, 1, 0, 0.8);
    shape.graphics.drawRect(0, 0, 200, 200);
    shape.graphics.endFill();
    shape.x = 400;
    addChild(shape);
  }

  void testStrokeLinear() {
    var shape = Shape();
    var color = [0xff0000, 0x00ff00, 0x0000ff]; //设置颜色数组
    var alphaAr = [1.0, 1.0, 1.0]; //透明度数组
    var ratios = [0, 127, 255]; //偏移量，数组
    var matrix = Matrix(); //矩阵
    matrix.createGradientBox(200, 100, 45 / 180 * math.pi, 0, 0);
    var matrix2 = Matrix();
    matrix2.rotate(45 / 180 * math.pi);
    matrix.concat(matrix2);
    print(matrix);

    shape.graphics.lineStyle(20, 0xff0000, 0.5);
    shape.graphics.lineGradientStyle(GradientType.LINEAR, color, alphaAr,
        ratios, matrix, SpreadMethod.PAD, InterpolationMethod.RGB, 2);
    shape.graphics.beginFill(0x00ff00);
    shape.graphics.drawRect(0, 0, 200, 200);
    shape.graphics.endFill();
    shape.x = 10;
    shape.y = 210;
    addChild(shape);
  }
}
