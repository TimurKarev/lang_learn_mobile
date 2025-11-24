import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class ImageCompressionService {
  Future<Uint8List> compressImage({
    required Uint8List imageBytes,
    int maxSizeKB = 50,
    int? minWidth,
    int? minHeight,
  });
}

class ImageCompressionServiceImpl implements ImageCompressionService {
  @override
  Future<Uint8List> compressImage({
    required Uint8List imageBytes,
    int maxSizeKB = 50,
    int? minWidth,
    int? minHeight,
  }) async {
    try {
      // Check if file size is already within acceptable limit
      final fileSizeKB = imageBytes.lengthInBytes ~/ 1024;
      if (fileSizeKB <= maxSizeKB) {
        return imageBytes;
      }

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

      Uint8List bestResult = imageBytes;
      int bestSize = fileSizeKB;

      // Try up to 8 attempts (4 quality + 4 resolution reductions)
      for (int attempt = 0; attempt < 8; attempt++) {
        Uint8List compressedBytes;

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
          imageBytes,
          minWidth: currentWidth,
          minHeight: currentHeight,
          quality: currentQuality,
          format: CompressFormat.jpeg,
        );

        if (compressedBytes.isEmpty) {
          continue; // Skip this attempt if compression fails
        }

        final compressedSizeKB = compressedBytes.lengthInBytes ~/ 1024;

        // Check if this is the best result so far
        if (compressedSizeKB < bestSize) {
          bestResult = compressedBytes;
          bestSize = compressedSizeKB;

          // If we're under the target size, we can stop
          if (bestSize <= maxSizeKB) {
            break;
          }
        }
      }

      return bestResult;
    } catch (e) {
      // Return original bytes if compression fails
      return imageBytes;
    }
  }
}
