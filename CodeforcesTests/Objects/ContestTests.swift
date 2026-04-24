//
//  ContestTests.swift
//  CodeforcesTests
//
//  Tests for CFContest, CFContestType, CFContestPhase decoding.
//

import XCTest
@testable import Codeforces

final class ContestTests: XCTestCase {

    func testDecodeContest() throws {
        let json = """
        {
            "id": 1800,
            "name": "Codeforces Round #900",
            "type": "CF",
            "phase": "FINISHED",
            "frozen": false,
            "durationSeconds": 7200,
            "startTimeSeconds": 1700000000,
            "relativeTimeSeconds": 8000
        }
        """
        let contest = try JSONDecoder().decode(CFContest.self, from: Data(json.utf8))
        XCTAssertEqual(contest.id, 1800)
        XCTAssertEqual(contest.type, .cf)
        XCTAssertEqual(contest.phase, .finished)
        XCTAssertFalse(contest.frozen)
        XCTAssertEqual(contest.durationSeconds, 7200)
    }

    func testDecodeContestPhases() throws {
        let phases = ["BEFORE", "CODING", "PENDING_SYSTEM_TEST", "SYSTEM_TEST", "FINISHED"]
        let expected: [CFContestPhase] = [.before, .coding, .pendingSystemTest, .systemTest, .finished]
        for (json, expected) in zip(phases, expected) {
            let decoded = try JSONDecoder().decode(CFContestPhase.self, from: Data("\"\(json)\"".utf8))
            XCTAssertEqual(decoded, expected)
        }
    }

    func testDecodeContestTypes() throws {
        let types = ["CF", "IOI", "ICPC"]
        let expected: [CFContestType] = [.cf, .ioi, .icpc]
        for (json, expected) in zip(types, expected) {
            let decoded = try JSONDecoder().decode(CFContestType.self, from: Data("\"\(json)\"".utf8))
            XCTAssertEqual(decoded, expected)
        }
    }
}
