//
//  SubmissionTests.swift
//  CodeforcesTests
//
//  Tests for CFSubmission, CFVerdict, CFTestset decoding.
//

import XCTest
@testable import Codeforces

final class SubmissionTests: XCTestCase {

    func testDecodeSubmission() throws {
        let json = """
        {
            "id": 123456789,
            "contestId": 1800,
            "creationTimeSeconds": 1700000000,
            "relativeTimeSeconds": 600,
            "problem": {
                "contestId": 1800,
                "index": "A",
                "name": "Two Sum",
                "type": "PROGRAMMING",
                "rating": 800,
                "tags": ["math"]
            },
            "author": {
                "contestId": 1800,
                "members": [{"handle": "tourist"}],
                "participantType": "CONTESTANT",
                "ghost": false,
                "startTimeSeconds": 1700000000
            },
            "programmingLanguage": "GNU C++17",
            "verdict": "OK",
            "testset": "TESTS",
            "passedTestCount": 10,
            "timeConsumedMillis": 15,
            "memoryConsumedBytes": 1024000
        }
        """
        let sub = try JSONDecoder().decode(CFSubmission.self, from: Data(json.utf8))
        XCTAssertEqual(sub.id, 123456789)
        XCTAssertEqual(sub.verdict, .ok)
        XCTAssertEqual(sub.testset, .tests)
        XCTAssertEqual(sub.problem.name, "Two Sum")
        XCTAssertEqual(sub.author.members.first?.handle, "tourist")
    }

    func testDecodeVerdicts() throws {
        let verdicts: [(String, CFVerdict)] = [
            ("OK", .ok), ("WRONG_ANSWER", .wrongAnswer),
            ("TIME_LIMIT_EXCEEDED", .timeLimitExceeded),
            ("COMPILATION_ERROR", .compilationError),
            ("RUNTIME_ERROR", .runtimeError),
            ("TESTING", .testing),
        ]
        for (json, expected) in verdicts {
            let decoded = try JSONDecoder().decode(CFVerdict.self, from: Data("\"\(json)\"".utf8))
            XCTAssertEqual(decoded, expected)
        }
    }
}
