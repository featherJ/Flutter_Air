// ignore_for_file: non_constant_identifier_names, constant_identifier_names

/// JointStyle 类是指定要在绘制线条中使用的联接点样式的常量值枚举。提供的这些常量用作 flash.display.Graphics.lineStyle() 方法的 joints 参数中的值。此方法支持三种类型的连接：尖角、圆角和斜角。
///
/// ***@author** — featherJ*
class JointStyle extends Object {
  ///**[静态]** 在 flash.display.Graphics.lineStyle() 方法的 joints 参数中指定斜角连接。
  static const String BEVEL = "bevel";

  ///**[静态]** 在 flash.display.Graphics.lineStyle() 方法的 joints 参数中指定尖角连接。
  static const String MITER = "miter";

  ///**[静态]** 在 flash.display.Graphics.lineStyle() 方法的 joints 参数中指定圆角连接。
  static const String ROUND = "round";
}
