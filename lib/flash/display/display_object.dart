// ignore_for_file: unnecessary_getters_setters

import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/event_dispatcher.dart';
import 'package:flutter_air/flash/display/stage.dart';

abstract class DisplayObject extends EventDispatcher {
  Stage? $stage;
  Stage? get stage {
    return $stage;
  }

  final TransformLayer _transformLayer = TransformLayer();
  final OpacityLayer _opacityLayer = OpacityLayer();
  final Matrix4 _coreMatrix = Matrix4.identity();

  DisplayObject() {
    _transformLayer.transform = _coreMatrix;
    _transformLayer.append(_opacityLayer);
  }

  Layer get $outerLayer {
    return _transformLayer;
  }

  Layer get $innerLayer {
    return _opacityLayer;
  }

  void $onAddToStage(Stage stage) {
    $stage = stage;
  }

  void $onRemoveFromStage() {
    $stage = null;
  }

  void $requiresFrame() {
    if (stage != null) {
      stage!.$requiresFrame();
    }
  }

  double _alpha = 1.0;
  double get alpha {
    return _alpha;
  }

  set alpha(double value) {
    _alpha = value;
    $requiresFrame();
  }

  double _x = 0.0;
  double get x {
    return _x;
  }

  set x(double value) {
    _x = value;
    $requiresFrame();
  }

  double _y = 0.0;
  double get y {
    return _y;
  }

  set y(double value) {
    _y = value;
    $requiresFrame();
  }

  double _z = 0.0;
  double get z {
    return _z;
  }

  set z(double value) {
    _z = value;
    $requiresFrame();
  }

  double _scaleX = 1.0;
  double get scaleX {
    return _scaleX;
  }

  set scaleX(double value) {
    _scaleX = value;
    $requiresFrame();
  }

  double _scaleY = 1.0;
  double get scaleY {
    return _scaleY;
  }

  set scaleY(double value) {
    _scaleY = value;
    $requiresFrame();
  }

  double _scaleZ = 1.0;
  double get scaleZ {
    return _scaleZ;
  }

  set scaleZ(double value) {
    _scaleZ = value;
    $requiresFrame();
  }

  Matrix4 get $coreMatrix {
    return _coreMatrix;
  }

  ///更新所有属性
  //TODO 等框架再往全面了写一些之后，要研究下这个方法应该怎么命名，谁来调用。更合理一些
  //TODO 这个方法独立出来实际上是为了paintToPicture考虑的，但是将alpha更新到层上又是一个多余的操作
  void $applyProperty() {
    //matrix
    _coreMatrix.scale(scaleX, scaleY, scaleZ);
    _coreMatrix.translate(x, y, z);
    //alpha TODO 这种透明模式会整体添加，与Flash中的透明有差异，需要研究下如何维护一致性问题。整体添加又有整体添加的好处，所以看如何做兼容处理。
    int intAlpha = (_alpha * 255).round();
    if (intAlpha > 255) {
      intAlpha = 255;
    }
    if (intAlpha < 0) {
      intAlpha = 0;
    }
    _opacityLayer.alpha = intAlpha;
  }

  ///绘制到图层
  void $paint() {
    $applyProperty();
  }

  ///绘制为图片，以便可以添加混合模式和遮罩等
  Picture? $paintToPicture() {
    $applyProperty();
    return null;
  }
}
