//
//  RanklistRow.swift
//  Codeforces
//
//  Codeforces API Object: Represents a row in the contest ranklist (standings).
//  https://codeforces.com/apiHelp/objects#RanklistRow
//

import Foundation

/// Represents a row in the contest standings (ranklist).
public struct CFRanklistRow: Codable, Equatable, Sendable {
    /// The party (user or team) this row belongs to.
    public let party: CFParty
    /// Rank in the contest.
    public let rank: Int
    /// Total points scored.
    public let points: Double
    /// Total penalty.
    public let penalty: Int
    /// Number of successful hacks.
    public let successfulHackCount: Int
    /// Number of unsuccessful hacks.
    public let unsuccessfulHackCount: Int
    /// Problem results for each problem in the contest.
    public let problemResults: [CFProblemResult]
    /// Last submission time in seconds relative to contest start.
    public let lastSubmissionTimeSeconds: Int?
}
