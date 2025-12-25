
## flutter

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
              .wrap((c) => Card(child: c)) >
          Text('Nested Widgets'),
    );
  }
}
```

## dart

```dart
void main() {
  // dart format off
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
  // dart format on
}
```