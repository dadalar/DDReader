//
//  main.swift
//  DDReader
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import UIKit

// This file is here so that regular AppDelegate doesn't get loaded when unit testing
private func delegateClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
}

_ = UIApplicationMain( CommandLine.argc, CommandLine.unsafeArgv, nil, delegateClassName())
