import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/display_object.dart';

class DisplayObjectContainer extends DisplayObject {
  final TransformLayer _transformLayer = TransformLayer();
  DisplayObjectContainer() {
    _transformLayer.transform = Matrix4.identity();
  }

  @override
  Layer? get $layer {
    return _transformLayer;
  }

  List<DisplayObject> children = [];
  DisplayObject addChild(DisplayObject child) {
    children.add(child);
    _transformLayer.append(child.$layer!);
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
