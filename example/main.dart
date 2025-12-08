import 'package:infix/infix.dart';
import 'package:infix/via.dart';

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

  print(tree1);
  print('-----');
  print(tree2);
  print('-----');
  print(tree3);
  print('-----');
  print(tree4);
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

  static Via<Widget> i(String name) =>
      via((Widget child) => InfixWidget(name, child));

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
