//
//  RecentActionsMethods.swift
//  Codeforces
//
//  API method for recent actions.
//  https://codeforces.com/apiHelp/methods#recentActions
//

import Foundation

extension CodeforcesAPI {

    /// Returns recent actions (new blog entries and comments).
    ///
    /// - Parameter maxCount: Maximum number of recent actions to return (max 100).
    /// - Returns: Array of recent actions.
    /// - Throws: `CFError` on failure.
    public func recentActions(maxCount: Int) async throws -> [CFRecentAction] {
        return try await request(
            method: "recentActions",
            params: ["maxCount": String(maxCount)]
        )
    }
}
