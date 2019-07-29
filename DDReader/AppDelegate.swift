//
//  AppDelegate.swift
//  DDReader
//
//  Created by Deniz Adalar on 05/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = initializeMainWindow()
        self.window?.makeKeyAndVisible()

        return true
    }

    private func initializeAppManagedDataService() -> ManagedDataService {
        let postsService = PostsService(baseURL: Constants.baseURL)
        let usersService = UsersService(baseURL: Constants.baseURL)
        let commentsService = CommentsService(baseURL: Constants.baseURL)
        let cacheService = DiskCacheService()
        return ManagedDataService(postsService: postsService,
                                  usersService: usersService,
                                  commentsService: commentsService,
                                  cacheService: cacheService)
    }

    private func initializeManagedDataService() -> ManagedDataServicing {
        if ProcessInfo.processInfo.environment["UI_TESTING"] == "1" {
            return MockManagedDataService()
        } else {
            return initializeAppManagedDataService()
        }
    }

    private func initializeMainWindow() -> UIWindow {
        // Initialize dependencies
        let managedDataService = initializeManagedDataService()

        // Initialize view controller
        let postsViewController = PostsViewController(managedDataService: managedDataService)

        // Initialize window
        let navigationController = UINavigationController(rootViewController: postsViewController)
        let window = UIWindow()
        window.rootViewController = navigationController
        return window
    }

}
