import 'package:flutter_air/flash/display/graphics_path_command.dart';
import 'package:flutter_air/flash/display/graphics_path_winding.dart';
import 'package:flutter_air/flash/display/shape.dart';
import 'package:flutter_air/flash/display/sprite.dart';

class DrawPathTest extends Sprite {
  DrawPathTest() {
    testLine();
    testCurve();
  }

  void testLine() {
    var shape = Shape();
    shape.graphics.beginFill(0xcccccc);
    shape.graphics.lineStyle(1, 0);
    List<int> commands = [];
    List<double> data = [];
    commands.add(GraphicsPathCommand.MOVE_TO);
    data.add(66);
    data.add(10);
    commands.add(GraphicsPathCommand.LINE_TO);
    data.add(23);
    data.add(127);
    commands.add(GraphicsPathCommand.LINE_TO);
    data.add(122);
    data.add(50);
    commands.add(GraphicsPathCommand.LINE_TO);
    data.add(10);
    data.add(49);
    commands.add(GraphicsPathCommand.LINE_TO);
    data.add(109);
    data.add(127);
    commands.add(GraphicsPathCommand.LINE_TO);
    data.add(66);
    data.add(10);
    shape.graphics.drawPath(commands, data, GraphicsPathWinding.EVEN_ODD);
    shape.graphics.endFill();
    addChild(shape);
  }

  void testCurve() {
    var shape = Shape();
    shape.graphics.beginFill(0xcccccc);
    shape.graphics.lineStyle(1, 0);
    List<int> commands = [];
    List<double> data = [];
    commands.add(GraphicsPathCommand.MOVE_TO);
    data.add(200);
    data.add(200);
    commands.add(GraphicsPathCommand.CURVE_TO);
    data.add(250);
    data.add(100);
    data.add(300);
    data.add(200);
    commands.add(GraphicsPathCommand.CURVE_TO);
    data.add(400);
    data.add(250);
    data.add(300);
    data.add(300);
    commands.add(GraphicsPathCommand.CURVE_TO);
    data.add(250);
    data.add(400);
    data.add(200);
    data.add(300);
    commands.add(GraphicsPathCommand.CURVE_TO);
    data.add(100);
    data.add(250);
    data.add(200);
    data.add(200);

    shape.graphics.drawPath(commands, data);
    shape.graphics.endFill();
    addChild(shape);
  }
}
