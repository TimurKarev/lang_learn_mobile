import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';

class CardListBloc extends FetchBloc<List<MemoryCardsPreview>> {
  CardListBloc(super.fetchUseCase);
}
