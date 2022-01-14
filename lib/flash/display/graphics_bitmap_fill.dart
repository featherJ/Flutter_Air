import 'package:flutter_air/flash/display/bitmap_data.dart';
import 'package:flutter_air/flash/display/i_graphics_data.dart';
import 'package:flutter_air/flash/display/i_graphics_fill.dart';
import 'package:flutter_air/flash/geom/matrix.dart';

/// 此接口用于定义可用作 flash.display.Graphics 方法中的参数的对象，包括填充、笔触和路径。使用此接口的实现器类来创建和管理绘制属性数据，并将相同的数据重新用于不同的实例。然后，使用 Graphics 类的方法来呈现绘制对象。
class GraphicsBitmapFill extends Object
    implements IGraphicsFill, IGraphicsData {
  ///透明的或不透明的位图图像。
  BitmapData? bitmapData;

  ///一个用于定义位图上的转换的 Matrix 对象（属于 flash.geom.Matrix 类）。
  Matrix? matrix;

  ///指定是否以平铺模式重复位图图像。
  bool repeat;

  ///指定是否将平滑处理算法应用于位图图像。
  bool smooth;
  GraphicsBitmapFill(
      [this.bitmapData, this.matrix, this.repeat = true, this.smooth = false]);
}
