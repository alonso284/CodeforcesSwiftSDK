//
//  User.swift
//  Codeforces
//
//  Codeforces API Object: Represents a Codeforces user.
//  https://codeforces.com/apiHelp/objects#User
//

import Foundation

/// Represents a Codeforces user profile.
public struct CFUser: Codable, Equatable, Sendable {
    /// User handle (username).
    public let handle: String
    /// User's email (only visible to authorized requests for the user themselves).
    public let email: String?
    /// Codeforces internal user ID.
    public let vkId: String?
    /// User's OpenID URL.
    public let openId: String?
    /// First name.
    public let firstName: String?
    /// Last name.
    public let lastName: String?
    /// Country name.
    public let country: String?
    /// City name.
    public let city: String?
    /// Organization or university name.
    public let organization: String?
    /// Number of contributions (blog entries, comments, etc.).
    public let contribution: Int
    /// Current rank title (e.g., "expert", "master").
    public let rank: String?
    /// Current rating value.
    public let rating: Int?
    /// Maximum rank title ever achieved.
    public let maxRank: String?
    /// Maximum rating ever achieved.
    public let maxRating: Int?
    /// UNIX timestamp of the last time the user was online.
    public let lastOnlineTimeSeconds: Int
    /// UNIX timestamp of registration.
    public let registrationTimeSeconds: Int
    /// Number of friends.
    public let friendOfCount: Int
    /// URL to the user's avatar.
    public let avatar: String
    /// URL to the user's title photo.
    public let titlePhoto: String
}
