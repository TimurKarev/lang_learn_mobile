import 'package:lang_learn_mobile/core/di/object_container.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

class DiLocator {
  const DiLocator(this._objectContainer);

  final ObjectContainer _objectContainer;

  T get<T extends Object>({bool keepAlive = false, bool mock = false}) {
    final object = _objectContainer.getObject<T>();
    if (object != null) {
      return object;
    }

    if (T == MemoryCardsRepository) {
      final MemoryCardsRepository newObject;
      if (mock) {
        newObject = MemoryCardsRepositoryMock();
      } else {
        throw Exception('Mock not implemented');
        //newObject = MemoryCardsRepositoryImpl();
      }
      if (keepAlive) {
        _objectContainer.add(newObject);
      }
      return newObject as T;
    }

    throw Exception('Object not found');
  }
}
