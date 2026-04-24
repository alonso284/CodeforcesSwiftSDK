//
//  UserMethods.swift
//  Codeforces
//
//  API methods for users.
//  https://codeforces.com/apiHelp/methods#user.blogEntries
//  https://codeforces.com/apiHelp/methods#user.friends
//  https://codeforces.com/apiHelp/methods#user.info
//  https://codeforces.com/apiHelp/methods#user.ratedList
//  https://codeforces.com/apiHelp/methods#user.rating
//  https://codeforces.com/apiHelp/methods#user.status
//

import Foundation

extension CodeforcesAPI {

    /// Returns a list of blog entries written by the specified user.
    ///
    /// - Parameter handle: Codeforces handle of the user.
    /// - Returns: Array of blog entries in reverse chronological order.
    /// - Throws: `CFError` on failure.
    public func userBlogEntries(handle: String) async throws -> [CFBlogEntry] {
        return try await request(
            method: "user.blogEntries",
            params: ["handle": handle]
        )
    }

    /// Returns a list of the authorized user's friends.
    ///
    /// **Requires authorization.**
    ///
    /// - Parameter onlyOnline: If `true`, only returns friends who are currently online.
    /// - Returns: Array of friend handles.
    /// - Throws: `CFError` on failure or if not authorized.
    public func userFriends(onlyOnline: Bool = false) async throws -> [String] {
        var params: [String: String] = [:]
        if onlyOnline { params["onlyOnline"] = "true" }
        return try await request(
            method: "user.friends",
            params: params,
            authorized: true
        )
    }

    /// Returns information about one or more users.
    ///
    /// - Parameter handles: Array of handles to look up (max 10000).
    /// - Returns: Array of user objects.
    /// - Throws: `CFError` on failure.
    public func userInfo(handles: [String]) async throws -> [CFUser] {
        return try await request(
            method: "user.info",
            params: ["handles": handles.joined(separator: ";")]
        )
    }

    /// Returns a list of all rated users.
    ///
    /// - Parameters:
    ///   - activeOnly: If `true`, only users who participated in a rated contest in the last month.
    ///   - includeRetired: If `true`, include retired users (those who have not participated recently).
    /// - Returns: Array of users sorted by rating in decreasing order.
    /// - Throws: `CFError` on failure.
    public func userRatedList(
        activeOnly: Bool = false,
        includeRetired: Bool? = nil
    ) async throws -> [CFUser] {
        var params: [String: String] = [:]
        if activeOnly { params["activeOnly"] = "true" }
        if let includeRetired = includeRetired { params["includeRetired"] = String(includeRetired) }
        return try await request(method: "user.ratedList", params: params)
    }

    /// Returns the rating history of the specified user.
    ///
    /// - Parameter handle: Codeforces handle of the user.
    /// - Returns: Array of rating changes sorted by contest time.
    /// - Throws: `CFError` on failure.
    public func userRating(handle: String) async throws -> [CFRatingChange] {
        return try await request(
            method: "user.rating",
            params: ["handle": handle]
        )
    }

    /// Returns submissions by the specified user.
    ///
    /// - Parameters:
    ///   - handle: Codeforces handle of the user.
    ///   - from: 1-based index of the first submission to return.
    ///   - count: Number of submissions to return.
    /// - Returns: Array of submissions sorted by ID in decreasing order.
    /// - Throws: `CFError` on failure.
    public func userStatus(
        handle: String,
        from: Int? = nil,
        count: Int? = nil
    ) async throws -> [CFSubmission] {
        var params: [String: String] = ["handle": handle]
        if let from = from { params["from"] = String(from) }
        if let count = count { params["count"] = String(count) }
        return try await request(
            method: "user.status",
            params: params
        )
    }
}
