//
//  Member.swift
//  Codeforces
//
//  Codeforces API Object: Represents a member of a party.
//  https://codeforces.com/apiHelp/objects#Member
//

import Foundation

/// Represents a member of a party (team or individual participant).
public struct CFMember: Codable, Equatable, Sendable {
    /// Codeforces handle of the member.
    public let handle: String
    /// Name of the member (only available in ICPC-style contests).
    public let name: String?
}
