//
//  UserTests.swift
//  CodeforcesTests
//
//  Tests for CFUser decoding.
//

import XCTest
@testable import Codeforces

final class UserTests: XCTestCase {

    func testDecodeUser() throws {
        let json = """
        {
            "handle": "tourist",
            "email": null,
            "vkId": null,
            "openId": null,
            "firstName": "Gennady",
            "lastName": "Korotkevich",
            "country": "Belarus",
            "city": "Gomel",
            "organization": "ITMO University",
            "contribution": 150,
            "rank": "legendary grandmaster",
            "rating": 3800,
            "maxRank": "legendary grandmaster",
            "maxRating": 3979,
            "lastOnlineTimeSeconds": 1700000000,
            "registrationTimeSeconds": 1300000000,
            "friendOfCount": 50000,
            "avatar": "https://userpic.codeforces.org/422/avatar/abc.jpg",
            "titlePhoto": "https://userpic.codeforces.org/422/title/abc.jpg"
        }
        """
        let user = try JSONDecoder().decode(CFUser.self, from: Data(json.utf8))
        XCTAssertEqual(user.handle, "tourist")
        XCTAssertEqual(user.firstName, "Gennady")
        XCTAssertEqual(user.lastName, "Korotkevich")
        XCTAssertEqual(user.country, "Belarus")
        XCTAssertEqual(user.rank, "legendary grandmaster")
        XCTAssertEqual(user.rating, 3800)
        XCTAssertEqual(user.maxRating, 3979)
        XCTAssertEqual(user.contribution, 150)
        XCTAssertEqual(user.friendOfCount, 50000)
    }

    func testDecodeUserMinimalFields() throws {
        let json = """
        {
            "handle": "newuser",
            "contribution": 0,
            "lastOnlineTimeSeconds": 1700000000,
            "registrationTimeSeconds": 1700000000,
            "friendOfCount": 0,
            "avatar": "https://example.com/avatar.jpg",
            "titlePhoto": "https://example.com/title.jpg"
        }
        """
        let user = try JSONDecoder().decode(CFUser.self, from: Data(json.utf8))
        XCTAssertEqual(user.handle, "newuser")
        XCTAssertNil(user.rating)
        XCTAssertNil(user.rank)
        XCTAssertNil(user.firstName)
    }
}
