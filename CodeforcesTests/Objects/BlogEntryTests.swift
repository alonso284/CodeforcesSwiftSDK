//
//  BlogEntryTests.swift
//  CodeforcesTests
//
//  Tests for CFBlogEntry decoding.
//

import XCTest
@testable import Codeforces

final class BlogEntryTests: XCTestCase {

    func testDecodeBlogEntry() throws {
        let json = """
        {
            "id": 12345,
            "originalLocale": "en",
            "creationTimeSeconds": 1600000000,
            "authorHandle": "tourist",
            "title": "Test Blog",
            "locale": "en",
            "modificationTimeSeconds": 1600001000,
            "allowViewHistory": true,
            "tags": ["dp", "graphs"],
            "rating": 42
        }
        """
        let entry = try JSONDecoder().decode(CFBlogEntry.self, from: Data(json.utf8))
        XCTAssertEqual(entry.id, 12345)
        XCTAssertEqual(entry.authorHandle, "tourist")
        XCTAssertEqual(entry.title, "Test Blog")
        XCTAssertEqual(entry.tags, ["dp", "graphs"])
        XCTAssertEqual(entry.rating, 42)
        XCTAssertNil(entry.content)
        XCTAssertTrue(entry.allowViewHistory)
    }

    func testDecodeBlogEntryWithContent() throws {
        let json = """
        {
            "id": 1,
            "originalLocale": "ru",
            "creationTimeSeconds": 1600000000,
            "authorHandle": "MikeMirzayanov",
            "title": "Hello",
            "content": "<p>Hello world</p>",
            "locale": "ru",
            "modificationTimeSeconds": 1600000000,
            "allowViewHistory": false,
            "tags": [],
            "rating": 100
        }
        """
        let entry = try JSONDecoder().decode(CFBlogEntry.self, from: Data(json.utf8))
        XCTAssertEqual(entry.content, "<p>Hello world</p>")
        XCTAssertFalse(entry.allowViewHistory)
    }
}
