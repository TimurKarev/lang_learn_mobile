import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class ImageCompressionService {
  Future<File?> compressImage({
    required File imageFile,
    int maxSizeKB = 50,
    int? minWidth,
    int? minHeight,
  });
}

class ImageCompressionServiceImpl implements ImageCompressionService {
  @override
  Future<File?> compressImage({
    required File imageFile,
    int maxSizeKB = 50,
    int? minWidth,
    int? minHeight,
  }) async {
    try {
      // Check if file size is already within acceptable limit
      final fileSizeKB = imageFile.lengthSync() ~/ 1024;
      if (fileSizeKB <= maxSizeKB) {
        return imageFile;
      }

      // Read the original file once
      final Uint8List originalBytes = await imageFile.readAsBytes();

      // Initialize compression parameters

      int currentWidth = minWidth ?? 1920;
      int currentHeight = minHeight ?? 1080;

      // Resolution tiers for odd attempts
      final List<Map<String, int>> resolutionTiers = [
        {'width': 1920, 'height': 1080},
        {'width': 1280, 'height': 720},
        {'width': 854, 'height': 480},
        {'width': 640, 'height': 360},
      ];

      // Quality tiers for even attempts
      final List<int> qualityTiers = [85, 70, 55, 40, 30];
      int currentQuality = qualityTiers.first;
      File? bestResult;
      int bestSize = fileSizeKB;

      // Try up to 8 attempts (4 quality + 4 resolution reductions)
      for (int attempt = 0; attempt < 8; attempt++) {
        Uint8List? compressedBytes;

        if (attempt.isOdd) {
          // Odd attempts: reduce resolution
          final resolutionIndex = (attempt - 1) ~/ 2;
          if (resolutionIndex < resolutionTiers.length) {
            currentWidth = resolutionTiers[resolutionIndex]['width']!;
            currentHeight = resolutionTiers[resolutionIndex]['height']!;
          }
        } else {
          // Even attempts: reduce quality
          final qualityIndex = attempt ~/ 2;
          if (qualityIndex < qualityTiers.length) {
            currentQuality = qualityTiers[qualityIndex];
          }
        }

        compressedBytes = await FlutterImageCompress.compressWithList(
          originalBytes,
          minWidth: currentWidth,
          minHeight: currentHeight,
          quality: currentQuality,
          format: CompressFormat.jpeg,
        );

        if (compressedBytes.isEmpty) {
          continue; // Skip this attempt if compression fails
        }

        // Create temporary compressed file
        final String compressedPath = '${imageFile.path}_temp_$attempt.jpg';
        final File compressedFile = File(compressedPath);
        await compressedFile.writeAsBytes(compressedBytes);

        final compressedSizeKB = compressedFile.lengthSync() ~/ 1024;

        // Debug: Attempt $attempt: Quality=$currentQuality, Resolution=${currentWidth}x$currentHeight, Size=${compressedSizeKB}KB

        // Check if this is the best result so far
        if (compressedSizeKB < bestSize) {
          // Delete previous best result
          if (bestResult != null) {
            await bestResult.delete();
          }
          bestResult = compressedFile;
          bestSize = compressedSizeKB;

          // If we're under the target size, we can stop
          if (bestSize <= maxSizeKB) {
            break;
          }
        } else {
          // Delete this attempt since it's not better
          await compressedFile.delete();
        }
      }

      // Clean up and return best result
      if (bestResult != null && bestSize < fileSizeKB) {
        // Rename the best result to replace original
        final String finalPath = '${imageFile.path}_compressed.jpg';
        await bestResult.rename(finalPath);
        return File(finalPath);
      } else {
        // If no improvement, return original
        if (bestResult != null) {
          await bestResult.delete();
        }
        return imageFile;
      }
    } catch (e) {
      // Return original file if compression fails
      return imageFile;
    }
  }
}
