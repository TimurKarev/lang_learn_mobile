import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';

abstract interface class FetchUseCase<T> {
  Future<Either<Failure, T>> execute();
}
