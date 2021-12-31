import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/display_object.dart';
import 'package:flutter_air/flash/display/graphics.dart';

class Shape extends DisplayObject {
  Graphics? _graphics;
  final PictureLayer _pictureLayer = PictureLayer(Rect.zero);
  Shape() {
    ContainerLayer containerLayer = super.$innerLayer as ContainerLayer;
    containerLayer.append(_pictureLayer);
  }

  @override
  Layer get $innerLayer {
    return _pictureLayer;
  }

  Graphics get graphics {
    _graphics ??= Graphics(this);
    return _graphics!;
  }

  @override
  void $paint() {
    super.$paint();
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    graphics.$paint(canvas);
    Picture picture = recorder.endRecording();
    _pictureLayer.picture = picture;
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
    graphics.$paint(canvas);
    canvas.restore();
    canvas.transform($coreMatrix.storage);
    Picture picture = recorder.endRecording();
    return picture;
  }
}
