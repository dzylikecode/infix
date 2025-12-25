# infix

一个轻量级的Dart库，使用中缀操作符优雅地解决代码嵌套问题。

## 概述

在构建嵌套的Widget树或数据结构时，通常会面临"回调地狱"或"金字塔问题"。传统的嵌套写法：

```dart
// ❌ 过多的嵌套导致难以阅读
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Infix Example')),
      body: Center(
        child: ColoredBox(
          color: Colors.amberAccent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Text('Nested Widgets'),
            ),
          ),
        ),
      ),
    );
  }
}
```

将深入的嵌套封装为 Widget 固然可以缓解此问题. 但往往这样 Widget 只使用一次, 与复用性无关, 没有通用性, 因此命名和定义又会增加额外的负担。

观察到, 嵌套的原因是 Widget 与 Wiget 之间有些不同, 有的是充当 infix 角色, 比如 `Padding`, `Center`, `Card`, 而有的是叶子节点, 比如 `Text`. 只要区分这两种角色, 就可以避免嵌套.

**infix** 库提供了这样一种解决方案，使用 `-`(wrap/via/-/|) 作用 infix Widget 和 `>` 作用 leaf Widget：

```dart
class MyHomePage extends StatelessWidget {
  @Preview(name: "MyHomePage Preview")
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Infix Example')),
      body:
          wrap((c) => Center(child: c))
              .wrap((c) => ColoredBox(color: Colors.amberAccent, child: c))
              .wrap((c) => Padding(padding: const .all(16.0), child: c))
              .wrap((c) => Card(child: c)) >  // 这里作用到 leaf Widget
          Text('Nested Widgets'),
    );
  }
}
```

并且非常容易调整嵌套的顺序和插入新的 infix Widget。在 vscode 当中，只需要在此行使用快捷键 `Alt+Up/Down` 即可调整顺序。

实际上这就是 Python 中的 decorator 

```python
@Center
@ColoredBox(Colors.amberAccent)
@Card
def build(): return Text('Hello, Infix!')
```

更多使用示例请参考[example](example/example.md)

## via

目的是用来适配 child 和 parent 类型不一致的场景。这个时候没法推断 child 的类型，必须显式指定类型。

```dart
via((App c) => PrarentApp(child: c))
.via((Child c) => App(child: c))
> Leaf()
```

