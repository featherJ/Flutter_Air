import 'package:flutter_air/flash/display/graphics_path_command.dart';
import 'package:flutter_air/flash/display/graphics_path_winding.dart';
import 'package:flutter_air/flash/display/i_graphics_data.dart';
import 'package:flutter_air/flash/display/i_graphics_path.dart';

/// 此接口用于定义可用作 flash.display.Graphics 方法中的参数的对象，包括填充、笔触和路径。使用此接口的实现器类来创建和管理绘制属性数据，并将相同的数据重新用于不同的实例。然后，使用 Graphics 类的方法来呈现绘制对象。
class GraphicsPath extends Object implements IGraphicsPath, IGraphicsData {
  ///由绘图命令构成的矢量，其中的整数表示路径。
  List<int> commands;

  ///由数字构成的矢量，其中包含与绘图命令一起使用的参数。
  List<double> data;

  ///使用 GraphicsPathWinding 类中定义的值指定缠绕规则。
  String winding;

  GraphicsPath(
      [this.commands = const [],
      this.data = const [],
      this.winding = GraphicsPathWinding.EVEN_ODD]);

  ///将新的“cubicCurveTo”命令添加到 commands 矢量，并将新坐标添加到 data 矢量。
  void cubicCurveTo(double controlX1, double controlY1, double controlX2,
      double controlY2, double anchorX, double anchorY) {
    commands.add(GraphicsPathCommand.CUBIC_CURVE_TO);
    data.add(controlX1);
    data.add(controlY1);
    data.add(controlX2);
    data.add(controlY2);
    data.add(anchorX);
    data.add(anchorY);
  }

  ///将新的“curveTo”命令添加到 commands 矢量，并将新坐标添加到 data 矢量。
  void curveTo(
      double controlX, double controlY, double anchorX, double anchorY) {
    commands.add(GraphicsPathCommand.CURVE_TO);
    data.add(controlX);
    data.add(controlY);
    data.add(anchorX);
    data.add(anchorY);
  }

  ///将新的“lineTo”命令添加到 commands 矢量，并将新坐标添加到 data 矢量。
  void lineTo(double x, double y) {
    commands.add(GraphicsPathCommand.LINE_TO);
    data.add(x);
    data.add(y);
  }

  ///将新的“moveTo”命令添加到 commands 矢量，并将新坐标添加到 data 矢量。
  void moveTo(double x, double y) {
    commands.add(GraphicsPathCommand.MOVE_TO);
    data.add(x);
    data.add(y);
  }

  ///将新的“wideLineTo”命令添加到 commands 矢量，并将新坐标添加到 data 矢量。
  void wideLineTo(double x, double y) {
    commands.add(GraphicsPathCommand.WIDE_LINE_TO);
    data.add(0);
    data.add(0);
    data.add(x);
    data.add(y);
  }

  ///将新的“wideMoveTo”命令添加到 commands 矢量，并将新坐标添加到 data 矢量。
  void wideMoveTo(double x, double y) {
    commands.add(GraphicsPathCommand.WIDE_MOVE_TO);
    data.add(0);
    data.add(0);
    data.add(x);
    data.add(y);
  }
}
