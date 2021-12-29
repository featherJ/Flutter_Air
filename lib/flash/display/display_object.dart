import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_air/flash/display/stage.dart';

abstract class DisplayObject extends Object {
  Stage? $stage;
  Stage? get stage {
    return $stage;
  }

  Layer? get $layer {
    return null;
  }

  void $onAddToStage(Stage stage) {
    $stage = stage;
  }

  void $onRemoveFromStage() {
    $stage = null;
  }

  void $requestFrame() {
    if (stage != null) {
      stage!.$requestFrame();
    }
  }

  void $paint() {}
}
