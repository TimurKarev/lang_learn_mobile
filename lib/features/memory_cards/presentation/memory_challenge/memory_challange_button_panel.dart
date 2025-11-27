import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';

class MemoryChallangeButtonPanel extends StatelessWidget {
  const MemoryChallangeButtonPanel({
    required this.isAnswered,
    required this.cardId,
    super.key,
  });

  final bool isAnswered;
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    side: isAnswered
                        ? null
                        : BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 2,
                          ),
                  ),

                  onPressed: isAnswered
                      ? () {
                          context.read<PerformMemoryChallangeBloc>().add(
                            PerformMemoryChallangeNextEvent(feedback: false),
                          );
                        }
                      : null,
                  child: Text(AppLocalizations.of(context)!.wrong),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: isAnswered
                      ? () {
                          context.read<PerformMemoryChallangeBloc>().add(
                            PerformMemoryChallangeNextEvent(feedback: true),
                          );
                        }
                      : null,
                  child: Text(AppLocalizations.of(context)!.correct),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
