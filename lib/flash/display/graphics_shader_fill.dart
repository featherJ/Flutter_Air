import 'package:flutter_air/flash/display/i_graphics_data.dart';
import 'package:flutter_air/flash/display/i_graphics_fill.dart';
import 'package:flutter_air/flash/display/shader.dart';
import 'package:flutter_air/flash/geom/matrix.dart';

/// 定义着色器填充。
/// 将 GraphicsShaderFill 对象与 Graphics.drawGraphicsData() 方法一起使用。绘制 GraphicsShaderFill 对象与调用 Graphics.beginShaderFill() 方法是等效的。
class GraphicsShaderFill extends Object
    implements IGraphicsFill, IGraphicsData {
  Matrix? matrix;
  Shader? shader;
  GraphicsShaderFill([this.shader, this.matrix]);
}
