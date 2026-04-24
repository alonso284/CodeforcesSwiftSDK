//
//  ProblemsetMethodsTests.swift
//  CodeforcesTests
//
//  Live API tests for problemset methods.
//

import XCTest
@testable import Codeforces

final class ProblemsetMethodsTests: XCTestCase {
    let client = CodeforcesAPI()

    func testProblemsetProblems() async throws {
        let result = try await client.problemsetProblems()
        XCTAssertFalse(result.problems.isEmpty, "Expected at least one problem")
        XCTAssertFalse(result.problemStatistics.isEmpty, "Expected at least one stat")
    }

    func testProblemsetProblemsWithTags() async throws {
        let result = try await client.problemsetProblems(tags: ["dp"])
        XCTAssertFalse(result.problems.isEmpty, "Expected DP problems")
        // All returned problems should have the "dp" tag
        for problem in result.problems {
            XCTAssertTrue(problem.tags.contains("dp"), "\(problem.name) missing dp tag")
        }
    }

    func testProblemsetRecentStatus() async throws {
        let submissions = try await client.problemsetRecentStatus(count: 10)
        XCTAssertLessThanOrEqual(submissions.count, 10)
        XCTAssertFalse(submissions.isEmpty)
    }
}
