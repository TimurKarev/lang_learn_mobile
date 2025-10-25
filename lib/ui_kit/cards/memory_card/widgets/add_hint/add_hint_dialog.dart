import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/core/services/image_compression_service.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:lang_learn_mobile/ui_kit/cards/memory_card/widgets/add_hint/bloc/add_hint_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/cards/memory_card/widgets/add_hint/add_hint_dialog_body.dart';

void showAddHintDialog(BuildContext context, {required String literaId}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => AddHintBloc(
          memoryCardsRepository: context
              .read<DiLocator>()
              .get<MemoryCardsRepository>(),
          imageCompressionService: context
              .read<DiLocator>()
              .get<ImageCompressionService>(),
        ),
        child: BlocListener<AddHintBloc, AddHintState>(
          listener: (context, state) {
            if (state is AddHintSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Hint added successfully')),
              );
            } else if (state is AddHintFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to add hint: ${state.error}')),
              );
            }
          },
          child: AddHintDialogBody(literaId: literaId),
        ),
      );
    },
  );
}
