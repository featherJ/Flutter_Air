import 'package:flutter/painting.dart';
import 'package:flutter_air/flash/display/bitmap_data.dart';
import 'package:flutter_air/flash/display/caps_style.dart';
import 'package:flutter_air/flash/display/graphics_core.dart';
import 'package:flutter_air/flash/display/graphics_data.dart';
import 'package:flutter_air/flash/display/joint_style.dart';
import 'package:flutter_air/flash/display/line_scale_mode.dart';
import 'package:flutter_air/flash/display/shader.dart';
import 'package:flutter_air/flash/geom/matrix.dart';
import 'package:flutter_air/flutter_air.dart';

/// Graphics 类包含一组可
/// 用来创建矢量形状的方法。支持绘制的显示对象包括 Sprite 和 Shape 对象。这些类中的每一个类都包括 graphics 属性，该属性是一个 Graphics 对象。以下是为便于使用而提供的一些辅助函数：drawRect()、drawRoundRect()、drawCircle() 和 drawEllipse()。
///
/// 无法通过 ActionScript 代码直接创建 Graphics 对象。如果调用 new Graphics()，则会引发异常。
///
/// Graphics 类是最终类；无法从其派生子类。
class Graphics extends Object {
  final List<$GraphicPathData> $drawingQueue = [];
  bool _begining = false;
  DisplayObject? _target;

  Graphics(DisplayObject target) {
    _target = target;
  }

  void $requiresFrame() {
    _target!.$requiresFrame();
  }

  $GraphicPathData get _currentGraphicData {
    $GraphicPathData? cur;
    if (!_begining) {
      _begining = true;
      cur = $GraphicPathData();
      $drawingQueue.add(cur);
    } else {
      cur = $drawingQueue.last;
    }
    return cur;
  }

  void _endRecording() {
    _begining = false;
  }

  /// 用位图图像填充绘图区。
  void beginBitmapFill(BitmapData bitmap,
      [Matrix? matrix, bool repeat = true, bool smooth = false]) {
    //TODO
  }

  /// 指定一种简单的单一颜色填充，在绘制时该填充将在随后对其他 [Graphics] 方法（如 [lineTo] 或 [drawCircle]）的调用中使用。
  void beginFill(int color, [double alpha = 1]) {
    Color curColor = Color(color);
    curColor = curColor.withOpacity(alpha);
    _currentGraphicData.fill ??= Paint();
    Paint paint = _currentGraphicData.fill!;
    paint.color = curColor;
    paint.style = PaintingStyle.fill;
  }

  /// 指定一种渐变填充，用于随后调用对象的其他 [Graphics] 方法（如 [lineTo] 或 [drawCircle]）。
  void beginGradientFill(
      String type, List<int> colors, List<double> alphas, List<double> ratios,
      [Matrix? matrix,
      String spreadMethod = "pad",
      String interpolationMethod = "rgb",
      double focalPointRatio = 0]) {
    //TODO
  }

  /// 为对象指定着色器填充，供随后调用其他 [Graphics] 方法（如 [lineTo] 或 [drawCircle]）时使用。
  void beginShaderFill(Shader shader, [Matrix? matrix]) {
    //TODO
  }

  /// 清除绘制到此 [Graphics] 对象的图形，并重置填充和线条样式设置。
  void clear() {
    $drawingQueue.clear();
    _endRecording();
    $requiresFrame();
  }

  /// 将源 [Graphics] 对象中的所有绘图命令复制到执行调用的 [Graphics] 对象中。
  void copyFrom(Graphics sourceGraphics) {
    $drawingQueue.clear();
    int sourceLen = sourceGraphics.$drawingQueue.length;
    for (int i = 0; i < sourceLen; i++) {
      $drawingQueue.add(sourceGraphics.$drawingQueue[i]);
    }
    _endRecording();
    $requiresFrame();
  }

  /// 从当前绘图位置到指定的锚点绘制一条三次贝塞尔曲线。
  void cubicCurveTo(double controlX1, double controlY1, double controlX2,
      double controlY2, double anchorX, double anchorY) {
    _currentGraphicData.path
        .cubicTo(controlX1, controlY1, controlX2, controlY2, anchorX, anchorY);
    $requiresFrame();
  }

  /// 使用当前线条样式和由 ([controlX], [controlY]) 指定的控制点绘制一条从当前绘图位置开始到 ([anchorX], [anchorY]) 结束的二次贝塞尔曲线。
  void curveTo(
      double controlX, double controlY, double anchorX, double anchorY) {
    _currentGraphicData.path
        .quadraticBezierTo(controlX, controlY, anchorX, anchorY);
    $requiresFrame();
  }

  /// 绘制一个圆。
  void drawCircle(double x, double y, double radius) {
    final pos = Offset(x, y);
    final c = Rect.fromCircle(center: pos, radius: radius);
    _currentGraphicData.path.addOval(c);
  }

  /// 绘制一个椭圆。
  void drawEllipse(double x, double y, double width, double height) {
    //TODO 需要测试这个圆的绘制位置和air是否一致
    final pos = Offset(x + width / 2, y + height / 2);
    _currentGraphicData.path.addOval(
      Rect.fromCenter(
        center: pos,
        width: width,
        height: height,
      ),
    );
  }

