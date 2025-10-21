import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void showHintDialog(BuildContext context) {
  final TextEditingController textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Добавить подсказку'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: 'Enter your answer'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
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
                  // Handle file selection
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
          TextButton(
            onPressed: () {
              // Handle the answer submission
              if (textController.text.isNotEmpty) {
                // Process the text input
                Navigator.of(context).pop();
              }
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}
