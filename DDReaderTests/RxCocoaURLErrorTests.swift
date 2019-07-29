//
//  RxCocoaURLErrorTests.swift
//  DDReaderTests
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

@testable import DDReader
import Foundation
import RxCocoa
import XCTest

final class RxCocoaURLErrorTests: XCTestCase {
    
    func testDisplayableError() {
        // Unknown Error
        XCTAssertEqual(RxCocoaURLError.unknown.title, "Error")
        XCTAssertEqual(RxCocoaURLError.unknown.message, "Could not fetch data")

        // Deserialization Error
        enum SomeError: Error {
            case error
        }
        let deserializationError = RxCocoaURLError.deserializationError(error: SomeError.error)
        
        XCTAssertEqual(deserializationError.title, "Error")
        XCTAssertEqual(deserializationError.message, "Could not fetch data")
        
        // Non HTTP Response Error
        let response = URLResponse(url: URL(string: "http://some.url")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let nonHTTPError = RxCocoaURLError.nonHTTPResponse(response: response)
        XCTAssertEqual(nonHTTPError.title, "Error")
        XCTAssertEqual(nonHTTPError.message, "Could not fetch data")
        
        // Request Failed Error
        let httpResponse = HTTPURLResponse(url: URL(string: "http://some.url")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let httpRequestError = RxCocoaURLError.httpRequestFailed(response: httpResponse!, data: nil)
        XCTAssertEqual(httpRequestError.title, "Error")
        XCTAssertEqual(httpRequestError.message, "Bad response (500)")
    }

}
