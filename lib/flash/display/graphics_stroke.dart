import 'package:flutter_air/flash/display/caps_style.dart';
import 'package:flutter_air/flash/display/i_graphics_data.dart';
import 'package:flutter_air/flash/display/i_graphics_fill.dart';
import 'package:flutter_air/flash/display/i_graphics_stroke.dart';
import 'package:flutter_air/flash/display/joint_style.dart';
import 'package:flutter_air/flash/display/line_scale_mode.dart';

/// 定义线条样式或笔触。
/// 将 GraphicsStroke 对象与 Graphics.drawGraphicsData() 方法一起使用。绘制 GraphicsStroke 对象与调用设置线条样式的 Graphics 类的方法之一（例如 Graphics.lineStyle() 方法、Graphics.lineBitmapStyle() 方法或 Graphics.lineGradientStyle() 方法）是等效的。
class GraphicsStroke extends Object implements IGraphicsStroke, IGraphicsData {
  /// 指定线条结尾处的端点的类型。
  String caps;

  /// 指定包含用于填充笔触的数据的实例。
  IGraphicsFill? fill;

  /// 指定拐角处使用的连接外观的类型。
  String joints;

  /// 表示将在哪个限制位置切断尖角。
  double miterLimit;

  /// 指定是否提示笔触采用完整像素。
  bool pixelHinting;

  /// 指定笔触粗细缩放。
  String scaleMode;

  /// 表示以点为单位的线条粗细；有效值为 0 到 255。
  double thickness;

  GraphicsStroke(
      [this.thickness = double.nan,
      this.pixelHinting = false,
      this.scaleMode = LineScaleMode.NORMAL,
      this.caps = CapsStyle.NONE,
      this.joints = JointStyle.ROUND,
      this.miterLimit = 3.0,
      this.fill]);
}
