import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';

class FetchMemoryChallengeBloc extends FetchBloc<List<MemoryCard>> {
  FetchMemoryChallengeBloc(super.fetchUseCase);
}
