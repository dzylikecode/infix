import 'package:infix/infix.dart';
import 'package:infix/via.dart';
import 'package:test/test.dart';

void main() {
  test('nest', () {
    expect(
      via((Widget child) => InfixWidget('A', child))
          .via((Widget child) => InfixWidget('B', child))
          .via((Widget child) => InfixWidget('C', child))
          .apply(Widget('Leaf'))
          .toString(),
      '''
- A
  - B
    - C
      - Leaf''',
    );
  });
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
