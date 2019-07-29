//
//  ManagedDataServiceTests.swift
//  DDReaderTests
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

@testable import DDReader
import Foundation
import RxCocoa
import XCTest
import RxSwift
import RxBlocking

final class MockPostsService: PostsServicing {
    func getPosts() -> Single<PostsResponse> {
        return .just([
            Post(userId: 99, id: 1, title: "title", body: "body")
        ])
    }
}

final class MockUsersService: UsersServicing {
    func getUsers() -> Single<UsersResponse> {
        return .just([
            User(id: 99, name: "Deniz Adalar", username: "dadalar")
        ])
    }
}

final class MockCommentsService: CommentsServicing {
    func getComments() -> Single<CommentsResponse> {
        return .just([
            Comment(postId: 1, id: 5, name: "Commentor", email: "me@dadalar.net", body: "comment body")
        ])
    }
}

final class MockCacheService: CacheServicing {
    enum MockCacheServiceError: Error {
        case notFound
    }
    
    var memory: [CacheServicingCacheKey: Data] = [:]
    
    func save(_ key: CacheServicingCacheKey, data: Data) throws {
        memory[key] = data
    }
    
    func read(_ key: CacheServicingCacheKey) throws -> Data {
        guard let value = memory[key] else { throw MockCacheServiceError.notFound }
        return value
    }
}

final class ManagedDataServiceTests: XCTestCase {
    
    let networkService = MockNetworkService()
    let disposeBag = DisposeBag()
    
    func testHappyPath() {
        let managedDataService = ManagedDataService(postsService: MockPostsService(),
                                                    usersService: MockUsersService(),
                                                    commentsService: MockCommentsService(),
                                                    cacheService: MockCacheService())
        
        let posts = try! managedDataService.getPosts().toBlocking().single()
        XCTAssertEqual(posts, CachedPostsResponse(isCached: false, posts: [
            Post(userId: 99, id: 1, title: "title", body: "body")
        ]))
        
        let details = try! managedDataService.getDetails(for: 1).toBlocking().single()
        XCTAssertEqual(details, PostDetail(post: Post(userId: 99, id: 1, title: "title", body: "body"),
                                           user: User(id: 99, name: "Deniz Adalar", username: "dadalar"),
                                           comments: [Comment(postId: 1, id: 5, name: "Commentor", email: "me@dadalar.net", body: "comment body")]))
    }
    
}

