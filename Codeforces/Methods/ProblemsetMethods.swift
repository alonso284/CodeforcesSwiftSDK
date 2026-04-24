//
//  ProblemsetMethods.swift
//  Codeforces
//
//  API methods for the problemset.
//  https://codeforces.com/apiHelp/methods#problemset.problems
//  https://codeforces.com/apiHelp/methods#problemset.recentStatus
//

import Foundation

/// The response from `problemset.problems`, containing problems and their statistics.
public struct CFProblemset: Decodable, Sendable {
    public let problems: [CFProblem]
    public let problemStatistics: [CFProblemStatistics]
}

extension CodeforcesAPI {

    /// Returns all problems from the problemset.
    ///
    /// - Parameters:
    ///   - tags: List of tags to filter problems by. Only problems matching all tags are returned.
    ///   - problemsetName: Custom problemset short name (e.g., "acmsguru").
    /// - Returns: A `CFProblemset` containing problems and their statistics.
    /// - Throws: `CFError` on failure.
    public func problemsetProblems(
        tags: [String]? = nil,
        problemsetName: String? = nil
    ) async throws -> CFProblemset {
        var params: [String: String] = [:]
        if let tags = tags { params["tags"] = tags.joined(separator: ";") }
        if let name = problemsetName { params["problemsetName"] = name }
        return try await request(method: "problemset.problems", params: params)
    }

    /// Returns recent submissions.
    ///
    /// - Parameters:
    ///   - count: Number of submissions to return (max 1000).
    ///   - problemsetName: Custom problemset short name (e.g., "acmsguru").
    /// - Returns: Array of recent submissions.
    /// - Throws: `CFError` on failure.
    public func problemsetRecentStatus(
        count: Int,
        problemsetName: String? = nil
    ) async throws -> [CFSubmission] {
        var params: [String: String] = ["count": String(count)]
        if let name = problemsetName { params["problemsetName"] = name }
        return try await request(method: "problemset.recentStatus", params: params)
    }
}
