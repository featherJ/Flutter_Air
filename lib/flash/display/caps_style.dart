// ignore_for_file: non_constant_identifier_names, constant_identifier_names

/// CapsStyle 类是可指定在绘制线条中使用的端点样式的常量值枚举。常量可用作 flash.display.Graphics.lineStyle() 方法的 caps 参数中的值。
///
/// ***@author** — featherJ*
class CapsStyle extends Object {
  ///**[静态]** 用于在 flash.display.Graphics.lineStyle() 方法的 caps 参数中指定没有端点。
  static const String NONE = "none";

  ///**[静态]** 用于在 flash.display.Graphics.lineStyle() 方法的 caps 参数中指定圆头端点。
  static const String ROUND = "round";

  ///**[静态]** 用于在 flash.display.Graphics.lineStyle() 方法的 caps 参数中指定方头端点。
  static const String SQUARE = "square";
}
