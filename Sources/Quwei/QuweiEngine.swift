/*
 * SPDX-FileCopyrightText: 2024 fcitx5-quwei-spm Contributors
 * Based on original work: 2021~2021 CSSlayer <wengxt@gmail.com>
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * QuweiEngine - Swift implementation of the Quwei Input Method Engine
 * 
 * Note: This is a Swift rewrite demonstrating C++ interop via CFcitx5Imports.
 * The actual FCITX5 integration requires additional bridging code for full functionality.
 */

import CFcitx5Imports
import Foundation

/// Main engine class for Quwei input method
/// This class manages the Quwei input method engine and maintains state across input contexts.
public class QuweiEngine {
    private var conv: iconv_t
    private var states: [String: QuweiState] = [:]
    
    public init() {
        // Initialize iconv for GB18030 to UTF-8 conversion
        self.conv = iconv_open("UTF-8", "GB18030")
        
        guard self.conv != iconv_t(bitPattern: -1) else {
            fatalError("Failed to create iconv converter for GB18030 to UTF-8")
        }
    }
    
    deinit {
        if conv != iconv_t(bitPattern: -1) {
            iconv_close(conv)
        }
    }
    
    /// Get the iconv converter handle
    public func getConv() -> iconv_t {
        return conv
    }
    
    /// Get or create a state for a given context ID
    public func getState(contextId: String) -> QuweiState {
        if let state = states[contextId] {
            return state
        }
        
        let newState = QuweiState(engine: self)
        states[contextId] = newState
        return newState
    }
    
    /// Remove state for a given context ID
    public func removeState(contextId: String) {
        states.removeValue(forKey: contextId)
    }
    
    /// Activate the input method
    /// In a full FCITX5 integration, this would set up UI components
    public func activate() {
        // Setup would include:
        // - Loading punctuation module
        // - Loading quickphrase module
        // - Setting up status area actions (chttrans, punctuation, fullwidth)
    }
    
    /// Reset the input method state for a context
    public func reset(contextId: String) {
        if let state = states[contextId] {
            state.reset()
        }
    }
}

/// Factory class for creating QuweiEngine instances
/// This would be used by FCITX5 to instantiate the input method
public class QuweiEngineFactory {
    public init() {}
    
    /// Create a new QuweiEngine instance
    public func create() -> QuweiEngine {
        return QuweiEngine()
    }
}
