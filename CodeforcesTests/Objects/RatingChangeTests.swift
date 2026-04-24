//
//  RatingChangeTests.swift
//  CodeforcesTests
//
//  Tests for CFRatingChange decoding.
//

import XCTest
@testable import Codeforces

final class RatingChangeTests: XCTestCase {

    func testDecodeRatingChange() throws {
        let json = """
        {
            "contestId": 1800,
            "contestName": "Codeforces Round #900",
            "handle": "tourist",
            "rank": 1,
            "ratingUpdateTimeSeconds": 1700010000,
            "oldRating": 3700,
            "newRating": 3800
        }
        """
        let change = try JSONDecoder().decode(CFRatingChange.self, from: Data(json.utf8))
        XCTAssertEqual(change.contestId, 1800)
        XCTAssertEqual(change.handle, "tourist")
        XCTAssertEqual(change.rank, 1)
        XCTAssertEqual(change.oldRating, 3700)
        XCTAssertEqual(change.newRating, 3800)
    }
}
