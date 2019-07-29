//
//  CacheServiceTests.swift
//  DDReaderTests
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

@testable import DDReader
import Foundation
import XCTest

final class CacheServiceTests: XCTestCase {
    
    func testSavingAndReading() {
        let commentsData = "comments".data(using: .utf8)!
        let postsData = "posts".data(using: .utf8)!
        let usersData = "users".data(using: .utf8)!
        
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let service = DiskCacheService(cacheFolderURL: tempURL)
        try? service.save(.comments, data: commentsData)
        try? service.save(.posts, data: postsData)
        try? service.save(.users, data: usersData)
        
        let readCommentsData = try? service.read(.comments)
        let readPostsData = try? service.read(.posts)
        let readUsersData = try? service.read(.users)
        
        XCTAssertEqual(readPostsData, postsData)
        XCTAssertEqual(readCommentsData, commentsData)
        XCTAssertEqual(readUsersData, usersData)
    }
    
    func testSavingAndReadingCodable() {
        struct TestStruct: Codable, Equatable {
            let key: String
        }
        let testStruct = TestStruct(key: "value")
        
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let service = DiskCacheService(cacheFolderURL: tempURL)
        try? service.save(.posts, value: testStruct)
        
        let readTestStruct: TestStruct? = try? service.read(.posts)
        XCTAssertEqual(readTestStruct, testStruct)
    }
}
