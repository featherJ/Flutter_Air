// ignore_for_file: constant_identifier_names

///定义这些值以用于指定路径绘制命令。
///此类中的这些值由 Graphics.drawPath() 方法使用，或存储在 GraphicsPath 对象的 commands 矢量中。
class GraphicsPathCommand extends Object {
  ///**[静态]** 表示默认的“不执行任何操作”命令。
  static const int NO_OP = 0;

  ///**[静态]** 指定一个绘图命令，该命令会将当前绘图位置移动到数据矢量中指定的 x 和 y 坐标。
  static const int MOVE_TO = 1;

  ///**[静态]** 指定一个绘图命令，该命令绘制一条从当前绘图位置开始，到数据矢量中指定的 x 和 y 坐标结束的直线。
  static const int LINE_TO = 2;

  ///**[静态]** 指定一个绘图命令，该命令使用控制点绘制一条从当前绘图位置开始，到数据矢量中指定的 x 和 y 坐标结束的曲线。
  static const int CURVE_TO = 3;

  ///**[静态]** 指定一个“移至”绘图命令，但使用两组坐标（四个值），而不是一组坐标。
  static const int WIDE_MOVE_TO = 4;

  ///**[静态]** 指定一个“直线至”绘图命令，但使用两组坐标（四个值），而不是一组坐标。
  static const int WIDE_LINE_TO = 5;

  ///**[静态]** 指定一个绘图命令，该命令使用两个控制点绘制一条从当前绘图位置开始，到数据矢量中指定的 x 和 y 坐标结束的曲线。
  static const int CUBIC_CURVE_TO = 6;
}
