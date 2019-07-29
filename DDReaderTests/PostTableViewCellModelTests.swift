//
//  PostTableViewCellTests.swift
//  DDReaderTests
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

@testable import DDReader
import Foundation
import XCTest

final class PostTableViewCellModelTests: XCTestCase {

    func testFormatting() {
        let post = Post(userId: 0,
                        id: 0,
                        title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                        body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        
        let cellModel = PostTableViewCellModel(post: post)
        
        XCTAssertEqual(cellModel.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(cellModel.subtitle, "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto")
    }
    
}
