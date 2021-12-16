import 'dart:ui';

import 'package:flutter/rendering.dart';

abstract class DisplayObject extends Object {
  Layer? get $layer {
    return null;
  }

  void $paint() {}
}
