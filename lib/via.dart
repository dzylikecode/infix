typedef ViaBase<L, R> = L Function(R child);
typedef Via<T> = ViaBase<T, T>;

ViaBase<L, R> via<L, R>(ViaBase<L, R> builder) => builder;

extension ViaBaseExtension<L, R> on ViaBase<L, R> {
  ViaBase<L, T> via<T>(ViaBase<R, T> other) => (child) => this(other(child));

  ViaBase<L, R> operator -() => this;
  L operator >(R child) => this(child);
  L apply(R child) => this(child);
}

extension ViaExtension<T> on Via<T> {
  Via<T> operator -(Via<T> other) => (child) => this(other(child));
  Via<T> operator |(Via<T> other) => (child) => this(other(child));
}
