# infix

一个轻量级的Dart库，使用中缀操作符优雅地解决代码嵌套问题。

## 概述

在构建嵌套的Widget树或数据结构时，通常会面临"回调地狱"或"金字塔问题"。传统的嵌套写法：

```dart
// ❌ 过多的嵌套导致难以阅读
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Infix Demo')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            child: Text('Hello')
          )
        )
      ),
    );
  }
}
```

将深入的嵌套封装为 Widget 固然可以缓解此问题. 但往往这样 Widget 只使用一次, 与复用性无关, 没有通用性, 因此命名和定义又会增加额外的负担。

观察到, 嵌套的原因是 Widget 与 Wiget 之间有些不同, 有的是充当 infix 角色, 比如 `Padding`, `Center`, `Card`, 而有的是叶子节点, 比如 `Text`. 只要区分这两种角色, 就可以避免嵌套.

**infix** 库提供了这样一种解决方案，使用 `-` 作用 infix Widget 和 `>` 作用 leaf Widget：

```dart
import 'package:flutter/material.dart';
import 'package:infix/infix.dart';

typedef I = Via<Widget>;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Infix Demo')),
      body: 
        - I((c) => Center(child: c)) // 第一个 - 是可选的
        - I((c) => Padding(padding: .all(16), child: c,))
        - I((c) => Card(elevation: 4, child: c,))
        > Text('Hello, Infix!'),
      );
  }
}
```

并且非常容易调整嵌套的顺序和插入新的 infix Widget:

```dart
import 'package:flutter/material.dart';
import 'package:infix/infix.dart';

typedef I = Infix<Widget>;

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Infix Demo')),
      body: 
        - I((c) => Center(child: c))
        - I((c) => Padding(padding: .all(2), child: c,))
        - I((c) => Card(child: c,))
        - I((c) => SizedBox(width: 200, height: 100, child: c,))
        - I((c) => Center(child: c))
        > Text('Hello, Infix!'),
    );
  }
}
```


## 使用示例

使用辅助方法简化代码：

```dart
class InfixWidget extends Widget {
  final Widget child;
  
  InfixWidget(super.name, this.child);

  // 创建一个静态工厂方法
  static Infix<Widget> infix(String name) =>
    Infix<Widget>((child) => InfixWidget(name, child));
}

// 使用简化写法
final tree = 
  - InfixWidget.infix('A')
  - InfixWidget.infix('B')
  - InfixWidget.infix('C')
  > Widget('Leaf');
```

几种风格的写法：

```dart
final tree2 =
    InfixWidget.i('A') 
    | InfixWidget.i('B') 
    | InfixWidget.i('C') 
    > Widget('Leaf');

final tree1 = 
    - InfixWidget.i('A') 
    - InfixWidget.i('B') 
    - InfixWidget.i('C') 
    > Widget('Leaf');

final tree3 = 
    - InfixWidget.i('A') 
      - InfixWidget.i('B') 
        - InfixWidget.i('C') 
          > Widget('Leaf');

final Widget tree4 = 
      -via((Widget child) => InfixWidget('A', child)) 
      .via((Widget child) => InfixWidget('B', child)) 
      .via((Widget child) => InfixWidget('C', child)) 
      > Widget('Leaf');
```

输出：
```
- A
  - B
    - C
      - Leaf
```



