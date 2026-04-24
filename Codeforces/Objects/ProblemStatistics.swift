//
//  ProblemStatistics.swift
//  Codeforces
//
//  Codeforces API Object: Represents statistics for a problem.
//  https://codeforces.com/apiHelp/objects#ProblemStatistics
//

import Foundation

/// Represents statistics for a Codeforces problem.
public struct CFProblemStatistics: Codable, Equatable, Sendable {
    /// Contest ID the problem belongs to.
    public let contestId: Int?
    /// Problem index (e.g., "A", "B1").
    public let index: String
    /// Number of users who solved the problem.
    public let solvedCount: Int
}
