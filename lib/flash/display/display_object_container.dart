import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/display_object.dart';
import 'package:flutter_air/flash/display/interactive_object.dart';
import 'package:flutter_air/flash/display/stage.dart';

class DisplayObjectContainer extends InteractiveObject {
  @override
  void $onAddToStage(Stage stage) {
    super.$onAddToStage(stage);
    var length = children.length;
    for (int i = 0; i < length; i++) {
      var child = children[i];
      child.$onAddToStage(stage);
    }
  }

  @override
  void $onRemoveFromStage() {
    super.$onRemoveFromStage();
    var length = children.length;
    for (int i = 0; i < length; i++) {
      var child = children[i];
      child.$onRemoveFromStage();
    }
  }

  List<DisplayObject> children = [];
  DisplayObject addChild(DisplayObject child) {
    children.add(child);
    ContainerLayer containerLayer = super.$innerLayer as ContainerLayer;
    containerLayer.append(child.$outerLayer);

    if (stage != null) {
      child.$onAddToStage(stage!);
    }
    $requiresFrame();
    return child;
  }

  DisplayObject removeChild(DisplayObject child) {
    children.remove(child);
    child.$outerLayer.remove();
    if (stage != null) {
      child.$onRemoveFromStage();
    }
    $requiresFrame();
    return child;
  }

  @override
  void $paint() {
    super.$paint();
    for (var child in children) {
      child.$paint();
    }
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
    for (var child in children) {
      var curPic = child.$paintToPicture();
      if (curPic != null) {
        canvas.drawPicture(curPic);
      }
    }
    canvas.restore();
    canvas.transform($coreMatrix.storage);
    Picture picture = recorder.endRecording();
    return picture;
  }
}
