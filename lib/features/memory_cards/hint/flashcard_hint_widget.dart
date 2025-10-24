import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_hint.dart'
    show FlashcardHint;
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/hint/bloc/flashcard_hint_bloc.dart';

class FlashcardHintWidget extends StatelessWidget {
  const FlashcardHintWidget({
    super.key,
    required this.picturePath,
    required this.stringHint,
  });

  final String picturePath;
  final String stringHint;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlashcardHintBloc(
        memoryCardsRepository: context
            .read<DiLocator>()
            .get<MemoryCardsRepository>(),
        stringHint: stringHint,
      )..add(FetchDataEvent<String>(params: picturePath)),
      child: BlocBuilder<FlashcardHintBloc, FetchState<FlashcardHint>>(
        builder: (context, state) {
          switch (state) {
            case FetchInitial():
            case FetchLoading():
              return Column(
                children: [
                  Expanded(
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  const SizedBox(height: 54),
                ],
              );
            case FetchLoaded<FlashcardHint>(data: final FlashcardHint data):
              return Column(
                children: [
                  Expanded(
                    child: data.pictureUrl.isEmpty
                        ? const SizedBox.shrink()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: data.pictureUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: const CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 54,
                    child: Text(
                      data.stringHint,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              );
            case FetchError(error: final UiError _):
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
