// ignore_for_file: unnecessary_getters_setters

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/display_object_container.dart';
import 'package:flutter_air/flash/display/event_dispatcher.dart';
import 'package:flutter_air/flash/display/graphics_core.dart';
import 'package:flutter_air/flash/display/shader.dart';
import 'package:flutter_air/flash/display/stage.dart';
import 'package:flutter_air/flash/geom/matrix.dart';
import 'package:flutter_air/flash/geom/point.dart';
import 'package:flutter_air/flash/geom/vector_3d.dart';

abstract class DisplayObject extends EventDispatcher {
  Stage? $stage;
  int $nestLevel = 0;

  Stage? get stage => $stage;

  final LayerHandle _transformLayerHandle = LayerHandle();
  final TransformLayer _transformLayer = TransformLayer();
  final OpacityLayer _opacityLayer = OpacityLayer();

  DisplayObject() {
    _transformLayer.transform = _matrix.$toMatrix4();
    _transformLayer.append(_opacityLayer);
    //为了保留住 _transformLayer 避免被回收
    _transformLayerHandle.layer = _transformLayer;
  }

  final Matrix _matrix = Matrix();
  bool _matrixDirty = false;
  Matrix $getMatrix() {
    if (_matrixDirty) {
      _matrixDirty = false;
      _matrix.createBox(scaleX, scaleY, 0.0, x, y);
    }
    return _matrix;
  }

  Layer get $outerLayer => _transformLayer;
  Layer get $innerLayer => _opacityLayer;

  dynamic get accessibilityProperties {
    //TODO
    return null;
  }

  void $onAddToStage(Stage stage, int nestLevel) {
    $stage = stage;
    $nestLevel = nestLevel;
  }

  void $onRemoveFromStage() {
    $stage = null;
    $nestLevel = 0;
  }

  void $requiresFrame() {
    if (stage != null) {
      stage!.$requiresFrame();
    }
  }

  bool $isMask = false;
  DisplayObject? _mask;
  DisplayObject? get mask => _mask;
  set mask(DisplayObject? value) {
    if (_mask != null) {
      _mask!.$isMask = false;
    }
    _mask = value;
    if (_mask != null) {
      _mask!.$isMask = true;
    }
    $requiresFrame();
  }

  Path? get $maskPath {
    if (mask != null) {
      return mask!.$paintToPath();
    }
    return null;
  }

  Matrix? get $maskMatrix {
    if (mask != null) {
      var inoutMatrix = Matrix();
      var outinMatrix = Matrix();

      DisplayObject? cur = mask!.parent;
      while (cur != null) {
        if (cur is Stage) {
          break;
        }
        inoutMatrix.concat(cur.$getMatrix());
        cur = cur.parent;
      }
      cur = this;
      while (cur != null) {
        if (cur is Stage) {
          break;
        }
        outinMatrix.concat(cur.$getMatrix());
        cur = cur.parent;
      }
      outinMatrix.invert();
      inoutMatrix.concat(outinMatrix);
      return inoutMatrix;
    }
    return null;
  }

  double _alpha = 1.0;
  double get alpha => _alpha;
  set alpha(double value) {
    _alpha = value;
    $requiresFrame();
  }

  String _blendMode = "";
  String get blendMode => _blendMode;
  set blendMode(String value) {
    //TODO
    _blendMode = value;
  }

  Shader? _blendShader;
  set blendShader(Shader value) {
    //TODO
    _blendShader = value;
  }

  bool _cacheAsBitmap = false;
  bool get cacheAsBitmap => _cacheAsBitmap;
  set cacheAsBitmap(bool value) {
    //TODO
    _cacheAsBitmap = value;
  }

  Matrix? _cacheAsBitmapMatrix;
  Matrix? get cacheAsBitmapMatrix => _cacheAsBitmapMatrix;
  set cacheAsBitmapMatrix(Matrix? value) {
    //TODO
    _cacheAsBitmapMatrix = value;
  }

  List _filters = [];
  List get filters => _filters;
  set filters(List value) {
    //TODO
    _filters = value;
  }

  dynamic _loaderInfo;
  dynamic get loaderInfo => _loaderInfo;
  set loaderInfo(dynamic value) {
    //TODO
    _loaderInfo = value;
  }

  dynamic _metaData;
  dynamic get metaData => _metaData;
  set metaData(dynamic value) {
    //TODO
    _metaData = value;
  }

  double _mouseX = 0;
  double get mouseX => _mouseX; //TODO

  double _mouseY = 0;
  double get mouseY => _mouseY; //TODO

  String _name = "";
  String get name => _name;
  set name(String value) {
    //TODO  instance+数字，每次实例化一个自动+1
    _name = value;
  }

