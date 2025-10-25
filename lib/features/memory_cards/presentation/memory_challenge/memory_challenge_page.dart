import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/audio_player/tili_audio_player.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/core/router/paths.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/feedback_performer.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/fetch_memory_challenge/memory_challenge_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challange_page_listener.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/error_placeholder/error_page.dart';

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
        child: MemoryChallangePageListener(challengeTheme: theme),
      );
    } else {
      return ErrorPage(
        error: UiError(
          title: 'Error',
          description: 'Challenge ID is required',
          displayType: ErrorDisplayType.screen,
          buttonLabel: 'Вернуться назад',
          onRetry: () => context.goNamed(Paths.vocabularyDashboard.name),
        ),
      );
    }
  }
}
