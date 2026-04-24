//
//  ContestMethodsTests.swift
//  CodeforcesTests
//
//  Live API tests for contest methods.
//

import XCTest
@testable import Codeforces

final class ContestMethodsTests: XCTestCase {
    let client = CodeforcesAPI()

    // MARK: - TEMPORARY API CREDENTIALS FOR TESTING
    // These keys are for development testing only and will be removed.
    let authorizedClient = CodeforcesAPI(
        key: "6055269e4f1d39990080b68ba9c42ce1c25a423a",
        secret: "f1399924329a8fb70149cf5d8b9d91eec84112f0"
    )

    func testContestList() async throws {
        let contests = try await client.contestList()
        XCTAssertFalse(contests.isEmpty, "Expected at least one contest")
        // Check that a known old contest exists
        let hasOldContest = contests.contains { $0.id == 1 }
        XCTAssertTrue(hasOldContest, "Contest #1 should exist")
    }

    func testContestListGym() async throws {
        let gyms = try await client.contestList(gym: true)
        // Gym contests may or may not be empty, but should not throw
        XCTAssertNotNil(gyms)
    }

    func testContestRatingChanges() async throws {
        // Contest 1 (Codeforces Beta Round #1) has rating changes
        let changes = try await client.contestRatingChanges(contestId: 1)
        XCTAssertFalse(changes.isEmpty, "Expected rating changes for contest #1")
        XCTAssertEqual(changes.first?.contestId, 1)
    }

    func testContestStandings() async throws {
        // contest.standings requires auth for gym/mashup contests
        let standings = try await authorizedClient.contestStandings(
            contestId: 100001, from: 1, count: 5
        )
        XCTAssertEqual(standings.contest.id, 100001)
        XCTAssertFalse(standings.problems.isEmpty)
        XCTAssertLessThanOrEqual(standings.rows.count, 5)
    }

    func testContestStandingsWithHandles() async throws {
        let standings = try await authorizedClient.contestStandings(
            contestId: 100001, handles: ["tourist"]
        )
        XCTAssertEqual(standings.contest.id, 100001)
    }

    func testContestStatus() async throws {
        let submissions = try await client.contestStatus(contestId: 1, from: 1, count: 5)
        XCTAssertLessThanOrEqual(submissions.count, 5)
        if let first = submissions.first {
            XCTAssertEqual(first.contestId, 1)
        }
    }

    func testContestHacks() async throws {
        // Contest 1 may have hacks; should not throw
        let hacks = try await client.contestHacks(contestId: 1)
        XCTAssertNotNil(hacks)
    }
}
