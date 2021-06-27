import '../screens/admin/events/admin_events.dart';
import '../screens/events/user_events.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<Events>(() => Events());
    register<AdminEvents>(() => AdminEvents());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}
