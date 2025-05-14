class DSBreakpoint {
  final int size;
  final int margin;
  final int columns;

  const DSBreakpoint(
      {required this.size, required this.margin, required this.columns});
}

class DSBreakpoints {
  static const DSBreakpoint small = DSBreakpoint(
    size: 490,
    margin: 24,
    columns: 4,
  );
  static const DSBreakpoint medium = DSBreakpoint(
    size: 768,
    margin: 32,
    columns: 6,
  );
  static const DSBreakpoint large = DSBreakpoint(
    size: 1040,
    margin: 40,
    columns: 8,
  );
  static const DSBreakpoint extraLarge = DSBreakpoint(
    size: 1440,
    margin: 64,
    columns: 12,
  );
}
