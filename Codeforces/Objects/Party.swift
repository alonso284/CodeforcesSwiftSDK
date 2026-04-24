//
//  Party.swift
//  Codeforces
//
//  Codeforces API Object: Represents a party (contestant or team) in a contest.
//  https://codeforces.com/apiHelp/objects#Party
//

import Foundation

/// The type of participant in a contest.
public enum CFParticipantType: String, Codable, Sendable {
    case contestant = "CONTESTANT"
    case practice = "PRACTICE"
    case virtual = "VIRTUAL"
    case manager = "MANAGER"
    case outOfCompetition = "OUT_OF_COMPETITION"
}

/// Represents a party (individual or team) participating in a contest.
public struct CFParty: Codable, Equatable, Sendable {
    /// Contest ID. May be absent.
    public let contestId: Int?
    /// Members of the party.
    public let members: [CFMember]
    /// Participation type.
    public let participantType: CFParticipantType
    /// Team ID, if the party is a team. Otherwise absent.
    public let teamId: Int?
    /// Team name, if the party is a team. Otherwise absent.
    public let teamName: String?
    /// Whether this party is a ghost (e.g., added for upsolving).
    public let ghost: Bool
    /// Room number, if applicable.
    public let room: Int?
    /// UNIX timestamp of contest start for this party (may differ for virtual participants).
    public let startTimeSeconds: Int?
}
