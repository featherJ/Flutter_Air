# Flutter 版 Adobe Air(Desktop)
## 背景：
目前Flutter对于桌面开发的支持还并不完善，跨平台桌面开发目前最通用的就是electron。如果 Flutter 能成为一个流行的跨平台桌面开发框架，那么这个项目可以帮助曾经Air桌面项目开发者，着手使用 Flutter 进行桌面开发。
## 官方未解决：
1. 官方对于更多桌面api和桌面多窗口的支持还在规划中（不知最终多窗口是否可以共用一个引擎）：https://github.com/flutter/flutter/issues/30701
2. 脏矩形功能目前还没有发布，对于局部变动可能会造成过多的性能开销：https://github.com/flutter/flutter/issues/33939 【done】
3. 无法实现同步绘制图片：https://github.com/flutter/flutter/issues/37180
4. 无法实现同步将Picture转成image：https://github.com/flutter/flutter/issues/77289 【done】
5. 无法实现反射机制。 
## 框架目标：
1. 舍弃掉Flutter的Framework层，直接使用Flutter的Engine层API，实现 Air 版本的Framework层，实现 Air 的绝大多数 api。
2. 开发转换器，直接将air桌面项目转为使用该框架的flutter桌面项目。并给出报告让开发者仅需要少量修改。
## 框架优势：
1. 体积比Electron小，性能可能会比Electron高，占用内存也会比Electron小（前提是多窗体共用一个引擎）。
2. 性能比Air高很多。
3. 对于原生API的调用要比 Air 灵活。
4. 可以实现更多 Air 无法实现的功能，如mac全屏等的原生支持。
5. 对于桌面程序的开发而言，开发方式比 Flutter 的虚拟节点树更灵活，且不仅可以开发桌面应用，还可以开发游戏等。 
## 可能的坑：
1. 工程量大，有不可预知的坑存在。
2. Swf和Swc和MovieClip的转换与解析可能会存在问题，可以参考 Mozilla 的 Shumway 看是否有解决思路：https://github.com/mozilla/shumway
3. Mask普通遮罩表现一致性问题。可以通过直接对path的裁剪来实现。需要注意在flutter中实现效果与air中容器嵌套复杂遮罩的一致性问题。【done】
4. Mask渐变遮罩表现一致性问题，在air中是通过cacheAsBitmap之后设置mask来实现的，在flutter中可以通过 canvas.drawPicture 来模拟，合并多个显示对象的picture，然后通过canvas统一添加效果。
5. BlendMode会存在一致性问题。可以使用  canvas.drawPicture 来实现，合并多个显示对象的picture，然后通过canvas统一添加效果。
6. 文本与文本框的显示与交互和处理机制与Air的一致性问题。(应该是最复杂的)
7. Filter会存在一致性问题。 可以使用  canvas.drawPicture 来实现，合并多个显示对象的picture，然后通过canvas统一添加效果。
8. Air中多窗体是共用一个引擎的，如果Flutter中多窗体不共用一个引擎，可能会存在内存隔离问题。那么对于框架的使用方式就会不一致，牵扯到对引擎层面的改造。
9. WebView不确定是否会有问题。
