import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/router/paths.dart';
import 'package:lang_learn_mobile/core/router/tili_navigation.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/fetch_memory_challenge/memory_challenge_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challenge_screen.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';

class MemoryChallangePageListener extends StatefulWidget {
  const MemoryChallangePageListener({super.key, required this.challengeTheme});

  final ChallengeThemes challengeTheme;

  @override
  State<MemoryChallangePageListener> createState() =>
      _MemoryChallangePageListenerState();
}

class _MemoryChallangePageListenerState
    extends State<MemoryChallangePageListener> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FetchMemoryChallengeBloc, FetchState<List<Flashcard>>>(
          listenWhen: (previous, current) =>
              previous is! FetchLoaded<List<Flashcard>> &&
              current is FetchLoaded<List<Flashcard>>,
          listener: (context, state) {
            if (state case FetchLoaded<List<Flashcard>>(data: final data)) {
              context.read<PerformMemoryChallangeBloc>().add(
                PerformMemoryChallangeCardsReadyEvent(cards: data),
              );
            }
          },
        ),
        BlocListener<SettingsBloc, ModelHandlerState<FlashcardsSettings>>(
          listenWhen: (previous, current) =>
              previous is! ModelHandlerLoaded<FlashcardsSettings> &&
              current is ModelHandlerLoaded<FlashcardsSettings>,
          listener: (context, state) {
            if (state case ModelHandlerLoaded<FlashcardsSettings>(
              model: final model,
            )) {
              context.read<PerformMemoryChallangeBloc>().add(
                PerformMemoryChallangeSettingsReadyEvent(settings: model),
              );
            }
          },
        ),
        BlocListener<FetchMemoryChallengeBloc, FetchState<List<Flashcard>>>(
          listenWhen: (previous, current) =>
              previous is! FetchError<List<Flashcard>> &&
              current is FetchError<List<Flashcard>>,
          listener: (context, state) {
            if (state case FetchError<List<Flashcard>>(error: final error)) {
              context.read<TiliNavigation>().goToError(
                context,
                error: error.copyWith(
                  buttonLabel: 'Вернуться назад',
                  onRetry: () => context.pushReplacementNamed(Paths.home.name),
                ),
              );
            }
          },
        ),
        BlocListener<PerformMemoryChallangeBloc, PerformMemoryChallangeState>(
          listenWhen: (previous, current) =>
              current is PerformMemoryChallangeError,
          listener: (context, state) {
            if (state case final PerformMemoryChallangeError error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(error.uiError.title)));
            }
          },
        ),
      ],
      child: MemoryChallengeScreen(challengeTheme: widget.challengeTheme),
    );
  }
}
