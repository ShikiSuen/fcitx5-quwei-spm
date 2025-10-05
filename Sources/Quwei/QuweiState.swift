/*
 * SPDX-FileCopyrightText: 2024 fcitx5-quwei-spm Contributors
 * Based on original work: 2021~2021 CSSlayer <wengxt@gmail.com>
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * QuweiState - State management for Quwei input method
 * 
 * Note: This is a Swift rewrite demonstrating the state management logic.
 */

import CFcitx5Imports
import Foundation

/// State class for managing input context in Quwei
/// Manages the input buffer and candidate selection for a single input context
public class QuweiState {
    private weak var engine: QuweiEngine?
    private var buffer: String = ""
    
    // Key codes for selection (1-9, 0)
    private static let selectionKeys = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    
    public init(engine: QuweiEngine) {
        self.engine = engine
    }
    
    /// Handle key input
    /// - Parameter key: The key character as a string
    /// - Returns: True if the key was handled, false otherwise
    public func handleKey(_ key: String) -> Bool {
        guard let engine = engine else { return false }
        
        // Handle selection keys when buffer has 3 digits
        if buffer.count == 3 {
            if let index = Self.selectionKeys.firstIndex(of: key) {
                // User selected a candidate
                if let candidate = getCandidateAt(index: index) {
                    // In a full implementation, this would commit the candidate
                    reset()
                    return true
                }
            }
        }
        
        // Handle backspace
        if key == "backspace" {
            if !buffer.isEmpty {
                buffer.removeLast()
                return true
            }
            return false
        }
        
        // Handle escape
        if key == "escape" {
            if !buffer.isEmpty {
                reset()
                return true
            }
            return false
        }
        
        // Handle return/enter
        if key == "return" {
            if !buffer.isEmpty {
                // In a full implementation, this would commit the buffer
                reset()
                return true
            }
            return false
        }
        
        // Handle digit input
        if let _ = Int(key), buffer.count < 3 {
            buffer.append(key)
            return true
        }
        
        return false
    }
    
    /// Get current buffer content
    public func getBuffer() -> String {
        return buffer
    }
    
    /// Check if buffer has complete code (3 digits)
    public func hasCompleteCode() -> Bool {
        return buffer.count == 3
    }
    
    /// Get current code as integer
    public func getCurrentCode() -> Int? {
        guard hasCompleteCode() else { return nil }
        return Int(buffer)
    }
    
    /// Set code and update buffer
    public func setCode(_ code: Int) {
        guard code >= 0 && code <= 999 else { return }
        
        var codeStr = String(code)
        while codeStr.count < 3 {
            codeStr = "0" + codeStr
        }
        buffer = codeStr
    }
    
    /// Get candidate at index
    private func getCandidateAt(index: Int) -> String? {
        guard let engine = engine, hasCompleteCode(), let baseCode = getCurrentCode() else {
            return nil
        }
        
        let candidateCode = baseCode * 10 + (index + 1)
        return convertQuweiToCharacter(code: candidateCode, conv: engine.getConv())
    }
    
    /// Get all candidates for current code
    public func getCandidates() -> [String] {
        guard let engine = engine, hasCompleteCode(), let baseCode = getCurrentCode() else {
            return []
        }
        
        var candidates: [String] = []
        for i in 0..<10 {
            let candidateCode = baseCode * 10 + (i + 1)
            if let char = convertQuweiToCharacter(code: candidateCode, conv: engine.getConv()) {
                candidates.append(char)
            }
        }
        return candidates
    }
    
    /// Reset the state
    public func reset() {
        buffer = ""
    }
}

/// Convert Quwei code to character using iconv
/// - Parameters:
///   - code: The Quwei code (e.g., 1601 for 区)
///   - conv: The iconv converter handle
/// - Returns: The converted character string, or nil if conversion fails
func convertQuweiToCharacter(code: Int, conv: iconv_t) -> String? {
    let qu = code / 100
    let wei = code % 100
    
    // Convert Quwei code to GB2312/GB18030 bytes
    var bytes: [UInt8] = [0, 0]
    
    if qu >= 95 {
        // Extended Qu 95 and 96
        bytes[0] = UInt8(qu - 95 + 0xA8)
        bytes[1] = UInt8(wei + 0x40)
        
        // Skip 0xa87f and 0xa97f
        if bytes[1] >= 0x7f {
            bytes[1] += 1
        }
    } else {
        bytes[0] = UInt8(qu + 0xa0)
        bytes[1] = UInt8(wei + 0xa0)
    }
    
    // Convert using iconv
    var inBuf = bytes
    var inSize = 2
    var outBuf = [UInt8](repeating: 0, count: 7) // FCITX_UTF8_MAX_LENGTH + 1
    var outSize = outBuf.count
    
    let result = inBuf.withUnsafeMutableBytes { inPtr -> Int in
        outBuf.withUnsafeMutableBytes { outPtr -> Int in
            var inBufPtr: UnsafeMutablePointer<CChar>? = inPtr.baseAddress?.assumingMemoryBound(to: CChar.self)
            var outBufPtr: UnsafeMutablePointer<CChar>? = outPtr.baseAddress?.assumingMemoryBound(to: CChar.self)
            
            return iconv(conv, &inBufPtr, &inSize, &outBufPtr, &outSize)
        }
    }
    
    guard result != -1 else { return nil }
    
    // Convert bytes to String
    return String(cString: outBuf)
}
