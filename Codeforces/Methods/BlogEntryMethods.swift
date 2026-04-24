//
//  BlogEntryMethods.swift
//  Codeforces
//
//  API methods for blog entries.
//  https://codeforces.com/apiHelp/methods#blogEntry.comments
//  https://codeforces.com/apiHelp/methods#blogEntry.view
//

import Foundation

extension CodeforcesAPI {

    /// Returns a list of comments to the specified blog entry.
    ///
    /// - Parameter blogEntryId: ID of the blog entry.
    /// - Returns: Array of comments.
    /// - Throws: `CFError` on failure.
    public func blogEntryComments(blogEntryId: Int) async throws -> [CFComment] {
        return try await request(
            method: "blogEntry.comments",
            params: ["blogEntryId": String(blogEntryId)]
        )
    }

    /// Returns a blog entry.
    ///
    /// - Parameter blogEntryId: ID of the blog entry.
    /// - Returns: The full blog entry with content.
    /// - Throws: `CFError` on failure.
    public func blogEntryView(blogEntryId: Int) async throws -> CFBlogEntry {
        return try await request(
            method: "blogEntry.view",
            params: ["blogEntryId": String(blogEntryId)]
        )
    }
}
