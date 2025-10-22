import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:lang_learn_mobile/ui_kit/cards/memory_card/widgets/add_hint/bloc/add_hint_bloc.dart';

void showAddHintDialog(BuildContext context, {required String literaId}) {
  final TextEditingController textController = TextEditingController();
  String? selectedImagePath;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => AddHintBloc(
          memoryCardsRepository: context
              .read<DiLocator>()
              .get<MemoryCardsRepository>(),
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
          child: AlertDialog(
            title: const Text('Добавить подсказку'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your hint',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                          allowedExtensions: [
                            'jpg',
                            'jpeg',
                            'png',
                            'gif',
                            'webp',
                            'bmp',
                            'tiff',
                            'heic',
                          ],
                          type: FileType.custom,
                        );
                    if (result != null && context.mounted) {
                      selectedImagePath = result.files.first.path;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'File selected: ${result.files.first.name}',
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.attach_file),
                  label: const Text('Pick File'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              BlocBuilder<AddHintBloc, AddHintState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: state is AddHintLoading
                        ? null
                        : () {
                            if (textController.text.isNotEmpty ||
                                selectedImagePath != null) {
                              context.read<AddHintBloc>().add(
                                AddHintSubmitted(
                                  literaId: literaId,
                                  hint: textController.text.isNotEmpty
                                      ? textController.text
                                      : null,
                                  imagePath: selectedImagePath,
                                ),
                              );
                            }
                          },
                    child: state is AddHintLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Submit'),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
