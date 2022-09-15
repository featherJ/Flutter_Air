class ColorTransform extends Object {
  /// 与 Alpha 透明度通道值相乘的十进制值。
  double alphaMultiplier;

  /// -255 到 255 之间的数字，加到 Alpha 透明度通道值和 alphaMultiplier 值的乘积上。
  double alphaOffset;

  ///	与蓝色通道值相乘的十进制值。
  double blueMultiplier;

  /// -255 到 255 之间的数字，它先与 blueMultiplier 值相乘，再与蓝色通道值相加。
  double blueOffset;

  /// ColorTransform 对象的 RGB 颜色值。
  int color = 0;

  ///	与绿色通道值相乘的十进制值。
  double greenMultiplier;

  /// -255 到 255 之间的数字，它先与 greenMultiplier 值相乘，再与绿色通道值相加。
  double greenOffset;

  /// 与红色通道值相乘的十进制值。
  double redMultiplier;

  /// -255 到 255 之间的数字，它先与 redMultiplier 值相乘，再与红色通道值相加。
  double redOffset;

  /// 用指定的颜色通道值和 Alpha 值为显示对象创建 ColorTransform 对象。
  ColorTransform(
      [this.redMultiplier = 1.0,
      this.greenMultiplier = 1.0,
      this.blueMultiplier = 1.0,
      this.alphaMultiplier = 1.0,
      this.redOffset = 0,
      this.greenOffset = 0,
      this.blueOffset = 0,
      this.alphaOffset = 0]);

  /// 将 second 参数指定的 ColorTranform 对象与当前 ColorTransform 对象连接，并将当前对象设置为结果，即两个颜色转换的相加组合。
  void concat(ColorTransform second) {
    redMultiplier *= second.redMultiplier;
    greenMultiplier *= second.greenMultiplier;
    blueMultiplier *= second.blueMultiplier;
    alphaMultiplier *= second.alphaMultiplier;
    redOffset += second.redOffset / 2;
    greenOffset += second.greenOffset / 2;
    blueOffset += second.blueOffset / 2;
    alphaOffset += second.alphaOffset / 2;
  }

  /// 设置字符串格式并将其返回，该字符串描述 ColorTransform 对象的所有属性。
  @override
  String toString() {
    return '(redMultiplier=$redMultiplier, greenMultiplier=$greenMultiplier, blueMultiplier=$blueMultiplier, alphaMultiplier=$alphaMultiplier, redOffset=$redOffset, greenOffset=$greenOffset, blueOffset=$blueOffset, alphaOffset=$alphaOffset)';
  }
}
