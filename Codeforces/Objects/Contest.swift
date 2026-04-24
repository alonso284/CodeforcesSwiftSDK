//
//  Contest.swift
//  Codeforces
//
//  Codeforces API Object: Represents a Codeforces contest.
//  https://codeforces.com/apiHelp/objects#Contest
//

import Foundation

/// The type of a Codeforces contest.
public enum CFContestType: String, Codable, Sendable {
    case cf = "CF"
    case ioi = "IOI"
    case icpc = "ICPC"
}

/// The phase of a Codeforces contest.
public enum CFContestPhase: String, Codable, Sendable {
    case before = "BEFORE"
    case coding = "CODING"
    case pendingSystemTest = "PENDING_SYSTEM_TEST"
    case systemTest = "SYSTEM_TEST"
    case finished = "FINISHED"
}

/// Represents a Codeforces contest.
public struct CFContest: Codable, Equatable, Sendable {
    /// Contest ID.
    public let id: Int
    /// Contest name.
    public let name: String
    /// Contest type.
    public let type: CFContestType
    /// Current phase.
    public let phase: CFContestPhase
    /// Whether the contest is frozen.
    public let frozen: Bool
    /// Duration of the contest in seconds.
    public let durationSeconds: Int
    /// UNIX timestamp of the contest start. May be absent for unscheduled contests.
    public let startTimeSeconds: Int?
    /// Seconds passed since the start of the contest. Negative if the contest hasn't started yet.
    public let relativeTimeSeconds: Int?
    /// Contest description or short name used in URLs.
    public let preparedBy: String?
    /// URL of the contest website (for external contests).
    public let websiteUrl: String?
    /// Human-readable description.
    public let description: String?
    /// Difficulty rating (1–5 stars).
    public let difficulty: Int?
    /// Kind of the contest (e.g., "official ICPC contest").
    public let kind: String?
    /// ICPC region for regional contests.
    public let icpcRegion: String?
    /// Country of the contest.
    public let country: String?
    /// City of the contest.
    public let city: String?
    /// Season description.
    public let season: String?
}
