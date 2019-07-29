//
//  CommentsServiceTests.swift
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

final class CommentsServiceTests: XCTestCase {
    
    let networkService = MockNetworkService()
    let disposeBag = DisposeBag()
    
    func testWithCorrectData() {
        let bundle = Bundle(for: CommentsServiceTests.self)
        let baseURL = bundle.resourceURL!
        let service = CommentsService(baseURL: baseURL,
                                      networkService: networkService)
        
        let response = try? service.getComments().toBlocking().single()
        XCTAssertEqual(response?.count, 500)
    }
    
}



