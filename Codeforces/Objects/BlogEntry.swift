//
//  BlogEntry.swift
//  Codeforces
//
//  Codeforces API Object: Represents a blog entry.
//  https://codeforces.com/apiHelp/objects#BlogEntry
//

import Foundation

/// Represents a Codeforces blog entry.
public struct CFBlogEntry: Codable, Equatable, Sendable {
    /// Blog entry ID.
    public let id: Int
    /// Original locale of the blog entry.
    public let originalLocale: String
    /// UNIX timestamp of creation.
    public let creationTimeSeconds: Int
    /// Handle of the author.
    public let authorHandle: String
    /// Title of the blog entry.
    public let title: String
    /// HTML content of the blog entry. Only available from `blogEntry.view`.
    public let content: String?
    /// Locale of the blog entry.
    public let locale: String
    /// UNIX timestamp of last modification.
    public let modificationTimeSeconds: Int
    /// Whether modification is allowed.
    public let allowViewHistory: Bool
    /// Tags associated with the blog entry.
    public let tags: [String]
    /// Rating of the blog entry (sum of votes).
    public let rating: Int
}
