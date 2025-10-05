# fcitx5-quwei-spm

A sample Swift Package project for FCITX5 IME development, inheriting its official Quwei sample project.

## Overview

This project converts the [fcitx5-quwei](https://github.com/fcitx/fcitx5-quwei) input method into a Swift Package Manager (SPM) compatible project. The Quwei input method is a Chinese character input method based on the GB2312 encoding scheme.

## Structure

- `Sources/Quwei/` - Contains the main source files from fcitx5-quwei
  - `quwei.cpp` - Main implementation
  - `include/quwei.h` - Public header file
  - `*.conf.in*` - Configuration files
  - `CMakeLists.txt` - Original build configuration (for reference)
- `Package.swift` - Swift Package Manager manifest
- `CMakeLists.txt` - Root CMakeLists.txt from original project (for reference)
- `LICENSE` - BSD-3-Clause license

## Dependencies

The original fcitx5-quwei project depends on:
- **Fcitx5Core** - Core fcitx5 framework
- **Fcitx5Module** - Specifically:
  - Punctuation module
  - QuickPhrase module (optional)
- **iconv** - Character encoding conversion library
- **Gettext** - Internationalization support (for translations)

## Building

This Swift Package uses system libraries. To build:

```bash
swift build
```

Note: You need to have fcitx5 development libraries installed on your system.

## Original Project

This project is based on the official fcitx5-quwei sample:
- Repository: https://github.com/fcitx/fcitx5-quwei
- License: BSD-3-Clause

## License

This project inherits the BSD-3-Clause license from the original fcitx5-quwei project.
