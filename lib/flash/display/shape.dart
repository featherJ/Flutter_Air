import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/display_object.dart';
import 'package:flutter_air/flash/display/graphics.dart';
import 'package:flutter_air/flash/display/graphics_core.dart';

class Shape extends DisplayObject {
  Graphics? _graphics;
  final PictureLayer _pictureLayer = PictureLayer(Rect.zero);
  Shape() {
    ContainerLayer containerLayer = super.$innerLayer as ContainerLayer;
    containerLayer.append(_pictureLayer);
  }

  @override
  Layer get $innerLayer => _pictureLayer;

  Graphics get graphics {
    _graphics ??= Graphics(this);
    return _graphics!;
  }

  @override
  List<$MaskPathsData>? $paint(List<$MaskPathsData>? parentMasks) {
    List<$MaskPathsData>? currentMasks = super.$paint(parentMasks);
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    graphics.$paint(canvas, currentMasks);
    Picture picture = recorder.endRecording();
    _pictureLayer.picture = picture;
    return currentMasks;
  }

  ///绘制为图片，以便可以添加混合模式和遮罩等
  @override
  Picture? $paintToPicture() {
    super.$paintToPicture();
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    //TODO 这种透明模式会整体添加，与Flash中的透明有差异，需要研究下如何维护一致性问题。整体添加又有整体添加的好处，所以看如何做兼容处理。
    final paint = Paint();
    paint.color = Color.fromRGBO(0, 0, 0, alpha);
    canvas.saveLayer(Rect.zero, paint);
    graphics.$paint(canvas, null);
    canvas.restore();
    canvas.transform($getMatrix().$storage);
    Picture picture = recorder.endRecording();
    return picture;
  }

  ///绘制为路径，以便可以添加mask遮罩。
  @override
  Path? $paintToPath() {
    super.$paintToPath();
    var clipPath = Path();
    for (int i = 0; i < graphics.$drawingQueue.length; i++) {
      var path = graphics.$drawingQueue[i].path;
      /* TODO 如下两个屏蔽的方法效果更合理，但是addpath的效果和flash中的一致。
      两者的区别在于，combine方法会保留因为在同一区域重复绘制的奇偶裁剪效果。（合理效果）
      但是addpath会直接舍弃奇偶裁剪效果，将取路径外轮廓。（air效果）
      */
      // path = path.transform($getMatrix().$storage);
      // clipPath = Path.combine(PathOperation.union, clipPath, path);
      clipPath.addPath(path, Offset.zero, matrix4: $getMatrix().$storage);
    }
    return clipPath;
  }
}
