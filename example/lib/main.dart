import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'dart:typed_data';
import 'package:example/test/graphics_test.dart';
import 'package:flutter_air/flash/utils/byte_array.dart';
import 'package:typed_data/typed_buffers.dart';

import 'package:example/my_image.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_air/flutter_air.dart';

void main() {
  MyApp();
}

class MyApp extends Stage {
  MyApp() {
    // ByteArray byteArray = ByteArray();
    // byteArray.writeInt(100);
    // byteArray.writeInt(101);
    // byteArray.writeDouble(0.1234);
    // byteArray.writeUTF("我是天才");
    // for (var i = 0; i < 10000000; i++) {
    //   temp.add(5);
    // }
    // temp.length = 10;
    // print(byteArray.bytes);
    // byteArray.position = 0;
    // print(byteArray.readInt());
    // print(byteArray.readInt());
    // print(byteArray.readDouble());
    // print(byteArray.readUTF());
    // var time = DateTime.now().millisecondsSinceEpoch;
    // for (var i = 0; i < 1000000; i++) {
    //   var data = ByteData.view(temp.buffer);
    // }
    // var time2 = DateTime.now().millisecondsSinceEpoch;
    // print(time2 - time);
    // var tempBytes = Uint8Buffer(temp.length);
    // tempBytes.setAll(0, temp);
    // // tempBytes.add(1);
    // tempBytes.length = 5;
    // print(tempBytes);
    // print(tempBytes.lengthInBytes);

    // return;
    // addChild(MaskTest());
    addChild(GraphicsTest());
    // addChild(DrawPathTest());

    // var file = File('assets/image.png');
    // Uint8List bytes = file.readAsBytesSync();
    // instantiateImageCodec(bytes).then((result) {
    //   result.getNextFrame().then((value) {
    //     print(value.image);
    //     print(value.image.width);
    //     print(value.image.height);
    //   });
    // });
    // print(bytes.length);

    // Image.memory(bytes);
    // test(bytes);
    // print('finish');
  }

  void test(Uint8List bytes) async {
    var time = DateTime.now().millisecondsSinceEpoch;
    var result = await instantiateImageCodec(bytes);
    var time2 = DateTime.now().millisecondsSinceEpoch;
    print(time2 - time);
    var imageInfo = await result.getNextFrame();
    var image = imageInfo.image;

    // var time3 = DateTime.now().millisecondsSinceEpoch;
    // print(time3 - time2);
    // var byteData = await image.toByteData();
    // var time4 = DateTime.now().millisecondsSinceEpoch;
    // print("toByteData ${time4 - time3}");

    //   print("createImage ${time5 - time4}");
    //   print(image2.width);
    //   print(image2.height);
    // });

    var shape = Shape();
    shape.graphics.beginBitmapFillTest(image);
    shape.graphics.drawRect(0, 0, 1000, 1000);
    shape.graphics.endFill();
    addChild(shape);
    image.dispose();

    // var image2 = await createImage(byteData!, image.width, image.height);
    // var time5 = DateTime.now().millisecondsSinceEpoch;
    // print("createImage ${time5 - time4}");
    // print(image2.width);
    // print(image2.height);

    // decodeImageFromPixels(
    //   byteData!.buffer.asUint8List(),
    //   image.width,
    //   image.height,
    //   PixelFormat.rgba8888,
    //   (image2) {
    //     var time5 = DateTime.now().millisecondsSinceEpoch;
    //     print("createImage ${time5 - time4}");
    //     print(image2.width);
    //     print(image2.height);
    //   },
    // );

    // var time5 = DateTime.now().millisecondsSinceEpoch;
    // print(time5 - time4);
    // var imageInfo2 = await result2.getNextFrame();
    // var image2 = imageInfo2.image;
    // var time6 = DateTime.now().millisecondsSinceEpoch;
    // print(time6 - time5);

    // return image.width;
  }

  Future<Image> createImage(ByteData bytes, int width, int height) {
    final Completer<Image> completer = Completer<Image>();
    decodeImageFromPixels(
      bytes.buffer.asUint8List(),
      width,
      height,
      PixelFormat.rgba8888,
      completer.complete,
    );
    return completer.future;
  }
}
