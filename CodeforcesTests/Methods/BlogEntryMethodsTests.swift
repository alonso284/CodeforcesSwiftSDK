//
//  BlogEntryMethodsTests.swift
//  CodeforcesTests
//
//  Live API tests for blogEntry methods.
//

import XCTest
@testable import Codeforces

final class BlogEntryMethodsTests: XCTestCase {
    let client = CodeforcesAPI()

    func testBlogEntryComments() async throws {
        // Blog entry 79 is a well-known early blog post
        let comments = try await client.blogEntryComments(blogEntryId: 79)
        XCTAssertFalse(comments.isEmpty, "Expected at least one comment")
        let first = comments.first!
        XCTAssertFalse(first.commentatorHandle.isEmpty)
        XCTAssertGreaterThan(first.id, 0)
    }

    func testBlogEntryView() async throws {
        let entry = try await client.blogEntryView(blogEntryId: 79)
        XCTAssertEqual(entry.id, 79)
        XCTAssertFalse(entry.authorHandle.isEmpty)
        XCTAssertFalse(entry.title.isEmpty)
    }
}
