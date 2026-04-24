//
//  HackTests.swift
//  CodeforcesTests
//
//  Tests for CFHack and related types decoding.
//

import XCTest
@testable import Codeforces

final class HackTests: XCTestCase {

    func testDecodeHack() throws {
        let json = """
        {
            "id": 777,
            "creationTimeSeconds": 1700000000,
            "hacker": {
                "contestId": 1800,
                "members": [{"handle": "hacker_user"}],
                "participantType": "CONTESTANT",
                "ghost": false,
                "startTimeSeconds": 1700000000
            },
            "defender": {
                "contestId": 1800,
                "members": [{"handle": "defender_user"}],
                "participantType": "CONTESTANT",
                "ghost": false,
                "startTimeSeconds": 1700000000
            },
            "verdict": "HACK_SUCCESSFUL",
            "problem": {
                "contestId": 1800,
                "index": "B",
                "name": "Palindrome",
                "type": "PROGRAMMING",
                "tags": ["strings"]
            }
        }
        """
        let hack = try JSONDecoder().decode(CFHack.self, from: Data(json.utf8))
        XCTAssertEqual(hack.id, 777)
        XCTAssertEqual(hack.verdict, .hackSuccessful)
        XCTAssertEqual(hack.hacker.members.first?.handle, "hacker_user")
        XCTAssertEqual(hack.defender.members.first?.handle, "defender_user")
        XCTAssertEqual(hack.problem.index, "B")
        XCTAssertNil(hack.test)
    }

    func testDecodeHackVerdicts() throws {
        let verdicts: [(String, CFHackVerdict)] = [
            ("HACK_SUCCESSFUL", .hackSuccessful),
            ("HACK_UNSUCCESSFUL", .hackUnsuccessful),
            ("INVALID_INPUT", .invalidInput),
            ("TESTING", .testing),
        ]
        for (json, expected) in verdicts {
            let decoded = try JSONDecoder().decode(CFHackVerdict.self, from: Data("\"\(json)\"".utf8))
            XCTAssertEqual(decoded, expected)
        }
    }
}
