import 'package:flutter_air/flash/display/i_graphics_data.dart';
import 'package:flutter_air/flash/display/i_graphics_fill.dart';

/// 表示图形填充的结束。将 GraphicsEndFill 对象与 Graphics.drawGraphicsData() 方法一起使用。
/// 绘制 GraphicsEndFill 对象与调用 Graphics.endFill() 方法是等效的。
class GraphicsEndFill extends Object implements IGraphicsFill, IGraphicsData {
  GraphicsEndFill();
}
