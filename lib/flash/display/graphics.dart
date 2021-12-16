import 'package:flutter/painting.dart';
import 'package:flutter_air/flash/display/bitmap_data.dart';
import 'package:flutter_air/flash/display/graphics_data.dart';
import 'package:flutter_air/flash/display/shader.dart';
import 'package:flutter_air/flash/geom/matrix.dart';

class _GraphicData {
  Path path = Path();
  Paint paint = Paint();
}

/// Graphics 类包含一组可用来创建矢量形状的方法。支持绘制的显示对象包括 Sprite 和 Shape 对象。这些类中的每一个类都包括 graphics 属性，该属性是一个 Graphics 对象。以下是为便于使用而提供的一些辅助函数：drawRect()、drawRoundRect()、drawCircle() 和 drawEllipse()。
///
/// 无法通过 ActionScript 代码直接创建 Graphics 对象。如果调用 new Graphics()，则会引发异常。
///
/// Graphics 类是最终类；无法从其派生子类。
class Graphics extends Object {
  final List<_GraphicData> _drawingQueue = [];
  bool _begining = false;

  _GraphicData get _currentGraphicData {
    _GraphicData? cur;
    if (!_begining) {
      _begining = true;
      cur = _GraphicData();
      _drawingQueue.add(cur);
    } else {
      cur = _drawingQueue.last;
    }
    return cur;
  }

  void _endRecording() {
    _begining = false;
  }

  /// 用位图图像填充绘图区。
  void beginBitmapFill(BitmapData bitmap,
      {Matrix? matrix, bool repeat = true, bool smooth = false}) {}

  /// 指定一种简单的单一颜色填充，在绘制时该填充将在随后对其他 [Graphics] 方法（如 [lineTo] 或 [drawCircle]）的调用中使用。
  void beginFill(int color, {double alpha = 1}) {
    //TODO 框架测试代码
    Paint paint = _currentGraphicData.paint
      ..color = Color(color)
      ..style = PaintingStyle.fill;
  }

  /// 指定一种渐变填充，用于随后调用对象的其他 [Graphics] 方法（如 [lineTo] 或 [drawCircle]）。
  void beginGradientFill(
      String type, List<int> colors, List<double> alphas, List<double> ratios,
      {Matrix? matrix,
      String spreadMethod = "pad",
      String interpolationMethod = "rgb",
      double focalPointRatio = 0}) {}

  /// 为对象指定着色器填充，供随后调用其他 [Graphics] 方法（如 [lineTo] 或 [drawCircle]）时使用。
  void beginShaderFill(Shader shader, {Matrix? matrix}) {}

  /// 清除绘制到此 [Graphics] 对象的图形，并重置填充和线条样式设置。
  void clear() {}

  /// 将源 [Graphics] 对象中的所有绘图命令复制到执行调用的 [Graphics] 对象中。
  void copyFrom(Graphics sourceGraphics) {}

  /// 从当前绘图位置到指定的锚点绘制一条三次贝塞尔曲线。
  void cubicCurveTo(double controlX1, double controlY1, double controlX2,
      double controlY2, double anchorX, double anchorY) {}

  /// 使用当前线条样式和由 ([controlX], [controlY]) 指定的控制点绘制一条从当前绘图位置开始到 ([anchorX], [anchorY]) 结束的二次贝塞尔曲线。
  void curveTo(
      double controlX, double controlY, double anchorX, double anchorY) {}

  /// 绘制一个圆。
  void drawCircle(double x, double y, double radius) {}

  /// 绘制一个椭圆。
  void drawEllipse(double x, double y, double width, double height) {}

  /// 提交一系列 [IGraphicsData] 实例来进行绘图。
  void drawGraphicsData(List<IGraphicsData> graphicsData) {}

  /// 提交一系列绘制命令。
  void drawPath(List<int> commands, List<double> data,
      {String winding = "evenOdd"}) {}

  /// 绘制一个矩形。
  void drawRect(double x, double y, double width, double height) {
    final r = Rect.fromLTWH(x, y, width, height);
    _currentGraphicData.path.addRect(r);
  }

  /// 绘制一个圆角矩形。
  void drawRoundRect(
      double x, double y, double width, double height, double ellipseWidth,
      {double? ellipseHeight}) {}

  /// 呈现一组三角形（通常用于扭曲位图），并为其指定三维外观。
  void drawTriangles(List<double> vertices,
      {List<int>? indices, List<int>? uvtData, String culling = "none"}) {}

  /// 对从上一次调用 beginFill()、beginGradientFill() 或 beginBitmapFill() 方法之后添加的直线和曲线应用填充。
  void endFill() {
    _endRecording();
  }

  /// 指定一个位图，用于绘制线条时的线条笔触。
  void lineBitmapStyle(BitmapData bitmap,
      {Matrix? matrix, bool repeat = true, bool smooth = false}) {}

  /// 指定一种渐变，用于绘制线条时的笔触。
  void lineGradientStyle(
      String type, List<int> colors, List<double> alphas, List<double> ratios,
      {Matrix? matrix,
      String spreadMethod = "pad",
      String interpolationMethod = "rgb",
      double focalPointRatio = 0}) {}

  /// 指定一个着色器以用于绘制线条时的线条笔触。
  void lineShaderStyle(Shader shader, {Matrix? matrix}) {}

  /// 指定一种线条样式以用于随后对 lineTo() 或 drawCircle() 等 Graphics 方法的调用。
  void lineStyle(
      {double? thickness,
      int color = 0,
      double alpha = 1.0,
      bool pixelHinting = false,
      String scaleMode = "normal",
      String? caps,
      String? joints,
      double miterLimit = 3}) {}

  /// 使用当前线条样式绘制一条从当前绘图位置开始到 ([x], [y]) 结束的直线；当前绘图位置随后会设置为 ([x], [y])。
  void lineTo(double x, double y) {}

  /// 将当前绘图位置移动到 ([x], [y])。
  void moveTo(double x, double y) {}

  /// 查询 [Sprite] 或 [Shape] 对象（也可以是其子对象）的矢量图形内容。
  List<IGraphicsData> readGraphicsData({bool recurse = true}) {
    return [];
  }

  void $paint(Canvas canvas) {
    for (var graphicData in _drawingQueue) {
      canvas.drawPath(graphicData.path, graphicData.paint);
    }
  }
}
