// ignore_for_file: non_constant_identifier_names

import 'package:flutter_air/flash/geom/point.dart';
import 'dart:math' as math;

class Rectangle extends Object {
  ///矩形左上角的 x 坐标。
  double x;

  ///矩形左上角的 y 坐标。
  double y;

  ///矩形的宽度（以像素为单位）。
  double width;

  ///矩形的高度（以像素为单位）。
  double height;

  ///矩形左上角的 x 坐标。
  double get left => x;
  set left(double value) {
    width += x - value;
    x = value;
  }

  ///x 和 width 属性的和。
  double get right => x + width;
  set right(double value) {
    width = value - x;
  }

  ///矩形左上角的 y 坐标。
  double get top => y;
  set top(double value) {
    height += y - value;
    y = value;
  }

  ///y 和 height 属性的和。
  double get bottom => y + height;
  set bottom(double value) {
    height = value - y;
  }

  ///由该点的 x 和 y 坐标确定的 Rectangle 对象左上角的位置。
  Point get topLeft => Point(left, top);
  set topLeft(Point value) {
    top = value.y;
    left = value.x;
  }

  ///由 right 和 bottom 属性的值确定的 Rectangle 对象的右下角的位置。
  Point get bottomRight => Point(right, bottom);
  set bottomRight(Point value) {
    bottom = value.y;
    right = value.x;
  }

  ///创建一个新 Rectangle 对象，其左上角由 x 和 y 参数指定，并具有指定的 width 和 height 参数。
  Rectangle([this.x = 0, this.y = 0, this.width = 0, this.height = 0]);

  ///通过填充两个矩形之间的水平和垂直空间，将这两个矩形组合在一起以创建一个新的 Rectangle 对象。
  Rectangle union(Rectangle toUnion) {
    var result = clone();
    if (toUnion.isEmpty()) {
      return result;
    }
    if (result.isEmpty()) {
      result.copyFrom(toUnion);
      return result;
    }
    double l = math.min(result.x, toUnion.x);
    double t = math.min(result.y, toUnion.y);
    result.setTo(l, t, math.max(result.right, toUnion.right) - l,
        math.max(result.bottom, toUnion.bottom) - t);
    return result;
  }

  ///返回一个新的 Rectangle 对象，其 x、y、width 和 height 属性的值与原始 Rectangle 对象的对应值相同。
  Rectangle clone() {
    return Rectangle(x, y, width, height);
  }

  ///确定由此 Rectangle 对象定义的矩形区域内是否包含指定的点。
  bool contains(double x, double y) {
    return this.x <= x &&
        this.x + width >= x &&
        this.y <= y &&
        this.y + height >= y;
  }

  ///确定由此 Rectangle 对象定义的矩形区域内是否包含指定的点。
  bool containsPoint(Point point) {
    if (x <= point.x &&
        x + width >= point.x &&
        y <= point.y &&
        y + height >= point.y) {
      return true;
    }
    return false;
  }

  ///确定此 Rectangle 对象内是否包含由 rect 参数指定的 Rectangle 对象。
  bool containsRect(Rectangle rect) {
    double r1 = rect.x + rect.width;
    double b1 = rect.y + rect.height;
    double r2 = x + width;
    double b2 = y + height;
    return (rect.x >= x) &&
        (rect.x < r2) &&
        (rect.y >= y) &&
        (rect.y < b2) &&
        (r1 > x) &&
        (r1 <= r2) &&
        (b1 > y) &&
        (b1 <= b2);
  }

  ///将源 Rectangle 对象中的所有矩形数据复制到调用方 Rectangle 对象中。
  void copyFrom(Rectangle sourceRect) {
    x = sourceRect.x;
    y = sourceRect.y;
    width = sourceRect.width;
    height = sourceRect.height;
  }

  ///确定在 toCompare 参数中指定的对象是否等于此 Rectangle 对象。
  bool equals(Rectangle toCompare) {
    if (this == toCompare) {
      return true;
    }
    return x == toCompare.x &&
        y == toCompare.y &&
        width == toCompare.width &&
        height == toCompare.height;
  }

  ///按指定量增加 Rectangle 对象的大小（以像素为单位）。
  void inflate(double dx, double dy) {
    x -= dx;
    width += 2 * dx;
    y -= dy;
    height += 2 * dy;
  }

  ///增加 Rectangle 对象的大小。
  void inflatePoint(Point point) {
    inflate(point.x, point.y);
  }

  ///如果在 toIntersect 参数中指定的 Rectangle 对象与此 Rectangle 对象相交，则返回交集区域作为 Rectangle 对象。
  Rectangle intersection(Rectangle toIntersect) {
    var newRect = clone();
    double x0 = newRect.x;
    double y0 = newRect.y;
    double x1 = toIntersect.x;
    double y1 = toIntersect.y;
    double l = math.max(x0, x1);
    double r = math.min(x0 + newRect.width, x1 + toIntersect.width);
    if (l <= r) {
      double t = math.max(y0, y1);
      double b = math.min(y0 + newRect.height, y1 + toIntersect.height);
      if (t <= b) {
        newRect.setTo(l, t, r - l, b - t);
        return newRect;
      }
    }
    newRect.setEmpty();
    return newRect;
  }

  ///确定在 toIntersect 参数中指定的对象是否与此 Rectangle 对象相交。
  bool intersects(Rectangle toIntersect) {
    return math.max(x, toIntersect.x) <= math.min(right, toIntersect.right) &&
        math.max(y, toIntersect.y) <= math.min(bottom, toIntersect.bottom);
  }

  ///确定此 Rectangle 对象是否为空。
  bool isEmpty() {
    return width <= 0 || height <= 0;
  }

  ///按指定量调整 Rectangle 对象的位置（由其左上角确定）。
  void offset(double dx, double dy) {
    x += dx;
    y += dy;
  }

  ///将 Point 对象用作参数来调整 Rectangle 对象的位置。
  void offsetPoint(Point point) {
    offset(point.x, point.y);
  }

  ///将 Rectangle 对象的所有属性设置为 0。
  void setEmpty() {
    x = 0;
    y = 0;
    width = 0;
    height = 0;
  }

  ///将 Rectangle 的成员设置为指定值
  void setTo(double xa, double ya, double widtha, double heighta) {
    x = xa;
    y = ya;
    width = widtha;
    height = heighta;
  }

  @override
  String toString() {
    return '(x=$x, y=$y, width=$width, height=$height)';
  }
}
