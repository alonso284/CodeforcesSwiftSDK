//
//  RatingChange.swift
//  Codeforces
//
//  Codeforces API Object: Represents a rating change after a contest.
//  https://codeforces.com/apiHelp/objects#RatingChange
//

import Foundation

/// Represents a rating change for a user after a contest.
public struct CFRatingChange: Codable, Equatable, Sendable {
    /// Contest ID.
    public let contestId: Int
    /// Contest name.
    public let contestName: String
    /// Handle of the user.
    public let handle: String
    /// Rank in the contest.
    public let rank: Int
    /// UNIX timestamp of the rating update.
    public let ratingUpdateTimeSeconds: Int
    /// Rating before the contest.
    public let oldRating: Int
    /// Rating after the contest.
    public let newRating: Int
}
