//
//  CommentTests.swift
//  CodeforcesTests
//
//  Tests for CFComment decoding.
//

import XCTest
@testable import Codeforces

final class CommentTests: XCTestCase {

    func testDecodeComment() throws {
        let json = """
        {
            "id": 99999,
            "creationTimeSeconds": 1600000000,
            "commentatorHandle": "tourist",
            "locale": "en",
            "text": "Great post!",
            "parentCommentId": 99998,
            "rating": 10
        }
        """
        let comment = try JSONDecoder().decode(CFComment.self, from: Data(json.utf8))
        XCTAssertEqual(comment.id, 99999)
        XCTAssertEqual(comment.commentatorHandle, "tourist")
        XCTAssertEqual(comment.text, "Great post!")
        XCTAssertEqual(comment.parentCommentId, 99998)
        XCTAssertEqual(comment.rating, 10)
    }

    func testDecodeTopLevelComment() throws {
        let json = """
        {
            "id": 1,
            "creationTimeSeconds": 1600000000,
            "commentatorHandle": "user",
            "locale": "en",
            "text": "First!",
            "rating": -5
        }
        """
        let comment = try JSONDecoder().decode(CFComment.self, from: Data(json.utf8))
        XCTAssertNil(comment.parentCommentId)
        XCTAssertEqual(comment.rating, -5)
    }
}
