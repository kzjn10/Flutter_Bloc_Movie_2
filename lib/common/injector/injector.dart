import 'package:kiwi/kiwi.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();

  // ignore: type_annotate_public_apis
  static final resolve = container.resolve;
}
