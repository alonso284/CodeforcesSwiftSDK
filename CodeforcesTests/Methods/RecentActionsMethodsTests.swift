//
//  RecentActionsMethodsTests.swift
//  CodeforcesTests
//
//  Live API tests for recentActions.
//

import XCTest
@testable import Codeforces

final class RecentActionsMethodsTests: XCTestCase {
    let client = CodeforcesAPI()

    func testRecentActions() async throws {
        let actions = try await client.recentActions(maxCount: 5)
        XCTAssertLessThanOrEqual(actions.count, 5)
        XCTAssertFalse(actions.isEmpty)
        // Each action should have at least a blog entry or a comment
        for action in actions {
            XCTAssertTrue(action.blogEntry != nil || action.comment != nil)
        }
    }
}
