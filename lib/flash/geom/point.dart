// ignore_for_file: non_constant_identifier_names

import 'dart:math' as math;

class Point extends Object {
  static final double _deg_to_rad = math.pi / 180;

  double x;
  double y;
  Point([this.x = 0, this.y = 0]);

  double get length => math.sqrt(x * x + y * y);

  Point add(Point v) {
    return Point(x + v.x, y + v.y);
  }

  Point clone() {
    return Point(x, y);
  }

  void copyFrom(Point sourcePoint) {
    x = sourcePoint.x;
    y = sourcePoint.y;
  }

  static double distance(Point pt1, Point pt2) {
    var dx = pt2.x - pt1.x;
    var dy = pt2.y - pt1.y;
    dx *= dx;
    dy *= dy;
    return math.sqrt(dx + dy);
  }

  bool equals(Point toCompare) {
    return x == toCompare.x && y == toCompare.y;
  }

  static Point interpolate(Point pt1, Point pt2, double f) {
    var f1 = 1 - f;
    return Point(pt1.x * f + pt2.x * f1, pt1.y * f + pt2.y * f1);
  }

  void normalize(double thickness) {
    if (x != 0 || y != 0) {
      var relativeThickness = thickness / length;
      x *= relativeThickness;
      y *= relativeThickness;
    }
  }

  void offset(double dx, double dy) {
    x += dx;
    y += dy;
  }

  static Point polar(double len, double angle) {
    return Point(len * math.cos(angle / _deg_to_rad),
        len * math.sin(angle / _deg_to_rad));
  }

  void setTo(double xa, double ya) {
    x = xa;
    y = ya;
  }

  Point subtract(Point v) {
    return Point(x - v.x, y - v.y);
  }

  @override
  String toString() {
    return '(x=$x, y=$y)';
  }
}
