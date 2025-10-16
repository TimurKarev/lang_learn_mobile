import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/audio_player/tili_audio_player.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/core/router/tili_navigation.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/feedback_performer.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/fetch_memory_challenge/memory_challenge_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challenge_screen.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/ui_kit.dart';

class MemoryChallengePage extends StatelessWidget {
  const MemoryChallengePage({super.key, required this.challengeTheme});

  final ChallengeThemes? challengeTheme;

  @override
  Widget build(BuildContext context) {
    if (challengeTheme case final ChallengeThemes theme) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => FetchMemoryChallengeBloc(
              repository: context
                  .read<DiLocator>()
                  .get<MemoryCardsRepository>(),
            )..add(FetchDataEvent<ChallengeThemes>(params: theme)),
          ),
          BlocProvider(
            create: (context) => PerformMemoryChallangeBloc(
              challange: FeedbackPerformer(challengeTheme: theme),
              audioPlayer: context.read<DiLocator>().get<TiliAudioPlayer>(),
            ),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(
              context.read<DiLocator>().get<FlashcardSettingsRepository>(),
            )..add(ModelHandlerFetchEvent<FlashcardsSettings>()),
          ),
        ],
        child: MultiBlocListener(
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
                if (state case FetchError<List<Flashcard>>(
                  error: final error,
                )) {
                  context.read<TiliNavigation>().goToError(
                    context,
                    error: error,
                  );
                }
              },
            ),
            BlocListener<
              PerformMemoryChallangeBloc,
              PerformMemoryChallangeState
            >(
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
          child: MemoryChallengeScreen(challengeTheme: theme),
        ),
      );
    } else {
      // TODO: handle error
      return const ErrorScreen(
        title: 'Error',
        message: 'Challenge ID is required',
      );
    }
  }
}
