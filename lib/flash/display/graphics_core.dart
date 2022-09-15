import 'package:flutter/material.dart';
import 'package:flutter_air/flash/geom/matrix.dart';

//路径渲染数据
class $GraphicPathData {
  Path? $path;

  Path get path {
    //为了模拟 flash 中默认的路径缠绕类型，奇偶缠绕类型。
    if ($path == null) {
      $path = Path();
      $path!.fillType = PathFillType.evenOdd;
    }
    return $path!;
  }

  //图片的异步要同时解决下面这三个问题。
  //TODO 对于一些延时绘制的数据可以放到这里，加一个属性来判断是否加载完成，如果没有加载完成的则直接忽略，加载完成了再重新requestframe一次
  //TODO 目前能想到的方案了，不过这样做会有一个隐患，就是在如果图片类的加载过程较慢，在某些帧可能会没有这个图片，然后下一帧图片出现，出现一个同步引起的闪烁问题。所以到底是图片卡顿一下好，还是全局卡顿一下好？全局卡顿要处理丢弃帧的问题，应该如何处理？
  //TODO 另外，draw也是一个问题，如果是一个异步的显示对象处于一个更新状态，那么draw一定得是一个异步方法了。但是如果对于处理每帧都需要draw的情况就比较复杂了。
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
