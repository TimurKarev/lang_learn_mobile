extension StringExtension on String {
  /// Capitalizes the first letter of the string and makes the rest lowercase.
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
