import 'package:flutter_air/flash/display/gradient_type.dart';
import 'package:flutter_air/flash/display/i_graphics_data.dart';
import 'package:flutter_air/flash/display/i_graphics_fill.dart';
import 'package:flutter_air/flash/display/interpolation_method.dart';
import 'package:flutter_air/flash/display/spread_method.dart';
import 'package:flutter_air/flash/geom/matrix.dart';

/// 定义渐变填充。
/// 将 GraphicsGradientFill 对象与 Graphics.drawGraphicsData() 方法一起使用。绘制 GraphicsGradientFill 对象与调用 Graphics.beginGradientFill() 方法是等效的。
class GraphicsGradientFill extends Object
    implements IGraphicsFill, IGraphicsData {
  ///GradientType 类中用于指定要使用的渐变类型的值。
  String type;

  ///渐变中使用的 RGB 十六进制颜色值数组。
  List<int>? colors;

  ///colors 数组中的对应颜色的 Alpha 值的数组。
  List<double>? alphas;

  ///颜色分布比例的数组。
  List<int>? ratios;

  ///一个由 Matrix 类定义的转换矩阵。
  Matrix? matrix;

  ///SpreadMethod 类中用于指定要使用的扩展方法的值。
  String spreadMethod;

  ///InterpolationMethod 类中用于指定要使用的值的值。
  String interpolationMethod;

  ///一个控制渐变的焦点位置的数字。
  double focalPointRatio;

  ///放射填充的中心比例
  double focalRadiusRatio;

  ///扫描田中的角度比例
  double sweepRatio;

  GraphicsGradientFill(
      [this.type = GradientType.LINEAR,
      this.colors,
      this.alphas,
      this.ratios,
      this.matrix,
      this.spreadMethod = SpreadMethod.PAD,
      this.interpolationMethod = InterpolationMethod.RGB,
      this.focalPointRatio = 0,
      this.focalRadiusRatio = 0,
      this.sweepRatio = 1]);
}
