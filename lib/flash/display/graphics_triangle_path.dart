import 'package:flutter_air/flash/display/i_graphics_data.dart';
import 'package:flutter_air/flash/display/i_graphics_path.dart';
import 'package:flutter_air/flash/display/triangle_culling.dart';

/// 定义有序的一组三角形，可以使用 (u,v) 填充坐标或普通填充来呈现这些三角形。路径中的每个三角形都由三组 (x, y) 坐标表示，其中每组坐标都是三角形的一个点。
/// 三角形顶点不包含 z 坐标，并且不一定表示 3D 面。但是，可以使用三角形路径来支持在 2D 空间中呈现 3D 几何图形。
class GraphicsTrianglePath extends Object
    implements IGraphicsPath, IGraphicsData {
  /// 指定是否呈现面向给定方向的三角形。
  String culling;

  /// 一个由整数或索引构成的矢量，其中每三个索引定义一个三角形。
  List<int>? indices;

  /// 由用于应用纹理映射的标准坐标构成的矢量。
  List<double>? uvtData;

  /// 由数字构成的矢量，其中的每一对数字将被视为一个点（一个 x, y 对）。
  List<double>? vertices;

  GraphicsTrianglePath(
      [this.vertices,
      this.indices,
      this.uvtData,
      this.culling = TriangleCulling.NONE]);
}
