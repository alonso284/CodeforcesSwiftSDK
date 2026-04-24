//
//  ProblemResult.swift
//  Codeforces
//
//  Codeforces API Object: Represents a problem result in a contest standings row.
//  https://codeforces.com/apiHelp/objects#ProblemResult
//

import Foundation

/// Type of problem result.
public enum CFProblemResultType: String, Codable, Sendable {
    case preliminary = "PRELIMINARY"
    case final_ = "FINAL"

    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        switch value {
        case "PRELIMINARY": self = .preliminary
        case "FINAL": self = .final_
        default: self = .preliminary
        }
    }
}

/// Represents a problem result for a party in a contest.
public struct CFProblemResult: Codable, Equatable, Sendable {
    /// Points scored on the problem.
    public let points: Double
    /// Penalty (or time) for the problem.
    public let penalty: Int?
    /// Number of rejected (wrong) attempts before a correct one.
    public let rejectedAttemptCount: Int
    /// Result type (preliminary or final).
    public let type: CFProblemResultType
    /// Best submission time in seconds relative to contest start.
    public let bestSubmissionTimeSeconds: Int?
}
