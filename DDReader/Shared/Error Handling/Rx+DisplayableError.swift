//
//  Rx+DisplayableError.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxCocoa

extension RxCocoaURLError: DisplayableError {
    var message: String {
        switch self {
        case .httpRequestFailed(let response, _):
            return "Bad response (\(response.statusCode))"
        default:
            return "Could not fetch data"
        }
    }
}
