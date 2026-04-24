//
//  RanklistRowTests.swift
//  CodeforcesTests
//
//  Tests for CFRanklistRow, CFProblemResult decoding.
//

import XCTest
@testable import Codeforces

final class RanklistRowTests: XCTestCase {

    func testDecodeRanklistRow() throws {
        let json = """
        {
            "party": {
                "contestId": 1800,
                "members": [{"handle": "tourist"}],
                "participantType": "CONTESTANT",
                "ghost": false,
                "startTimeSeconds": 1700000000
            },
            "rank": 1,
            "points": 6000.0,
            "penalty": 0,
            "successfulHackCount": 3,
            "unsuccessfulHackCount": 0,
            "problemResults": [
                {
                    "points": 500.0,
                    "rejectedAttemptCount": 0,
                    "type": "FINAL",
                    "bestSubmissionTimeSeconds": 120
                },
                {
                    "points": 0.0,
                    "rejectedAttemptCount": 2,
                    "type": "FINAL"
                }
            ]
        }
        """
        let row = try JSONDecoder().decode(CFRanklistRow.self, from: Data(json.utf8))
        XCTAssertEqual(row.rank, 1)
        XCTAssertEqual(row.points, 6000.0)
        XCTAssertEqual(row.successfulHackCount, 3)
        XCTAssertEqual(row.problemResults.count, 2)
        XCTAssertEqual(row.problemResults[0].points, 500.0)
        XCTAssertEqual(row.problemResults[0].type, .final_)
        XCTAssertEqual(row.problemResults[0].bestSubmissionTimeSeconds, 120)
        XCTAssertNil(row.problemResults[1].bestSubmissionTimeSeconds)
    }
}
