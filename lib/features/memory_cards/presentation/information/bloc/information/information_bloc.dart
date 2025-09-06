import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/vocabulary.dart';

class InformationBloc extends FetchBloc<Vocabulary> {
  InformationBloc(super.fetchUseCase);
}
