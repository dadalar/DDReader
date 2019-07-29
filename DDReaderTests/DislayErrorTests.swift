//
//  DislayErrorTests.swift
//  DDReaderTests
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

@testable import DDReader
import Foundation
import XCTest

final class MockPresenter: Presenter {
    func show(_ vc: UIViewController, sender: Any?) {
        fatalError()
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        guard let alertController = viewControllerToPresent as? UIAlertController  else {
            return
        }
        
        displayedTitle = alertController.title
        displayedMessage = alertController.message
    }
    
    var displayedTitle: String?
    var displayedMessage: String?
}

final class DisplayErrorTests: XCTestCase {

    func testDisplayableErrorWithDefaultTitle() {
        enum TestError: Error, DisplayableError {
            case someError
            
            var message: String {
                return "some error message"
            }
        }
        
        let presenter = MockPresenter()
        presenter.showErrorBinder().onNext(TestError.someError)
        
        XCTAssertEqual(presenter.displayedTitle, "Error")
        XCTAssertEqual(presenter.displayedMessage, "some error message")
    }
    
    func testDisplayableErrorWithCustomTitle() {
        enum TestError: Error, DisplayableError {
            case someError
            
            var title: String? {
                return "some title"
            }
            
            var message: String {
                return "some error message"
            }
        }
        
        let presenter = MockPresenter()
        presenter.showErrorBinder().onNext(TestError.someError)
        
        XCTAssertEqual(presenter.displayedTitle, "some title")
        XCTAssertEqual(presenter.displayedMessage, "some error message")
    }
    
    func testNonDisplayableError() {
        enum TestError: Error {
            case someError
        }
        
        let presenter = MockPresenter()
        presenter.showErrorBinder().onNext(TestError.someError)
        
        XCTAssertEqual(presenter.displayedTitle, "Error")
        XCTAssertEqual(presenter.displayedMessage, TestError.someError.localizedDescription)
    }
}
