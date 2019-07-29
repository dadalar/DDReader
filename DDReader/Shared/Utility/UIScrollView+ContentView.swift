//
//  UIScrollView+ContentView.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import UIKit

extension UIScrollView {

    func addVerticalScrollableContentView(_ contentView: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor,
                                         constant: insets.top).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                            constant: -insets.bottom).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor,
                                          constant: insets.left).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor,
                                           constant: insets.right).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor,
                                           multiplier: 1.0,
                                           constant: -(insets.right + insets.left)).isActive = true
    }

}
