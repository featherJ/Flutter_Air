import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_air/flash/display/i_bitmap_drawable.dart';
import 'package:flutter_air/flash/filters/bitmap_filter.dart';
import 'package:flutter_air/flash/geom/color_transform.dart';
import 'package:flutter_air/flash/geom/matrix.dart';
import 'package:flutter_air/flash/geom/point.dart';
import 'package:flutter_air/flash/geom/rectangle.dart';
import 'package:flutter_air/flash/utils/byte_array.dart';

///使用 BitmapData 类，您可以处理 Bitmap 对象的数据（像素）。可以使用 BitmapData 类的方法创建任意大小的透明或不透明位图图像，并在运行时采用多种方式操作这些图像。也可以访问使用 flash.display.Loader 类加载的位图图像的 BitmapData。
class BitmapData extends Object implements IBitmapDrawable {
  int _width = 0;
  int get width => _width;

  int _height = 0;
  int get height => _height;

  final Rectangle _rect = Rectangle();
  Rectangle get rect {
    return _rect;
  }

  bool _transparent = false;
  bool get transparent => _transparent;

  BitmapData(int width, int height,
      [bool transparent = true, int fillColor = 0xFFFFFFFF]) {
    _width = width;
    _height = height;
    _transparent = transparent;
    //TODO fillColor;
  }

  ByteData? _bytes;
  Image? _image;
  void $initByteData(ByteData bytes, int width, int height) {
    _bytes = bytes;
    _width = width;
    _height = height;
    _clearImage();
    _createImage(_bytes!, width, height, (image) {});
  }

  void $getImage(ImageDecoderCallback callback) {}

  void _clearImage() {
    if (_image != null) {
      _image!.dispose();
      _image = null;
    }
  }

  static void _createImage(
      ByteData bytes, int width, int height, ImageDecoderCallback callback) {
    decodeImageFromPixels(
      bytes.buffer.asUint8List(),
      width,
      height,
      PixelFormat.rgba8888,
      callback,
    );
  }

  void applyFilter(BitmapData sourceBitmapData, Rectangle sourceRect,
      Point destPoint, BitmapFilter filter) {
    //TODO
  }

  BitmapData? clone() {
    //TODO
    return null;
  }

  void colorTransform(Rectangle rect, ColorTransform colorTransform) {
    //TODO
  }

  Object? compare(BitmapData otherBitmapData) {
    //TODO
    return null;
  }

  void copyChannel(BitmapData sourceBitmapData, Rectangle sourceRect,
      Point destPoint, int sourceChannel, int destChannel) {
    //TODO uint
  }

  void copyPixels(
      BitmapData sourceBitmapData, Rectangle sourceRect, Point destPoint,
      [BitmapData? alphaBitmapData,
      Point? alphaPoint,
      bool mergeAlpha = false]) {
    //TODO
  }

  void copyPixelsToByteArray(Rectangle rect, ByteArray data) {
    //TODO
  }

  void dispose() {
    //TODO
  }

  void draw(IBitmapDrawable source,
      [Matrix? matrix,
      ColorTransform? colorTransform,
      String? blendMode,
      Rectangle? clipRect,
      bool smoothing = false]) {
    //TODO
  }

  void drawWithQuality(IBitmapDrawable source,
      [Matrix? matrix,
      ColorTransform? colorTransform,
      String? blendMode,
      Rectangle? clipRect,
      bool smoothing = false,
      String? quality]) {
    //TODO
  }

  ByteArray? encode(Rectangle rect, Object compressor, [ByteArray? byteArray]) {
    //TODO
    return null;
  }

  void fillRect(Rectangle rect, int color) {
    //TODO
  }

  void floodFill(int x, int y, int color) {
    //TODO
  }

  Rectangle? generateFilterRect(Rectangle sourceRect, BitmapFilter filter) {
    //TODO
    return null;
  }

  Rectangle? getColorBoundsRect(int mask, int color, [bool findColor = true]) {
    //TODO
    return null;
  }

  int getPixel(int x, int y) {
    //TODO
    return 0;
  }

  int getPixel32(int x, int y) {
    //TODO
    return 0;
  }

  ByteArray? getPixels(Rectangle rect) {
    //TODO
    return null;
  }

  List<int>? getVector(Rectangle rect) {
    //TODO
    return null;
  }

  List<List<double>>? histogram([Rectangle? hRect]) {
    //TODO
    return null;
  }

  bool hitTest(Point firstPoint, int firstAlphaThreshold, Object secondObject,
      [Point? secondBitmapDataPoint, int secondAlphaThreshold = 1]) {
    //TODO
    return false;
  }

  void lock() {
    //TODO
  }

  void merge(
      BitmapData sourceBitmapData,
      Rectangle sourceRect,
      Point destPoint,
      int redMultiplier,
      int greenMultiplier,
      int blueMultiplier,
      int alphaMultiplier) {
    //TODO
  }

  void noise(int randomSeed,
      [int low = 0,
      int high = 255,
      int channelOptions = 7,
      bool grayScale = false]) {
    //TODO
  }

  void paletteMap(
      BitmapData sourceBitmapData, Rectangle sourceRect, Point destPoint,
      [List? redArray, List? greenArray, List? blueArray, List? alphaArray]) {
    //TODO
  }

  void perlinNoise(double baseX, double baseY, int numOctaves, int randomSeed,
      bool stitch, bool fractalNoise,
      [int channelOptions = 7, bool grayScale = false, List? offsets]) {
    //TODO
  }

  int pixelDissolve(
      BitmapData sourceBitmapData, Rectangle sourceRect, Point destPoint,
      [int randomSeed = 0, int numPixels = 0, int fillColor = 0]) {
    //TODO
    return 0;
  }

  void scroll(int x, int y) {
    //TODO
  }

  void setPixel(int x, int y, int color) {
    //TODO
  }

  void setPixel32(int x, int y, int color) {
    //TODO
  }

  void setPixels(Rectangle rect, ByteArray inputByteArray) {
    //TODO
  }

  void setVector(Rectangle rect, List<int> inputVector) {
    //TODO
  }

  int threshold(BitmapData sourceBitmapData, Rectangle sourceRect,
      Point destPoint, String operation, int threshold,
      [int color = 0, int mask = 0xFFFFFFFF, bool copySource = false]) {
    //TODO
    return 0;
  }

  void unlock([Rectangle? changeRect]) {
    //TODO
  }
}