  dynamic _opaqueBackground;
  dynamic get opaqueBackground => _opaqueBackground;
  set opaqueBackground(dynamic value) {
    //TODO
    _opaqueBackground = value;
  }

  DisplayObjectContainer? $parent;
  DisplayObjectContainer? get parent => $parent; //TODO
  void $setParent(DisplayObjectContainer? parent) {
    $parent = parent;
  }

  DisplayObject? _root;
  DisplayObject? get root => _root; //TODO

  double _x = 0.0;
  double get x => _x;
  set x(double value) {
    _x = value;
    _matrixDirty = true;
    $requiresFrame();
  }

  double _y = 0.0;
  double get y => _y;
  set y(double value) {
    _y = value;
    _matrixDirty = true;
    $requiresFrame();
  }

  double _z = 0.0;
  double get z => _z;
  set z(double value) {
    _z = value;
    _matrixDirty = true;
    $requiresFrame();
  }

  double _rotation = 0;
  double get rotation => _rotation;
  set rotation(double value) {
    _rotation = value;
    //TODO
  }

  double _rotationX = 0;
  double get rotationX => _rotationX;
  set rotationX(double value) {
    _rotationX = value;
    //TODO
  }

  double _rotationY = 0;
  double get rotationY => _rotationY;
  set rotationY(double value) {
    _rotationY = value;
    //TODO
  }

  double _rotationZ = 0;
  double get rotationZ => _rotationZ;
  set rotationZ(double value) {
    _rotationZ = value;
    //TODO
  }

  double _scaleX = 1.0;
  double get scaleX => _scaleX;
  set scaleX(double value) {
    _scaleX = value;
    _matrixDirty = true;
    $requiresFrame();
  }

  double _scaleY = 1.0;
  double get scaleY => _scaleY;
  set scaleY(double value) {
    _scaleY = value;
    _matrixDirty = true;
    $requiresFrame();
  }

  double _scaleZ = 1.0;
  double get scaleZ => _scaleZ;
  set scaleZ(double value) {
    _scaleZ = value;
    _matrixDirty = true;
    $requiresFrame();
  }

  double _width = 0;
  double get width => _width;
  set width(double value) {
    _width = value;
    //TODO
  }

  double _height = 0;
  double get height => _height;
  set height(double value) {
    _height = value;
    //TODO
  }

  dynamic _scale9Grid;
  dynamic get scale9Grid => _scale9Grid;
  set scale9Grid(dynamic value) {
    _scale9Grid = value;
    //TODO
  }

  dynamic _scrollRect;
  dynamic get scrollRect => _scrollRect;
  set scrollRect(dynamic value) {
    _scrollRect = value;
    //TODO
  }

  dynamic _transform;
  dynamic get transform => _transform;
  set transform(dynamic value) {
    _transform = value;
    //TODO
  }

  bool _visible = true;
  bool get visible => _visible;
  set visible(bool value) {
    _visible = value;
  }

  dynamic getBounds(DisplayObject targetCoordinateSpace) {
    //TODO
  }

  dynamic getRect(DisplayObject targetCoordinateSpace) {
    //TODO
  }

  Point globalToLocal(Point point) {
    //TODO
    return Point();
  }

  Point localToGlobal(Point point) {
    //TODO
    return Point();
  }

  Vector3D globalToLocal3D(Point point) {
    //TODO
    return Vector3D();
  }

  bool hitTestObject(DisplayObject obj) {
    //TODO
    return false;
  }

  bool hitTestPoint(double x, double y, [bool shapeFlag = false]) {
    //TODO
    return false;
  }

  Point local3DToGlobal(Vector3D point3d) {
    //TODO
    return Point();
  }

  ///更新所有属性
  //TODO 等框架再往全面了写一些之后，要研究下这个方法应该怎么命名，谁来调用。更合理一些
  //TODO 这个方法独立出来实际上是为了paintToPicture考虑的，但是将alpha更新到层上又是一个多余的操作
  void $applyProperty() {
    //matrix
    _transformLayer.transform = $getMatrix().$toMatrix4();
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
  List<$MaskPathsData>? $paint(List<$MaskPathsData>? parentMasks) {
    $applyProperty();
    List<$MaskPathsData>? currentMasks = [];
    if (parentMasks != null) {
      for (var pm in parentMasks) {
        //将父级矩阵转换为当前矩阵
        currentMasks.add(pm.toInner($getMatrix()));
      }
    }
    if (mask != null) {
      currentMasks.add($MaskPathsData($maskPath, $maskMatrix));
    }
    return currentMasks;
  }

  ///绘制为图片，以便可以添加混合模式和渐变遮罩等
  Picture? $paintToPicture() {
    $applyProperty();
    return null;
  }

  ///绘制为路径，以便可以添加mask遮罩。
  Path? $paintToPath() {
    $applyProperty();
    return null;
  }
}