  /// 提交一系列 [IGraphicsData] 实例来进行绘图。
  void drawGraphicsData(List<IGraphicsData> graphicsData) {
    //TODO
  }

  /// 提交一系列绘制命令。
  void drawPath(List<int> commands, List<double> data,
      [String winding = "evenOdd"]) {
    //TODO
  }

  /// 绘制一个矩形。
  void drawRect(double x, double y, double width, double height) {
    final r = Rect.fromLTWH(x, y, width, height);
    _currentGraphicData.path.addRect(r);
    $requiresFrame();
  }

  /// 绘制一个圆角矩形。
  void drawRoundRect(
      double x, double y, double width, double height, double ellipseWidth,
      [double? ellipseHeight]) {
    final r = RRect.fromLTRBXY(
      x,
      y,
      x + width,
      y + height,
      ellipseWidth,
      ellipseHeight ?? ellipseWidth,
    );
    _currentGraphicData.path.addRRect(r);
    $requiresFrame();
  }

  /// 呈现一组三角形（通常用于扭曲位图），并为其指定三维外观。
  void drawTriangles(List<double> vertices,
      [List<int>? indices, List<int>? uvtData, String culling = "none"]) {
    //TODO
  }

  /// 对从上一次调用 beginFill()、beginGradientFill() 或 beginBitmapFill() 方法之后添加的直线和曲线应用填充。
  void endFill() {
    _endRecording();
  }

  /// 指定一个位图，用于绘制线条时的线条笔触。
  void lineBitmapStyle(BitmapData bitmap,
      [Matrix? matrix, bool repeat = true, bool smooth = false]) {
    //TODO
  }

  /// 指定一种渐变，用于绘制线条时的笔触。
  void lineGradientStyle(
      String type, List<int> colors, List<double> alphas, List<double> ratios,
      [Matrix? matrix,
      String spreadMethod = "pad",
      String interpolationMethod = "rgb",
      double focalPointRatio = 0]) {
    //TODO
  }

  /// 指定一个着色器以用于绘制线条时的线条笔触。
  void lineShaderStyle(Shader shader, [Matrix? matrix]) {
    //TODO
  }

  /// 指定一种线条样式以用于随后对 lineTo() 或 drawCircle() 等 Graphics 方法的调用。
  void lineStyle(
      [double thickness = 0.0,
      int color = 0,
      double alpha = 1.0,
      bool pixelHinting = false,
      String scaleMode = LineScaleMode.NORMAL,
      String? caps,
      String? joints,
      double miterLimit = 3]) {
    //TODO scalemodel 需要实现
    //TODO pixelHinting 的一致性判断
    Color curColor = Color(color);
    curColor = curColor.withOpacity(alpha);
    _currentGraphicData.stroke ??= Paint();
    Paint paint = _currentGraphicData.stroke!;
    paint.style = PaintingStyle.stroke;
    paint.color = curColor;
    paint.strokeWidth = thickness;
    paint.isAntiAlias = !pixelHinting;
    if (caps == CapsStyle.ROUND) {
      paint.strokeCap = StrokeCap.round;
    } else if (caps == CapsStyle.SQUARE) {
      paint.strokeCap = StrokeCap.square;
    } else if (caps == CapsStyle.NONE) {
      paint.strokeCap = StrokeCap.butt;
    } else {
      paint.strokeCap = StrokeCap.round;
    }
    if (joints == JointStyle.BEVEL) {
      paint.strokeJoin = StrokeJoin.bevel;
    } else if (joints == JointStyle.MITER) {
      paint.strokeJoin = StrokeJoin.miter;
    } else if (joints == JointStyle.ROUND) {
      paint.strokeJoin = StrokeJoin.round;
    } else {
      paint.strokeJoin = StrokeJoin.round;
    }
    //TODO 这里应该加判断 是否使用了Skia
    // if (SystemUtils.usingSkia) {
    paint.strokeMiterLimit = miterLimit;
    // }
  }

  /// 将当前绘图位置移动到 ([x], [y])。
  void moveTo(double x, double y) {
    _currentGraphicData.path.moveTo(x, y);
    $requiresFrame();
  }

  /// 使用当前线条样式绘制一条从当前绘图位置开始到 ([x], [y]) 结束的直线；当前绘图位置随后会设置为 ([x], [y])。
  void lineTo(double x, double y) {
    _currentGraphicData.path.lineTo(x, y);
    $requiresFrame();
  }

  /// 查询 [Sprite] 或 [Shape] 对象（也可以是其子对象）的矢量图形内容。
  List<IGraphicsData> readGraphicsData([bool recurse = true]) {
    return [];
  }

  void $paint(Canvas canvas, List<$MaskPathsData>? masks) {
    //处理遮罩数据
    if (masks != null) {
      for (var mask in masks) {
        if (mask.path != null) {
          var matrix = mask.matrix;
          matrix ??= Matrix();
          canvas.clipPath(mask.path!.transform(matrix.$storage));
        }
      }
    }

    canvas.save();
    for (var graphicData in $drawingQueue) {
      if (graphicData.fill != null) {
        canvas.drawPath(graphicData.path, graphicData.fill!);
      }
      if (graphicData.stroke != null) {
        canvas.drawPath(graphicData.path, graphicData.stroke!);
      }
    }
    canvas.restore();
  }
}
