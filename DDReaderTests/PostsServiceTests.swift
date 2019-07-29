//
//  PostsServiceTests.swift
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

final class PostsServiceTests: XCTestCase {

    let networkService = MockNetworkService()
    let disposeBag = DisposeBag()

    override func setUp() {
        networkService.error = nil
    }
    
    func testWithCorrectData() {
        let bundle = Bundle(for: PostsServiceTests.self)
        let baseURL = bundle.resourceURL!
        let service = PostsService(baseURL: baseURL,
                                   networkService: networkService)
        
        let response = try? service.getPosts().toBlocking().single()
        XCTAssertEqual(response?.count, 100)
    }
    
    func testFetchError() {
        enum FetchError: Error {
            case someError
        }
        networkService.error = FetchError.someError
        let bundle = Bundle(for: PostsServiceTests.self)
        let baseURL = bundle.resourceURL!
        let service = PostsService(baseURL: baseURL,
                                   networkService: networkService)
        
        var response: PostsResponse?
        do {
            response = try service.getPosts().toBlocking().single()
        } catch {
            if case FetchError.someError = error {
                
            } else {
                XCTFail()
            }
        }
        XCTAssertNil(response)
    }
    
}
