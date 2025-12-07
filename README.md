# infix

A lightweight Dart library that elegantly solves the code nesting problem using infix operators.

## Overview

When building nested Widget trees or data structures, you often face "callback hell" or the "pyramid problem". Traditional nested approaches:

```dart
// ❌ Excessive nesting makes code hard to read
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

While encapsulating deep nesting into separate Widgets can alleviate this issue, these Widgets are often used only once and lack reusability or generality, making naming and definition an additional burden.

By observing the nesting pattern, we notice that some Widgets play an "infix" role (like `Padding`, `Center`, `Card`), while others are leaf nodes (like `Text`). By distinguishing these two roles, we can avoid nesting altogether.

The **infix** library provides a solution using `-` for infix Widgets and `>` for leaf Widgets:

```dart
import 'package:flutter/material.dart';
import 'package:infix/infix.dart';

typedef I = Infix<Widget>;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Infix Demo')),
      body: 
        - I((c) => Center(child: c))
        - I((c) => Padding(padding: EdgeInsets.all(16), child: c,))
        - I((c) => Card(elevation: 4, child: c,))
        > Text('Hello, Infix!'),
    );
  }
}
```

## Usage Examples

Use helper methods to simplify the code:

```dart
class InfixWidget extends Widget {
  final Widget child;
  
  InfixWidget(super.name, this.child);

  // Create a static factory method
  static Infix<Widget> infix(String name) =>
    Infix<Widget>((child) => InfixWidget(name, child));
}

// Using simplified syntax
final tree = 
  - InfixWidget.infix('A')
  - InfixWidget.infix('B')
  - InfixWidget.infix('C')
  > Widget('Leaf');
```

Different writing styles:

```dart
final tree2 =
    InfixWidget.infix('A') 
    - InfixWidget.infix('B') 
    - InfixWidget.infix('C') 
    > Widget('Leaf');

final tree1 =
    - InfixWidget.infix('A') 
    - InfixWidget.infix('B') 
    - InfixWidget.infix('C') 
    > Widget('Leaf');


final tree3 =
    - InfixWidget.infix('A') 
      - InfixWidget.infix('B') 
        - InfixWidget.infix('C') 
          > Widget('Leaf');

final Widget tree4 = 
    - Infix<Widget>((child) => InfixWidget('A', child))
    - Infix<Widget>((child) => InfixWidget('B', child))
    - Infix<Widget>((child) => InfixWidget('C', child))
    > Widget('Leaf');
```

Output:
```
- A
  - B
    - C
      - Leaf
```
