// ignore_for_file: non_constant_identifier_names

import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_air/flash/geom/point.dart';
import 'package:flutter_air/flash/geom/vector_3d.dart';

class Matrix extends Object {
  static final double _deg_to_rad = math.pi / 180;

  Matrix4? _matrix4;

  double a, b, c, d, tx, ty;

  Matrix(
      [this.a = 1.0,
      this.b = 0.0,
      this.c = 0.0,
      this.d = 1.0,
      this.tx = 0.0,
      this.ty = 0.0]);

  Matrix4 $toMatrix4() {
    _matrix4 ??= Matrix4.identity();
    _matrix4!.setValues(a, b, 0, 0, c, d, 0, 0, 0, 0, 1, 0, tx, ty, 0, 1);

    return _matrix4!;
  }

  static Matrix $fromNative(Matrix4 matrix4) => Matrix(
        matrix4.storage[0],
        matrix4.storage[4],
        matrix4.storage[1],
        matrix4.storage[5],
        matrix4.storage[12],
        matrix4.storage[13],
      );

  Float64List get $storage {
    return $toMatrix4().storage;
  }

  Matrix clone() {
    return Matrix(a, b, c, d, tx, ty);
  }

  void concat(Matrix m) {
    var a = this.a * m.a;
    var b = 0.0;
    var c = 0.0;
    var d = this.d * m.d;
    var tx = this.tx * m.a + m.tx;
    var ty = this.ty * m.d + m.ty;
    if (this.b != 0.0 || this.c != 0.0 || m.b != 0.0 || m.c != 0.0) {
      a += this.b * m.c;
      d += this.c * m.b;
      b += this.a * m.b + this.b * m.d;
      c += this.c * m.a + this.d * m.c;
      tx += this.ty * m.c;
      ty += this.tx * m.b;
    }
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
    this.tx = tx;
    this.ty = ty;
  }

  void copyColumnFrom(int column, Vector3D vector3D) {
    //TODO
  }

  void copyColumnTo(int column, Vector3D vector3D) {
    //TODO
  }

  Matrix copyFrom(Matrix from) {
    a = from.a;
    b = from.b;
    c = from.c;
    d = from.d;
    tx = from.tx;
    ty = from.ty;
    return this;
  }

  void copyRowFrom(int row, Vector3D vector3D) {
    //TODO
  }

  void copyRowTo(int row, Vector3D vector3D) {
    //TODO
  }

  void createBox(double scaleX, double scaleY,
      [double rotation = 0.0, double tx = 0.0, double ty = 0.0]) {
    var self = this;
    if (rotation != 0) {
      rotation = rotation / _deg_to_rad;
      var u = math.cos(rotation);
      var v = math.sin(rotation);
      self.a = u * scaleX;
      self.b = v * scaleY;
      self.c = -v * scaleX;
      self.d = u * scaleY;
    } else {
      self.a = scaleX;
      self.b = 0;
      self.c = 0;
      self.d = scaleY;
    }
    self.tx = tx;
    self.ty = ty;
  }

  void createGradientBox(double width, double height,
      [double rotation = 0, double tx = 0, double ty = 0]) {
    createBox(width / 1638.4, height / 1638.4, rotation, tx + width / 2,
        ty + height / 2);
  }

  Point deltaTransformPoint(Point point) {
    var x = a * point.x + c * point.y;
    var y = b * point.x + d * point.y;
    return Point(x, y);
  }

  void identity() {
    a = d = 1;
    b = c = tx = ty = 0;
  }

  void invert() {
    $invertInto(this);
  }

  void $invertInto(Matrix target) {
    var a = this.a;
    var b = this.b;
    var c = this.c;
    var d = this.d;
    var tx = this.tx;
    var ty = this.ty;
    if (b == 0 && c == 0) {
      target.b = target.c = 0;
      if (a == 0 || d == 0) {
        target.a = target.d = target.tx = target.ty = 0;
      } else {
        a = target.a = 1 / a;
        d = target.d = 1 / d;
        target.tx = -a * tx;
        target.ty = -d * ty;
      }

      return;
    }
    var determinant = a * d - b * c;
    if (determinant == 0) {
      target.identity();
      return;
    }
    determinant = 1 / determinant;
    var k = target.a = d * determinant;
    b = target.b = -b * determinant;
    c = target.c = -c * determinant;
    d = target.d = a * determinant;
    target.tx = -(k * tx + c * ty);
    target.ty = -(b * tx + d * ty);
  }

  void rotate(double angle) {
    if (angle != 0) {
      angle = angle / _deg_to_rad;
      var u = math.cos(angle);
      var v = math.sin(angle);
      var ta = a;
      var tb = b;
      var tc = c;
      var td = d;
      var ttx = tx;
      var tty = ty;
      a = ta * u - tb * v;
      b = ta * v + tb * u;
      c = tc * u - td * v;
      d = tc * v + td * u;
      tx = ttx * u - tty * v;
      ty = ttx * v + tty * u;
    }
  }

  scale(double sx, double sy) {
    if (sx != 1) {
      a *= sx;
      c *= sx;
      tx *= sx;
    }
    if (sy != 1) {
      b *= sy;
      d *= sy;
      ty *= sy;
    }
  }

  void setTo(
      double aa, double ba, double ca, double da, double txa, double tya) {
    a = aa;
    b = ba;
    c = ca;
    d = da;
    tx = txa;
    ty = tya;
  }

  Point transformPoint(Point point) {
    var x = a * point.x + c * point.y + tx;
    var y = b * point.x + d * point.y + ty;
    return Point(x, y);
  }

  void translate(double dx, double dy) {
    tx += dx;
    ty += dy;
  }

  @override
  String toString() {
    return "(a=$a, b=$b, c=$c, d=$d, tx=$tx, ty=$ty)";
  }
}
