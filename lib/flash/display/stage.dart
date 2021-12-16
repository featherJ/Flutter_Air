import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_air/flash/display/display_object_container.dart';

class Stage extends DisplayObjectContainer {
  Stage() {
    WidgetsFlutterBinding.ensureInitialized();
    window.onDrawFrame = $paint;
    window.scheduleFrame();
  }
  @override
  void $paint() {
    super.$paint();
    SceneBuilder sceneBuilder = SceneBuilder();
    ContainerLayer rootLayer = $layer as ContainerLayer;
    rootLayer.addToScene(sceneBuilder);
    Scene scene = sceneBuilder.build();
    window.render(scene);
  }
}
