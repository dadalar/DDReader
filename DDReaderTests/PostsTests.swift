//
//  PostsTests.swift
//  DDReaderTests
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

@testable import DDReader
import XCTest
import RxSwift
import RxTest

final class MockManagedDataService: ManagedDataServicing {
    var error: Error?
    
    func getPosts() -> Single<CachedPostsResponse> {
        if let error = error {
            return .error(error)
        } else {
            let response = CachedPostsResponse(isCached: false, posts: [
                Post(userId: 0, id: 0, title: "Test title", body: "Test body")
            ])
            return .just(response)
        }
    }
    func getDetails(for postId: UInt64) -> Single<PostDetail> {
        fatalError("Not implemented")
    }
}

final class PostsTests: XCTestCase {
    
    var service = MockManagedDataService()
    var viewModel: PostsViewModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        service.error = nil
        viewModel = PostsViewModel(managedDataService: service)
        disposeBag = DisposeBag()
    }
    
    func testSuccessfulLoad() {
        let scheduler = TestScheduler(initialClock: 0)
        let isLoadingResult = scheduler.createObserver(Bool.self)
        let errorResult = scheduler.createObserver(Error.self)
        let postsResult = scheduler.createObserver(CachedPostsResponse.self)
        viewModel.isLoading.bind(to: isLoadingResult).disposed(by: disposeBag)
        viewModel.error.bind(to: errorResult).disposed(by: disposeBag)
        viewModel.posts.bind(to: postsResult).disposed(by: disposeBag)
        
        viewModel.needsUpdate.accept(()) // Trigger update
        
        // Test loading
        XCTAssertEqual(isLoadingResult.events, Recorded.events([
            Recorded.next(0, true), // Started loading
            Recorded.next(0, false) // Finished loading
        ]))

        // Test error
        XCTAssertEqual(errorResult.events.count, 0) // No error returned
        
        // Test data
        XCTAssertEqual(postsResult.events, Recorded.events([
            Recorded.next(0,
                CachedPostsResponse(isCached: false, posts: [
                    Post(userId: 0, id: 0, title: "Test title", body: "Test body")
                ])
            )
        ]))
    }
    
    func testError() {
        enum TestError: Error {
            case someError
        }
        
        service.error = TestError.someError
        
        let scheduler = TestScheduler(initialClock: 0)
        let isLoadingResult = scheduler.createObserver(Bool.self)
        let errorResult = scheduler.createObserver(Error.self)
        let postsResult = scheduler.createObserver(CachedPostsResponse.self)
        viewModel.isLoading.bind(to: isLoadingResult).disposed(by: disposeBag)
        viewModel.error.bind(to: errorResult).disposed(by: disposeBag)
        viewModel.posts.bind(to: postsResult).disposed(by: disposeBag)
        
        viewModel.needsUpdate.accept(()) // Trigger update
        
        // Test loading
        XCTAssertEqual(isLoadingResult.events, Recorded.events([
            Recorded.next(0, true), // Started loading
            Recorded.next(0, false) // Finished loading
            ]))
        
        // Test error
        XCTAssertEqual(errorResult.events.count, 1)
        XCTAssert(errorResult.events.first?.value.element is TestError)
        
        // Test data
        XCTAssertEqual(postsResult.events.count, 0)
    }
    
}
