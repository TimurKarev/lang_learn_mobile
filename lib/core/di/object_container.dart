class ObjectContainer {
  ObjectContainer([Map<Type, Object>? objects])
    : _objects = objects ?? <Type, Object>{};

  final Map<Type, Object> _objects;

  T? getObject<T extends Object>() {
    return _objects[T] as T?;
  }

  void add<T extends Object>(T object) {
    _objects[T] = object;
  }

  void remove<T extends Object>(T object) {
    _objects.remove(T);
  }

  void dispose() {
    _objects.clear();
  }

  bool check<T extends Object>() {
    return _objects.containsKey(T);
  }
}
