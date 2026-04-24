//
//  Hack.swift
//  Codeforces
//
//  Codeforces API Object: Represents a hack during a contest.
//  https://codeforces.com/apiHelp/objects#Hack
//

import Foundation

/// The verdict of a hack attempt.
public enum CFHackVerdict: String, Codable, Sendable {
    case hackSuccessful = "HACK_SUCCESSFUL"
    case hackUnsuccessful = "HACK_UNSUCCESSFUL"
    case invalidInput = "INVALID_INPUT"
    case generatorIncompilable = "GENERATOR_INCOMPILABLE"
    case generatorCrashed = "GENERATOR_CRASHED"
    case ignored = "IGNORED"
    case testing = "TESTING"
    case other = "OTHER"
}

/// The judge protocol for a hack.
public struct CFJudgeProtocol: Codable, Equatable, Sendable {
    /// Whether the hack is manual.
    public let manual: Bool
    /// Protocol description.
    public let protocol_: String
    /// Verdict string.
    public let verdict: String

    enum CodingKeys: String, CodingKey {
        case manual
        case protocol_ = "protocol"
        case verdict
    }
}

/// Represents a hack attempt during a Codeforces contest.
public struct CFHack: Codable, Equatable, Sendable {
    /// Hack ID.
    public let id: Int
    /// UNIX timestamp of the hack.
    public let creationTimeSeconds: Int
    /// The hacker party.
    public let hacker: CFParty
    /// The defender party.
    public let defender: CFParty
    /// Verdict of the hack. May be absent while testing.
    public let verdict: CFHackVerdict?
    /// The problem the hack is for.
    public let problem: CFProblem
    /// Test input used for the hack.
    public let test: String?
    /// Judge protocol details.
    public let judgeProtocol: CFJudgeProtocol?
}
