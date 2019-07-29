//
//  TableViewRefreshControlBinder.swift
//  DDReader
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import UIKit
import RxCocoa

extension UITableView {

    var tableRefresBinder: Binder<Bool> {
        return Binder<Bool>(self) { (self, isLoading) in
            guard let refreshControl = self.refreshControl else { return }
            if isLoading {
                refreshControl.beginRefreshing()

                // Only force scroll on first load where the contentOffset is zero
                if self.contentOffset == .zero {
                    let offset = CGPoint(x: 0, y: -refreshControl.bounds.height)
                    self.setContentOffset(offset, animated: true)
                }
            } else {
                // Cancel user's scroll tracking and automatically scroll to top
                self.isScrollEnabled = false
                self.isScrollEnabled = true
                refreshControl.endRefreshing()
            }
        }
    }
}
