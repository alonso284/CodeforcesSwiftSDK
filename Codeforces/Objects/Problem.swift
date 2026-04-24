//
//  Problem.swift
//  Codeforces
//
//  Codeforces API Object: Represents a Codeforces problem.
//  https://codeforces.com/apiHelp/objects#Problem
//

import Foundation

/// The type of a Codeforces problem.
public enum CFProblemType: String, Codable, Sendable {
    case programming = "PROGRAMMING"
    case question = "QUESTION"
}

/// Represents a Codeforces problem.
public struct CFProblem: Codable, Equatable, Sendable {
    /// ID of the contest this problem belongs to.
    public let contestId: Int?
    /// Short name of the problemset the problem belongs to.
    public let problemsetName: String?
    /// Problem index (e.g., "A", "B1").
    public let index: String
    /// Problem name.
    public let name: String
    /// Problem type.
    public let type: CFProblemType
    /// Maximum number of points for the problem.
    public let points: Double?
    /// Problem rating (difficulty).
    public let rating: Int?
    /// List of tags for the problem.
    public let tags: [String]
}
