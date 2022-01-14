import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_air/flash/display/bitmap_data.dart';
import 'package:flutter_air/flash/display/caps_style.dart';
import 'package:flutter_air/flash/display/gradient_type.dart';
import 'package:flutter_air/flash/display/graphics_bitmap_fill.dart';
import 'package:flutter_air/flash/display/graphics_core.dart';
import 'package:flutter_air/flash/display/graphics_path.dart';
import 'package:flutter_air/flash/display/graphics_shader_fill.dart';
import 'package:flutter_air/flash/display/graphics_stroke.dart';
import 'package:flutter_air/flash/display/graphics_triangle_path.dart';
import 'package:flutter_air/flash/display/i_graphics_data.dart';
import 'package:flutter_air/flash/display/graphics_end_fill.dart';
import 'package:flutter_air/flash/display/graphics_gradient_fill.dart';
import 'package:flutter_air/flash/display/graphics_path_command.dart';
import 'package:flutter_air/flash/display/graphics_path_winding.dart';
import 'package:flutter_air/flash/display/graphics_solid_fill.dart';
import 'package:flutter_air/flash/display/interpolation_method.dart';
import 'package:flutter_air/flash/display/joint_style.dart';
import 'package:flutter_air/flash/display/line_scale_mode.dart';
import 'package:flutter_air/flash/display/shader.dart';
import 'package:flutter_air/flash/display/spread_method.dart';
import 'package:flutter_air/flash/display/triangle_culling.dart';
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

  $GraphicPathData _getGraphicDataForDrawPath() {
    //之所以这么做，是因为 DrawPath 实际上是使用的一条全新的path来实现的
    var current = _currentGraphicData;
    if (current.$path == null) {
      return current;
    }
    $GraphicPathData cloneData = $GraphicPathData();
    cloneData.fill = current.fill;
    cloneData.stroke = current.stroke;
    $drawingQueue.add(cloneData);
    return cloneData;
  }

  void _endGraphicDataForDrawPath() {
    //之所以这么做，是因为 DrawPath 实际上是使用的一条全新的path来实现的
    var current = _currentGraphicData;
    $GraphicPathData cloneData = $GraphicPathData();
    cloneData.fill = current.fill;
    cloneData.stroke = current.stroke;
    $drawingQueue.add(cloneData);
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
    color = 0xff000000 | color;
    Color curColor = Color(color);
    curColor = curColor.withOpacity(alpha);
    _currentGraphicData.fill ??= Paint();
    Paint paint = _currentGraphicData.fill!;
    paint.color = curColor;
    paint.style = PaintingStyle.fill;
  }

  void _finishGradientPaint(Paint paint, String type, List<int> colors,
      List<double> alphas, List<int> ratios,
      [Matrix? matrix,
      String spreadMethod = SpreadMethod.PAD,
      String interpolationMethod = InterpolationMethod.RGB,
      double focalPointRatio = 0.0,
      double focalRadiusRatio = 0.0, //放射填充的中心比例
      double sweepRatio = 1.0 //扫描田中的角度比例
      ]) {
    //TODO 测试在各参数不全的情况下，是否与flash中效果一致
    if (colors.isEmpty ||
        colors.length != alphas.length ||
        colors.length != ratios.length) {
      //TODO 错误处理，如果这三个数组的长度不相等的时候应该做出相应的异常处理
    }

    List<Color> targetColors = [];
    for (int i = 0; i < colors.length; i++) {
      int curColorValue = colors[i];
      Color curColor = Color(curColorValue);
      curColor = curColor.withOpacity(alphas[i]);
      targetColors.add(curColor);
    }
    List<double> targetRatios = [];
    for (int i = 0; i < ratios.length; i++) {
      targetRatios.add(ratios[i] / 255);
    }

    TileMode tileMode = TileMode.clamp;
    if (spreadMethod == SpreadMethod.PAD) {
      tileMode = TileMode.clamp;
    } else if (spreadMethod == SpreadMethod.REFLECT) {
      tileMode = TileMode.mirror;
    } else if (spreadMethod == SpreadMethod.REPEAT) {
      tileMode = TileMode.repeated;
    } else if (spreadMethod == SpreadMethod.DECAL) {
      tileMode = TileMode.decal;
    }

    if (matrix == null) {
      matrix = Matrix();
      matrix.createGradientBox(200, 200, 0, -100, -100);
    }

    paint.isAntiAlias = true;
    if (interpolationMethod == InterpolationMethod.LINEAR_RGB) {
      paint.colorFilter = const ColorFilter.linearToSrgbGamma();
    } else {
      paint.colorFilter = null;
    }

    if (type == GradientType.LINEAR) {
      paint.shader = ui.Gradient.linear(
          const Offset(-819.2, 0),
          const Offset(819.2, 0),
          targetColors,
          targetRatios,
          tileMode,
          matrix.$storage);
    } else if (type == GradientType.RADIAL) {
      if (focalPointRatio > 1.0) {
        focalPointRatio = 1.0;
      } else if (focalPointRatio < -1.0) {
        focalPointRatio = -1.0;
      }

      if (focalRadiusRatio > 1.0) {
        focalRadiusRatio = 1.0;
      } else if (focalRadiusRatio < 0) {
        focalRadiusRatio = 0;
      }

      var offsetM = Matrix();
      //先移动100，在通过matrix移动回来，否则如果center和focal 均为0点，在skia中会报错
      offsetM.translate(0, -100);
      offsetM.concat(matrix);
      paint.shader = ui.Gradient.radial(
          const Offset(0, 100),
          819.2,
          targetColors,
          targetRatios,
          tileMode,
          offsetM.$storage,
          //原则上下面的这个值应该是819.2，但是会与flash效果不一致，所以设置为了800
          Offset(800 * focalPointRatio, 100),
          819.2 * focalRadiusRatio);
    } else if (type == GradientType.SWEEP) {
      paint.shader = ui.Gradient.sweep(
          const Offset(0, 0),
          targetColors,
          targetRatios,
          tileMode,
          0.0,
          math.pi * 2 * sweepRatio,
          matrix.$storage);
    }
  }

  /// 指定一种渐变填充，用于随后调用对象的其他 [Graphics] 方法（如 [lineTo] 或 [drawCircle]）。
  void beginGradientFill(
      String type, List<int> colors, List<double> alphas, List<int> ratios,
      [Matrix? matrix,
      String spreadMethod = SpreadMethod.PAD,
      String interpolationMethod = InterpolationMethod.RGB,
      double focalPointRatio = 0.0,
      double focalRadiusRatio = 0.0, //放射填充的中心比例
      double sweepRatio = 1.0 //扫描田中的角度比例
      ]) {
    _currentGraphicData.fill ??= Paint();
    Paint paint = _currentGraphicData.fill!;
    paint.style = PaintingStyle.fill;
    _finishGradientPaint(
        paint,
        type,
        colors,
        alphas,
        ratios,
        matrix,
        spreadMethod,
        interpolationMethod,
        focalPointRatio,
        focalRadiusRatio,
        sweepRatio);
  }

  /// 为对象指定着色器填充，供随后调用其他 [Graphics] 方法（如 [lineTo] 或 [drawCircle]）时使用。
  void beginShaderFill(Shader shader, [Matrix? matrix]) {
    //TODO 这个功能恐怕得等到flutter开放自定义Shader功能之后才能完成
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
    for (var element in graphicsData) {
      if (element is GraphicsSolidFill) {
        GraphicsSolidFill solidFill = element;
        beginFill(solidFill.color, solidFill.alpha);
      } else if (element is GraphicsBitmapFill) {
        GraphicsBitmapFill bitmapFill = element;
        //TODO 测试如果bitmapdata为null，和flash中效果是否一致
        beginBitmapFill(bitmapFill.bitmapData!, bitmapFill.matrix,
            bitmapFill.repeat, bitmapFill.smooth);
      } else if (element is GraphicsEndFill) {
        endFill();
      } else if (element is GraphicsGradientFill) {
        GraphicsGradientFill gradientFill = element;
        //TODO 测试如果colors alphas ratios为null，和flash中效果是否一致
        beginGradientFill(
            gradientFill.type,
            gradientFill.colors!,
            gradientFill.alphas!,
            gradientFill.ratios!,
            gradientFill.matrix,
            gradientFill.spreadMethod,
            gradientFill.interpolationMethod,
            gradientFill.focalPointRatio,
            gradientFill.focalRadiusRatio,
            gradientFill.sweepRatio);
      } else if (element is GraphicsPath) {
        GraphicsPath graphicsPath = element;
        drawPath(
            graphicsPath.commands, graphicsPath.data, graphicsPath.winding);
      } else if (element is GraphicsShaderFill) {
        GraphicsShaderFill shaderFill = element;
        //TODO 测试如果 shader 为null，和flash中效果是否一致
        beginShaderFill(shaderFill.shader!, shaderFill.matrix);
      } else if (element is GraphicsStroke) {
        GraphicsStroke stroke = element;
        //TODO
      } else if (element is GraphicsTrianglePath) {
        GraphicsTrianglePath trianglePath = element;
        //TODO
      }
    }
  }

  /// 提交一系列绘制命令。
  void drawPath(List<int> commands, List<double> data,
      [String winding = GraphicsPathWinding.EVEN_ODD]) {
    var path = _getGraphicDataForDrawPath().path;
    if (winding == GraphicsPathWinding.NON_ZERO) {
      path.fillType = PathFillType.nonZero;
    } else {
      path.fillType = PathFillType.evenOdd;
    }
    int dataIndex = 0;
    for (int i = 0; i < commands.length; i++) {
      var cmd = commands[i];
      if (cmd == GraphicsPathCommand.NO_OP) {
        //do nothing
      } else if (cmd == GraphicsPathCommand.MOVE_TO) {
        if (dataIndex + 1 < data.length) {
          path.moveTo(data[dataIndex++], data[dataIndex++]);
        } else if (dataIndex == data.length) {
          path.moveTo(0, 0);
        } else {
          //TODO 错误机制要和air中一样
          throw ArgumentError("Error #2004: One of the parameters is invalid.");
        }
      } else if (cmd == GraphicsPathCommand.LINE_TO) {
        if (dataIndex + 1 < data.length) {
          path.lineTo(data[dataIndex++], data[dataIndex++]);
        } else if (dataIndex == data.length) {
          path.lineTo(0, 0);
        } else {
          //TODO 错误机制要和air中一样
          throw ArgumentError("Error #2004: One of the parameters is invalid.");
        }
      } else if (cmd == GraphicsPathCommand.CURVE_TO) {
        if (dataIndex + 3 < data.length) {
          path.quadraticBezierTo(data[dataIndex++], data[dataIndex++],
              data[dataIndex++], data[dataIndex++]);
        } else if (dataIndex == data.length) {
          path.quadraticBezierTo(0, 0, 0, 0);
        } else {
          //TODO 错误机制要和air中一样
          throw ArgumentError("Error #2004: One of the parameters is invalid.");
        }
      } else if (cmd == GraphicsPathCommand.WIDE_MOVE_TO) {
        if (dataIndex + 3 < data.length) {
          dataIndex++;
          dataIndex++;
          path.moveTo(data[dataIndex++], data[dataIndex++]);
        } else if (dataIndex == data.length) {
          path.moveTo(0, 0);
        } else {
          //TODO 错误机制要和air中一样
          throw ArgumentError("Error #2004: One of the parameters is invalid.");
        }
      } else if (cmd == GraphicsPathCommand.WIDE_LINE_TO) {
        if (dataIndex + 3 < data.length) {
          dataIndex++;
          dataIndex++;
          path.lineTo(data[dataIndex++], data[dataIndex++]);
        } else if (dataIndex == data.length) {
          path.lineTo(0, 0);
        } else {
          //TODO 错误机制要和air中一样
          throw ArgumentError("Error #2004: One of the parameters is invalid.");
        }
      } else if (cmd == GraphicsPathCommand.CUBIC_CURVE_TO) {
        if (dataIndex + 5 < data.length) {
          path.cubicTo(data[dataIndex++], data[dataIndex++], data[dataIndex++],
              data[dataIndex++], data[dataIndex++], data[dataIndex++]);
        } else if (dataIndex == data.length) {
          path.cubicTo(0, 0, 0, 0, 0, 0);
        } else {
          //TODO 错误机制要和air中一样
          throw ArgumentError("Error #2004: One of the parameters is invalid.");
        }
      } else {
        //do nothing
      }
    }
    _endGraphicDataForDrawPath();
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
      [List<int>? indices,
      List<int>? uvtData,
      String culling = TriangleCulling.NONE]) {
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
      String type, List<int> colors, List<double> alphas, List<int> ratios,
      [Matrix? matrix,
      String spreadMethod = "pad",
      String interpolationMethod = "rgb",
      double focalPointRatio = 0,
      double focalRadiusRatio = 0.0, //放射填充的中心比例
      double sweepRatio = 1.0 //扫描田中的角度比例
      ]) {
    _currentGraphicData.stroke ??= Paint();
    Paint paint = _currentGraphicData.stroke!;
    paint.style = PaintingStyle.stroke;
    _finishGradientPaint(
        paint,
        type,
        colors,
        alphas,
        ratios,
        matrix,
        spreadMethod,
        interpolationMethod,
        focalPointRatio,
        focalRadiusRatio,
        sweepRatio);
  }

  /// 指定一个着色器以用于绘制线条时的线条笔触。
  void lineShaderStyle(Shader shader, [Matrix? matrix]) {
    //TODO 这个功能恐怕得等到flutter开放自定义Shader功能之后才能完成
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
      if (graphicData.$path != null) {
        if (graphicData.fill != null) {
          if (graphicData.fill!.shader != null) {
            graphicData.fill!.color = Colors.white;
          }
          canvas.drawPath(graphicData.$path!, graphicData.fill!);
        }
        if (graphicData.stroke != null) {
          if (graphicData.stroke!.shader != null) {
            graphicData.stroke!.color = Colors.white;
          }
          canvas.drawPath(graphicData.$path!, graphicData.stroke!);
        }
      }
    }
    canvas.restore();
  }
}
