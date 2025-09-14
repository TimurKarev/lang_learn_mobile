enum Languages {
  ky,
  ru;

  static Languages getByName(
    String name, {
    Languages defaultValue = Languages.ky,
  }) {
    final index = Languages.values.indexWhere(
      (element) => element.name == name,
    );

    return index == -1 ? defaultValue : Languages.values[index];
  }
}
