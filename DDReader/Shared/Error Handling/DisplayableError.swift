//
//  DisplayableError.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation

protocol DisplayableError {
    var title: String? { get }
    var message: String { get }
}

extension DisplayableError {
    var title: String? {
        return "Error"
    }
}
