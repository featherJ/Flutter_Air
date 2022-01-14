import 'package:flutter_air/flash/display/i_graphics_data.dart';
import 'package:flutter_air/flash/display/i_graphics_fill.dart';

/// 此接口用于定义可用作 flash.display.Graphics 方法中的参数的对象，包括填充、笔触和路径。使用此接口的实现器类来创建和管理绘制属性数据，并将相同的数据重新用于不同的实例。然后，使用 Graphics 类的方法来呈现绘制对象。
class GraphicsSolidFill extends Object implements IGraphicsFill, IGraphicsData {
  ///表示填充的 Alpha 透明度值。
  int color;

  ///填充的颜色。
  double alpha;
  GraphicsSolidFill([this.color = 0, this.alpha = 1]);
}
