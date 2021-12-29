// ignore_for_file: non_constant_identifier_names, constant_identifier_names

/// LineScaleMode 类为 Graphics.lineStyle() 方法中的 scaleMode 参数提供值。
///
/// ***@author** — featherJ*
class LineScaleMode extends Object {
  ///**[静态]** 将此设置用作 lineStyle() 方法的 scaleMode 参数时，线条粗细只会水平缩放。
  static const String HORIZONTAL = "horizontal";

  ///**[静态]** 将此设置用作 lineStyle() 方法的 scaleMode 参数时，线条粗细不会缩放。
  static const String NONE = "none";

  ///**[静态]** 将此设置用作 lineStyle() 方法的 scaleMode 参数时，线条粗细会始终随对象的缩放而缩放（默认值）。
  static const String NORMAL = "normal";

  ///**[静态]** 将此设置用作 lineStyle() 方法的 scaleMode 参数时，线条粗细只会垂直缩放。
  static const String VERTICAL = "vertical";
}
