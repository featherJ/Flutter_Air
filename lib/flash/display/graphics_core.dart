import 'package:flutter/material.dart';
import 'package:flutter_air/flash/geom/matrix.dart';

//路径渲染数据
class $GraphicPathData {
  Path path = Path();
  $GraphicPathData() {
    //为了模拟 flash 中默认的路径缠绕类型，奇偶缠绕类型。
    path.fillType = PathFillType.evenOdd;
  }

  Paint? fill;
  Paint? stroke;
}

/// 矢量遮罩渲染数据
class $MaskPathsData {
  Path? path;
  Matrix? matrix;
  $MaskPathsData(this.path, this.matrix);

  /// 将当前遮罩路径数据，向内部一个对象转换一层。
  $MaskPathsData toInner(Matrix innerMatrix) {
    var im = innerMatrix.clone();
    im.invert();
    Matrix? nm = matrix;
    nm ??= Matrix();
    nm.concat(im);
    return $MaskPathsData(path, nm);
  }
}
