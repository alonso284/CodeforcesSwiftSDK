//
//  Comment.swift
//  Codeforces
//
//  Codeforces API Object: Represents a comment on a blog entry.
//  https://codeforces.com/apiHelp/objects#Comment
//

import Foundation

/// Represents a comment on a Codeforces blog entry.
public struct CFComment: Codable, Equatable, Sendable {
    /// Comment ID.
    public let id: Int
    /// UNIX timestamp of creation.
    public let creationTimeSeconds: Int
    /// Handle of the commenter.
    public let commentatorHandle: String
    /// Locale of the comment.
    public let locale: String
    /// HTML text of the comment.
    public let text: String
    /// ID of the parent comment, or `nil` if top-level.
    public let parentCommentId: Int?
    /// Rating of the comment (sum of votes).
    public let rating: Int
}
