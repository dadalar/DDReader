//
//  PostTableViewCell.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        // Styling
        accessoryType = .disclosureIndicator
        textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        detailTextLabel?.textColor = UIColor.darkGray

        // Support multi-line text
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 2 // Maximum 2 lines for body
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with post: PostTableViewCellModel) {
        textLabel?.text = post.title
        detailTextLabel?.text = post.subtitle
    }
}
