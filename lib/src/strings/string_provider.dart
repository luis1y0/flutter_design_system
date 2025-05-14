typedef DSStringResolver = String Function(String key);

class DSString {
  const DSString._();

  static DSStringResolver? _resolver;

  static void init(DSStringResolver resolver) {
    _resolver = resolver;
  }

  static String of(String key) {
    return _resolver?.call(key) ?? key;
  }
}
