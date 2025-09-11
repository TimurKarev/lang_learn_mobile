enum Languages {
  kyrgyz,
  russian;

  static Languages getByName(
    String name, {
    Languages defaultValue = Languages.kyrgyz,
  }) {
    final index = Languages.values.indexWhere(
      (element) => element.name == name,
    );

    return index == -1 ? defaultValue : Languages.values[index];
  }
}
