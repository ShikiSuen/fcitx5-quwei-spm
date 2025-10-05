/*
 * SPDX-FileCopyrightText: 2024 fcitx5-quwei-spm Contributors
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * CFcitx5Imports - C++ wrapper for FCITX5 imports
 * This module provides a centralized location for managing FCITX5 C++ dependencies,
 * allowing different input method projects to customize their FCITX5 component dependencies.
 * 
 * NOTE: This is a demonstration/template header. In a real deployment, you would:
 * 1. Uncomment the FCITX5 includes below
 * 2. Ensure FCITX5 development headers are installed
 * 3. Configure appropriate header search paths in Package.swift
 */

#ifndef CFCITX5IMPORTS_H
#define CFCITX5IMPORTS_H

// System libraries (always available)
#include <iconv.h>

// Standard library
#include <array>
#include <memory>
#include <string>
#include <tuple>
#include <utility>

/*
 * FCITX5 Core imports
 * Uncomment these when FCITX5 development headers are installed:
 * 
 * #include <fcitx-utils/inputbuffer.h>
 * #include <fcitx-utils/i18n.h>
 * #include <fcitx-utils/utf8.h>
 * #include <fcitx/addonfactory.h>
 * #include <fcitx/addonmanager.h>
 * #include <fcitx/candidatelist.h>
 * #include <fcitx/inputcontext.h>
 * #include <fcitx/inputcontextproperty.h>
 * #include <fcitx/inputmethodengine.h>
 * #include <fcitx/inputpanel.h>
 * #include <fcitx/instance.h>
 * #include <fcitx/userinterfacemanager.h>
 */

/*
 * FCITX5 Module imports
 * Uncomment these when FCITX5 module headers are installed:
 * 
 * #include <punctuation_public.h>
 * #include <quickphrase_public.h>
 */

#ifdef __cplusplus
extern "C" {
#endif

// Export key symbols for Swift interop
// This allows Swift code to access common FCITX5 key constants and functions

// Helper function for iconv operations - demonstrates C++ to Swift interop
inline const char* getIconvUTF8() {
    return "UTF-8";
}

inline const char* getIconvGB18030() {
    return "GB18030";
}

#ifdef __cplusplus
}
#endif

#endif // CFCITX5IMPORTS_H
