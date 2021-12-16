import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/display_object.dart';
import 'package:flutter_air/flash/display/graphics.dart';

class Shape extends DisplayObject {
  Graphics? _graphics;
  final PictureLayer _pictureLayer = PictureLayer(Rect.zero);

  @override
  Layer? get $layer {
    return _pictureLayer;
  }

  Graphics get graphics {
    _graphics ??= Graphics();
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
}
