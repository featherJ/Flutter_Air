import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/display_object.dart';
import 'package:flutter_air/flash/display/stage.dart';

class DisplayObjectContainer extends DisplayObject {
  final TransformLayer _transformLayer = TransformLayer();
  DisplayObjectContainer() {
    _transformLayer.transform = Matrix4.identity();
  }

  @override
  Layer? get $layer {
    return _transformLayer;
  }

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
    _transformLayer.append(child.$layer!);

    if (stage != null) {
      child.$onAddToStage(stage!);
    }
    $requestFrame();
    return child;
  }

  DisplayObject removeChild(DisplayObject child) {
    children.remove(child);
    child.$layer!.remove();
    if (stage != null) {
      child.$onRemoveFromStage();
    }
    $requestFrame();
    return child;
  }

  @override
  void $paint() {
    super.$paint();
    for (var child in children) {
      child.$paint();
    }
  }
}
