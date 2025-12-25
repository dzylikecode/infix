import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_infix/flutter_infix.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePageNest extends StatelessWidget {
  @Preview(name: "Nest Preview")
  const MyHomePageNest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Infix Example')),
      body: Center(
        child: ColoredBox(
          color: Colors.amberAccent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(child: Text('Nested Widgets')),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @Preview(name: "MyHomePage Preview")
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Infix Example')),
      body:
          wrap((c) => Center(child: c))
              .wrap((c) => ColoredBox(color: Colors.red, child: c))
              .wrap((c) => Padding(padding: const .all(16.0), child: c))
              .wrap((c) => Card(child: c)) >
          Text('Nested Widgets'),
    );
  }
}
