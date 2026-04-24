//
//  RecentAction.swift
//  Codeforces
//
//  Codeforces API Object: Represents a recent action on Codeforces.
//  https://codeforces.com/apiHelp/objects#RecentAction
//

import Foundation

/// Represents a recent action (new blog entry or comment).
public struct CFRecentAction: Codable, Equatable, Sendable {
    /// UNIX timestamp of the action.
    public let timeSeconds: Int
    /// Related blog entry. Always present.
    public let blogEntry: CFBlogEntry?
    /// Related comment. Present only if the action is a new comment.
    public let comment: CFComment?
}
