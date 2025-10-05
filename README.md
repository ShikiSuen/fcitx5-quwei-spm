# fcitx5-quwei-spm

A sample Swift Package project for FCITX5 IME development, featuring a complete Swift rewrite of the official Quwei input method with proper C++ interop architecture.

## Overview

This project demonstrates how to build FCITX5 input methods using Swift 6.0 with modern C++ interoperability. It is based on the [fcitx5-quwei](https://github.com/fcitx/fcitx5-quwei) input method, which implements a Chinese character input method based on the GB2312 Quwei (区位) encoding scheme.

## Architecture

The project uses a two-layer architecture:

### 1. CFcitx5Imports (C++ Bridge Layer)
A dedicated C++ target that manages all FCITX5 C++ imports and dependencies. This allows:
- Centralized management of FCITX5 component dependencies
- Different input method projects to customize their dependency requirements
- Clean separation between C++ interop and Swift business logic

### 2. Quwei (Swift Implementation Layer)
The input method logic rewritten in Swift, demonstrating:
- Swift 6.0 C++ interoperability features
- Modern Swift concurrency patterns
- Clean, type-safe input method implementation

## Project Structure

```
fcitx5-quwei-spm/
├── Package.swift                    # SPM manifest (Swift 6.0)
├── Sources/
│   ├── CFcitx5Imports/             # C++ bridge layer
│   │   ├── include/
│   │   │   └── CFcitx5Imports.h    # FCITX5 imports wrapper
│   │   └── CFcitx5Imports.cpp      # Implementation
│   └── Quwei/                      # Swift input method
│       ├── QuweiEngine.swift       # Main engine
│       ├── QuweiState.swift        # State management
│       └── QuweiCandidateList.swift # Candidate handling
├── Tests/
│   └── QuweiTests/                 # Swift Testing tests
│       └── QuweiTests.swift
├── CMakeLists.txt                  # Reference: original build config
└── LICENSE                         # BSD-3-Clause license
```

## Key Features

### Swift 6.0 Features
- **C++ Interoperability**: Leverages Swift 6.0's enhanced C++ interop capabilities
- **Swift Testing**: Uses the modern Swift Testing framework instead of XCTest
- **Type Safety**: Full Swift type system with proper error handling
- **Memory Safety**: Automatic memory management with Swift's ownership model

### Input Method Features
- **Quwei Code Input**: Enter 3-digit codes (e.g., "160" for "区")
- **Candidate List**: Display 10 candidates per page
- **Page Navigation**: Browse through candidate pages
- **Character Conversion**: GB2312/GB18030 to UTF-8 encoding conversion

## Dependencies

### System Libraries (Required for Production)
When deploying to a system with FCITX5 installed, uncomment the linker settings in `Package.swift`:
- **Fcitx5Core** - Core fcitx5 framework
- **Fcitx5Module** - FCITX5 modules (Punctuation, QuickPhrase)
- **iconv** - Character encoding conversion library

### Build Dependencies
- Swift 6.0 or later
- C++17 compatible compiler

## Building

### Development Build (Without FCITX5)
For development and testing without FCITX5 installed:

```bash
swift build
swift test
```

### Production Build (With FCITX5)
When FCITX5 libraries are installed:

1. Uncomment the FCITX5 includes in `Sources/CFcitx5Imports/include/CFcitx5Imports.h`
2. Uncomment the linker settings in `Package.swift`
3. Build:
```bash
swift build -c release
```

## Testing

The project uses Swift Testing (not XCTest) for modern, expressive tests:

```bash
swift test
```

Tests cover:
- Quwei code conversion logic
- Buffer management
- GB2312 encoding calculations
- Candidate list operations

## How It Works

### Quwei Encoding
The Quwei (区位) system divides Chinese characters into a grid:
- **Qu (区)**: Row number (01-94, plus extended 95-96)
- **Wei (位)**: Column number (01-94)

For example, "区" is at position 16-01, entered as "1601".

### Conversion Process
1. User enters 3-digit code (e.g., "160")
2. System generates 10 candidates (1601-1610)
3. Each candidate is converted from GB2312 to UTF-8
4. User selects candidate with number keys (1-9, 0)

## Original Project

This project is inspired by the official fcitx5-quwei sample:
- Repository: https://github.com/fcitx/fcitx5-quwei
- Original Author: CSSlayer <wengxt@gmail.com>
- License: BSD-3-Clause

## License

This project inherits the BSD-3-Clause license from the original fcitx5-quwei project.

## Contributing

This project serves as a template for:
- Building FCITX5 input methods with Swift
- Demonstrating Swift-C++ interoperability patterns
- Using Swift 6.0 features in systems programming

Feel free to use this as a starting point for your own FCITX5 input method projects!
