//
//  ContestMethods.swift
//  Codeforces
//
//  API methods for contests.
//  https://codeforces.com/apiHelp/methods#contest.hacks
//  https://codeforces.com/apiHelp/methods#contest.list
//  https://codeforces.com/apiHelp/methods#contest.ratingChanges
//  https://codeforces.com/apiHelp/methods#contest.standings
//  https://codeforces.com/apiHelp/methods#contest.status
//

import Foundation

/// The response from `contest.standings`, containing the contest, problems, and ranked rows.
public struct CFStandings: Decodable, Sendable {
    public let contest: CFContest
    public let problems: [CFProblem]
    public let rows: [CFRanklistRow]
}

extension CodeforcesAPI {

    /// Returns a list of hacks in the specified contest.
    ///
    /// - Parameters:
    ///   - contestId: ID of the contest.
    ///   - asManager: If `true`, the request is made as a contest manager (requires authorization).
    /// - Returns: Array of hacks.
    /// - Throws: `CFError` on failure.
    public func contestHacks(contestId: Int, asManager: Bool = false) async throws -> [CFHack] {
        var params: [String: String] = ["contestId": String(contestId)]
        if asManager { params["asManager"] = "true" }
        return try await request(
            method: "contest.hacks",
            params: params,
            authorized: asManager
        )
    }

    /// Returns a list of all past and upcoming contests.
    ///
    /// - Parameter gym: If `true`, returns gym contests instead of regular contests.
    /// - Returns: Array of contests sorted by start time in decreasing order.
    /// - Throws: `CFError` on failure.
    public func contestList(gym: Bool = false) async throws -> [CFContest] {
        var params: [String: String] = [:]
        if gym { params["gym"] = "true" }
        return try await request(method: "contest.list", params: params)
    }

    /// Returns rating changes after a contest.
    ///
    /// - Parameter contestId: ID of the contest.
    /// - Returns: Array of rating changes sorted by user rank.
    /// - Throws: `CFError` on failure.
    public func contestRatingChanges(contestId: Int) async throws -> [CFRatingChange] {
        return try await request(
            method: "contest.ratingChanges",
            params: ["contestId": String(contestId)]
        )
    }

    /// Returns the contest standings (ranklist).
    ///
    /// - Parameters:
    ///   - contestId: ID of the contest.
    ///   - asManager: If `true`, requests as contest manager (requires authorization).
    ///   - from: 1-based index of the first standing row to return.
    ///   - count: Number of standing rows to return.
    ///   - handles: List of handles to filter; only these users will appear in the standings.
    ///   - room: Room number to filter results by.
    ///   - showUnofficial: If `true`, include unofficial participants.
    /// - Returns: A `CFStandings` object containing the contest, problems, and rows.
    /// - Throws: `CFError` on failure.
    public func contestStandings(
        contestId: Int,
        asManager: Bool = false,
        from: Int? = nil,
        count: Int? = nil,
        handles: [String]? = nil,
        room: Int? = nil,
        showUnofficial: Bool? = nil
    ) async throws -> CFStandings {
        var params: [String: String] = ["contestId": String(contestId)]
        if asManager { params["asManager"] = "true" }
        if let from = from { params["from"] = String(from) }
        if let count = count { params["count"] = String(count) }
        if let handles = handles { params["handles"] = handles.joined(separator: ";") }
        if let room = room { params["room"] = String(room) }
        if let showUnofficial = showUnofficial { params["showUnofficial"] = String(showUnofficial) }
        return try await request(
            method: "contest.standings",
            params: params,
            authorized: asManager
        )
    }

    /// Returns submissions for a contest.
    ///
    /// - Parameters:
    ///   - contestId: ID of the contest.
    ///   - asManager: If `true`, requests as contest manager (requires authorization).
    ///   - handle: Handle of the user to filter submissions by.
    ///   - from: 1-based index of the first submission to return.
    ///   - count: Number of submissions to return.
    /// - Returns: Array of submissions sorted by ID in decreasing order.
    /// - Throws: `CFError` on failure.
    public func contestStatus(
        contestId: Int,
        asManager: Bool = false,
        handle: String? = nil,
        from: Int? = nil,
        count: Int? = nil
    ) async throws -> [CFSubmission] {
        var params: [String: String] = ["contestId": String(contestId)]
        if asManager { params["asManager"] = "true" }
        if let handle = handle { params["handle"] = handle }
        if let from = from { params["from"] = String(from) }
        if let count = count { params["count"] = String(count) }
        return try await request(
            method: "contest.status",
            params: params,
            authorized: asManager
        )
    }
}
