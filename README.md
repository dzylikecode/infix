# infix

[English](README.md) | [中文](README_zh.md)

A lightweight Dart library that elegantly solves code nesting problems using infix operators.

## Overview

When building nested Widget trees or data structures, you often encounter "callback hell" or the "pyramid problem". The traditional nested approach:

```dart
// ❌ Too much nesting makes code hard to read
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

Encapsulating deep nesting as a Widget can help, but often such Widgets are only used once, lack reusability, and naming/definition becomes an extra burden.

By observing the nesting, we see that some Widgets act as infix roles (like `Padding`, `Center`, `Card`), while others are leaf nodes (like `Text`). By distinguishing these two roles, we can avoid excessive nesting.

The **infix** library provides a solution using `-` (wrap/via/-/|) for infix Widgets and `>` for leaf Widgets:

```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Infix Example')),
      body:
          wrap((c) => Center(child: c))
              .wrap((c) => ColoredBox(color: Colors.amberAccent, child: c))
              .wrap((c) => Padding(padding: const EdgeInsets.all(16.0), child: c))
              .wrap((c) => Card(child: c)) >  // infix applies to leaf Widget
          Text('Nested Widgets'),
    );
  }
}
```

It's also very easy to adjust the nesting order and insert new infix Widgets. In VS Code, you can use `Alt+Up/Down` to adjust the order.

This is similar to Python's decorator syntax:

```python
@Center
@ColoredBox(Colors.amberAccent)
@Card
def build(): return Text('Hello, Infix!')
```

For more usage examples, see [example/example.md](example/example.md)

## via

The purpose is to adapt scenarios where the child and parent types are inconsistent. In this case, the child type cannot be inferred and must be specified explicitly.

```dart
via((App c) => PrarentApp(child: c))
.via((Child c) => App(child: c))
> Leaf()
```
