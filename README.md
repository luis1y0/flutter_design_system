A design system built with atom design methodology.

## Features

You can see the set of widgets at [this link](https://luis1y0.github.io/flutter_design_system/).

## Getting started

To this package from github to your project add this to your pubspec.yaml:

```yaml
dependencies:
  flutter:
    sdk: flutter
  # add this dependency
  flutter_design_system:
    git:
      url: https://github.com/luis1y0/flutter_design_system.git
```

Working with a local version:

```yaml
dependencies:
  flutter:
    sdk: flutter
  # add this dependency
  flutter_design_system:
    path: ../path-to-package
```

## Usage

Before using any widget of this package, you need to wrap your root app widget
into this widget that defines the color scheme:

```dart
import 'package:flutter_design_system/flutter_design_system.dart';

void main() {
  runApp(DesignSystemProvider(
    colorScheme: DSColorScheme(
      primary: DSColor(color: const Color(0xFFF273B2), isLight: true),
      secondary: DSColor(color: const Color(0xFF0099FF), isLight: false),
      tertiary: DSColor(color: const Color(0xFF4C3BB2), isLight: false),
      success: DSColor(color: const Color(0xFF2DBF34), isLight: true),
      error: DSColor(color: const Color(0xFFDE3730), isLight: false),
      dark: DSColor(color: const Color(0xFF003F5F), isLight: false),
      light: DSColor(color: const Color(0xFFF1F5FF), isLight: true),
      backgroundDisabled: DSColor(color: const Color.fromARGB(255, 163, 173, 201), isLight: true),
      disabled: DSColor(color: const Color.fromARGB(255, 134, 140, 174), isLight: true),
    ),
    child: Application(),
  ));
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
