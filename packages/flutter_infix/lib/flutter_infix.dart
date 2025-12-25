import 'package:flutter/widgets.dart';
import 'package:infix/infix.dart';

export 'package:infix/infix.dart';

typedef Wrapper = Via<Widget>;

Wrapper wrap(Wrapper wrapper) => wrapper;

extension WrapperExtension on Wrapper {
  Wrapper wrap(Wrapper other) => this.via(other);
}
