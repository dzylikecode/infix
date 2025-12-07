/// A class that allows infix-style composition of objects of type T.
/// This is useful for building tree-like structures in a readable manner.
/// For example, you can create a tree of widgets using infix operators.
/// Example:
/// ```dart
/// final tree =
///     - InfixWidget.infix('A')
///     - InfixWidget.infix('B')
///     - InfixWidget.infix('C')
///     > Widget('Leaf');
/// ```
/// This will create a nested structure where 'A' contains 'B', which contains 'C', which contains 'Leaf'.
/// The `-` operator is used to chain infix builders, and the `>` operator is used to apply the final child.
/// The unary `-` operator is also defined to allow for cleaner syntax when starting the chain.
class Infix<T> {
  final T Function(T child) builder;

  const Infix(this.builder);

  Infix<T> operator -(Infix<T> other) =>
      Infix((child) => builder(other.builder(child)));
  Infix<T> operator -() => this;

  T operator >(T child) => builder(child);
}
