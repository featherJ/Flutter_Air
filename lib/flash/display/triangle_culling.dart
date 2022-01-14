// ignore_for_file: constant_identifier_names

/// 定义剔除算法的代码，这些算法确定在绘制三角形路径时不呈示哪些三角形。
/// 术语 POSITIVE 和 NEGATIVE 指三角形的法线在 z 轴两侧的符号。法线是一个 3D 矢量，与三角形的表面垂直。
/// 顶点 0、1 和 2 按顺时针顺序排列的三角形的法线值为正。也就是说，其法线指向正 z 轴方向，远离当前视图点。如果使用了 TriangleCulling.POSITIVE 算法，则不呈现法线为正的三角形。这里的另一个术语是背面剔除。
/// 顶点按逆时针顺序排列的三角形的法线值为负。也就是说，其法线指向负 z 轴方向，朝向当前视图点。如果使用了 TriangleCulling.NEGATIVE 算法，则不呈现法线为负的三角形。
class TriangleCulling extends Object {
  ///**[静态]** 指定剔除朝向当前视图点的所有三角形。
  static const String NEGATIVE = "negative";

  ///**[静态]** 指定不进行剔除。
  static const String NONE = "none";

  ///**[静态]** 指定剔除背向当前视图点的所有三角形。
  static const String POSITIVE = "positive";
}
