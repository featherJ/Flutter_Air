import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_air/flash/display/display_object_container.dart';
import 'package:flutter_air/flash/display/graphics_core.dart';

class Stage extends DisplayObjectContainer {
  Stage() {
    WidgetsFlutterBinding.ensureInitialized();
    initEmptyLayer();
    window.onDrawFrame = _stagePaint;
    $requiresFrame();
    $stage = this;
  }

  final OpacityLayer _emptyLayer = OpacityLayer();
  void initEmptyLayer() {
    //为了放置空渲染导致的崩溃
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    canvas.drawRect(const Rect.fromLTWH(0, 0, 1, 1), Paint());
    Picture picture = recorder.endRecording();
    PictureLayer pictureLayer = PictureLayer(Rect.zero);
    pictureLayer.picture = picture;
    _emptyLayer.alpha = 0;
    _emptyLayer.append(pictureLayer);
    ContainerLayer rootLayer = $outerLayer as ContainerLayer;
    rootLayer.append(_emptyLayer);
  }

  /// 请求帧
  @override
  void $requiresFrame() {
    window.scheduleFrame();
  }

  void _stagePaint() {
    $paint(null);
  }

  @override
  List<$MaskPathsData>? $paint(List<$MaskPathsData>? parentMasks) {
    super.$paint(parentMasks);
    SceneBuilder sceneBuilder = SceneBuilder();
    ContainerLayer rootLayer = $outerLayer as ContainerLayer;
    rootLayer.addToScene(sceneBuilder);
    Scene scene = sceneBuilder.build();
    window.render(scene);
    return null;
  }
}
