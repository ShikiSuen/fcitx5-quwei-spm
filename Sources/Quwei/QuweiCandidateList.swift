/*
 * SPDX-FileCopyrightText: 2024 fcitx5-quwei-spm Contributors
 * Based on original work: 2021~2021 CSSlayer <wengxt@gmail.com>
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * QuweiCandidateList - Candidate list management for Quwei
 * 
 * Note: This demonstrates the candidate list logic in Swift.
 */

import CFcitx5Imports
import Foundation

/// Candidate word for Quwei input method
public struct QuweiCandidateWord {
    public let text: String
    public let code: Int
    public let label: String
    
    public init(text: String, code: Int, index: Int) {
        self.text = text
        self.code = code
        let labelNum = (index + 1) % 10
        self.label = "\(labelNum). "
    }
}

/// Candidate list for Quwei input method
/// Manages a pageable list of 10 candidates per page
public class QuweiCandidateList {
    private weak var engine: QuweiEngine?
    private var baseCode: Int
    private var cursor: Int = 0
    private var candidates: [QuweiCandidateWord] = []
    
    public init(engine: QuweiEngine, baseCode: Int) {
        self.engine = engine
        self.baseCode = baseCode
        generateCandidates()
    }
    
    /// Generate candidates based on the current base code
    private func generateCandidates() {
        guard let engine = engine else { return }
        
        candidates.removeAll()
        
        for i in 0..<10 {
            let fullCode = baseCode * 10 + (i + 1)
            
            if let text = convertQuweiToCharacter(code: fullCode, conv: engine.getConv()) {
                let candidate = QuweiCandidateWord(text: text, code: fullCode, index: i)
                candidates.append(candidate)
            }
        }
    }
    
    /// Get candidate at index
    public func getCandidateAt(index: Int) -> QuweiCandidateWord? {
        guard index >= 0 && index < candidates.count else { return nil }
        return candidates[index]
    }
    
    /// Get all candidates
    public func getAllCandidates() -> [QuweiCandidateWord] {
        return candidates
    }
    
    /// Get number of candidates
    public func size() -> Int {
        return candidates.count
    }
    
    /// Get cursor position
    public func getCursor() -> Int {
        return cursor
    }
    
    /// Move cursor to previous candidate
    public func prevCandidate() {
        cursor = (cursor + 9) % 10
    }
    
    /// Move cursor to next candidate
    public func nextCandidate() {
        cursor = (cursor + 1) % 10
    }
    
    /// Check if can go to previous page
    public func hasPrev() -> Bool {
        return baseCode > 0
    }
    
    /// Check if can go to next page
    public func hasNext() -> Bool {
        return baseCode < 999
    }
    
    /// Go to previous page
    public func prevPage() -> Bool {
        guard hasPrev() else { return false }
        baseCode -= 1
        generateCandidates()
        return true
    }
    
    /// Go to next page
    public func nextPage() -> Bool {
        guard hasNext() else { return false }
        baseCode += 1
        generateCandidates()
        return true
    }
    
    /// Get current base code
    public func getBaseCode() -> Int {
        return baseCode
    }
}
