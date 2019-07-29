//
//  MockNetworkService.swift
//  DDReaderTests
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

@testable import DDReader
import Foundation
import RxSwift

final class MockNetworkService: NetworkServicing {
    
    var error: Error?
    
    func data(request: URLRequest) -> Observable<Data> {
        if let error = error {
            return .error(error)
        } else {
            let data = try! Data(contentsOf: request.url!)
            return .just(data)
        }
    }
}
