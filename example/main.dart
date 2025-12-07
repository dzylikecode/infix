import 'package:infix/infix.dart';

void main() {
  // dart format off
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
  // dart format on

  print(tree1);
  print('-----');
  print(tree2);
  print('-----');
  print(tree3);
  print('-----');
  print(tree4);
  print('-----');
}

class Widget {
  final String name;
  const Widget(this.name);
  @override
  String toString() => "- $name";

  String toTreeString([String indent = '']) => indent + toString();
}

class InfixWidget extends Widget {
  final Widget child;
  InfixWidget(String name, this.child) : super(name);

  static Infix<Widget> infix(String name) =>
      Infix<Widget>((child) => InfixWidget(name, child));

  @override
  String toTreeString([String indent = '']) {
    final childString = child.toTreeString(indent + "  ");
    return '''$indent- $name
$childString''';
  }

  @override
  String toString() {
    return toTreeString("");
  }
}
