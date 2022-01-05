import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/display_object.dart';
import 'package:flutter_air/flash/display/graphics_core.dart';
import 'package:flutter_air/flash/display/interactive_object.dart';
import 'package:flutter_air/flash/display/stage.dart';

class DisplayObjectContainer extends InteractiveObject {
  @override
  void $onAddToStage(Stage stage, int nestLevel) {
    super.$onAddToStage(stage, nestLevel);
    var length = children.length;
    nestLevel++;
    for (int i = 0; i < length; i++) {
      var child = children[i];
      child.$onAddToStage(stage, nestLevel);
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

    var host = child.parent;
    if (host != null) {
      host.removeChild(child);
    }
    child.$setParent(this);

    if (stage != null) {
      child.$onAddToStage(stage!, $nestLevel + 1);
    }

    $requiresFrame();
    return child;
  }

  void $updateLayersVisible() {
    //TODO 这里每次都这样操作有额外的性能开销，需要只真对脏了的进行处理。
    ContainerLayer containerLayer = super.$innerLayer as ContainerLayer;
    containerLayer.removeAllChildren();
    for (var child in children) {
      if (!child.$isMask && child.visible) {
        containerLayer.append(child.$outerLayer);
      }
    }
  }

  DisplayObject removeChild(DisplayObject child) {
    children.remove(child);
    child.$outerLayer.remove();
    if (stage != null) {
      child.$onRemoveFromStage();
    }
    child.$setParent(null);
    $requiresFrame();
    return child;
  }

  @override
  List<$MaskPathsData>? $paint(List<$MaskPathsData>? parentMasks) {
    List<$MaskPathsData>? currentMasks = super.$paint(parentMasks);
    $updateLayersVisible();
    for (var child in children) {
      if (!child.$isMask) {
        child.$paint(currentMasks);
      }
    }
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
    for (var child in children) {
      var curPic = child.$paintToPicture();
      if (curPic != null) {
        canvas.drawPicture(curPic);
      }
    }
    canvas.restore();
    canvas.transform($getMatrix().$storage);
    Picture picture = recorder.endRecording();
    return picture;
  }

  @override
  Path? $paintToPath() {
    super.$paintToPath();
    var clipPath = Path();
    //TODO 这个是为了模拟在Adobe Air 中的效果，但是我觉得这样不合理。
    for (var child in children) {
      var curPaths = child.$paintToPath();
      if (curPaths != null) {
        /* TODO 如下两个屏蔽的方法效果更合理，但是addpath的效果和flash中的一致。
        两者的区别在于，combine方法会保留因为在同一区域重复绘制的奇偶裁剪效果。（合理效果）
        但是addpath会直接舍弃奇偶裁剪效果，将取路径外轮廓。（air效果）
        */
        // curPaths = curPaths.transform($getMatrix().$storage);
        // clipPath = Path.combine(PathOperation.union, clipPath, curPaths);
        clipPath.addPath(curPaths, Offset.zero, matrix4: $getMatrix().$storage);
      }
    }
    return clipPath;
  }
}
