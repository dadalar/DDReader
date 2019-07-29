//
//  PostDetailModelTests.swift
//  DDReaderTests
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

@testable import DDReader
import Foundation
import XCTest

final class PostDetailModelTests: XCTestCase {
    
    func testFormatting() {
        let post = Post(userId: 0,
                        id: 0,
                        title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                        body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        let user = User(id: 0,
                        name: "Deniz Adalar",
                        username: "dadalar")
        let postDetail = PostDetail(post: post, user: user, comments: [])
        
        let detailModel = PostDetailModel(postDetail: postDetail)
        
        XCTAssertEqual(detailModel.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(detailModel.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        XCTAssertEqual(detailModel.commentCountText, "Comments: 0")        
        XCTAssertEqual(detailModel.author.string, "Deniz Adalar\n@dadalar")
    }
    
}

