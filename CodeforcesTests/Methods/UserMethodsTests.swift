//
//  UserMethodsTests.swift
//  CodeforcesTests
//
//  Live API tests for user methods.
//

import XCTest
@testable import Codeforces

final class UserMethodsTests: XCTestCase {
    let client = CodeforcesAPI()

    // MARK: - TEMPORARY API CREDENTIALS FOR TESTING
    // These keys are for development testing only and will be removed.
    let authorizedClient = CodeforcesAPI(
        key: "",
        secret: ""
    )

    func testUserInfo() async throws {
        let users = try await client.userInfo(handles: ["tourist"])
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users[0].handle, "tourist")
        XCTAssertNotNil(users[0].rating)
        XCTAssertNotNil(users[0].rank)
    }

    func testUserInfoMultiple() async throws {
        let users = try await client.userInfo(handles: ["tourist", "Petr"])
        XCTAssertEqual(users.count, 2)
        let handles = Set(users.map { $0.handle })
        XCTAssertTrue(handles.contains("tourist"))
        XCTAssertTrue(handles.contains("Petr"))
    }

    func testUserBlogEntries() async throws {
        let entries = try await client.userBlogEntries(handle: "tourist")
        XCTAssertFalse(entries.isEmpty, "tourist should have blog entries")
        XCTAssertEqual(entries[0].authorHandle, "tourist")
    }

    func testUserRating() async throws {
        let changes = try await client.userRating(handle: "tourist")
        XCTAssertFalse(changes.isEmpty, "tourist should have rating history")
        XCTAssertEqual(changes[0].handle, "tourist")
        // Rating changes should be chronologically ordered
        if changes.count >= 2 {
            XCTAssertLessThanOrEqual(
                changes[0].ratingUpdateTimeSeconds,
                changes[1].ratingUpdateTimeSeconds
            )
        }
    }

    func testUserStatus() async throws {
        let submissions = try await client.userStatus(handle: "tourist", from: 1, count: 5)
        XCTAssertLessThanOrEqual(submissions.count, 5)
        XCTAssertFalse(submissions.isEmpty)
    }

    func testUserRatedList() async throws {
        let users = try await client.userRatedList(activeOnly: true)
        XCTAssertFalse(users.isEmpty)
        // Should be sorted by rating descending
        if users.count >= 2 {
            XCTAssertGreaterThanOrEqual(users[0].rating ?? 0, users[1].rating ?? 0)
        }
    }

    func testUserFriends() async throws {
        let friends = try await authorizedClient.userFriends()
        // Just verify it returns without error (may be empty list)
        XCTAssertNotNil(friends)
    }

    func testUserFriendsUnauthorized() async {
        do {
            _ = try await client.userFriends()
            XCTFail("Should throw unauthorized error")
        } catch let error as Codeforces.CFError {
            if case .unauthorized = error {
                // Expected
            } else {
                XCTFail("Expected unauthorized, got \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}
