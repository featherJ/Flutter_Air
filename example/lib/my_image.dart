import 'dart:typed_data';
import 'dart:ui' as ui;

class MyImage implements ui.Image {
  final int width;
  final int height;
  final ByteData byteData;

  MyImage? __image;

  @pragma('vm:entry-point')
  ui.Image get _image {
    return __image!;
  }

  MyImage({required this.width, required this.height, required this.byteData}) {
    __image = this;
  }

  @override
  Future<ByteData> toByteData(
      {ui.ImageByteFormat format = ui.ImageByteFormat.rawRgba}) {
    return Future.value(byteData);
  }

  bool _disposed = false;
  @override
  void dispose() {
    _disposed = true;
  }

  @override
  ui.Image clone() {
    return MyImage(width: width, height: height, byteData: byteData);
  }

  @override
  bool get debugDisposed {
    return _disposed;
  }

  @override
  List<StackTrace>? debugGetOpenHandleStackTraces() {
    // TODO: implement debugGetOpenHandleStackTraces
    return null;
  }

  @override
  bool isCloneOf(ui.Image other) {
    return false;
  }
}
