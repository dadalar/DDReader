//
//  PostDetailViewController.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import UIKit
import RxSwift

final class PostDetailViewController: UIViewController {

    // MARK: Private properties
    private let viewModel: PostDetailViewModel
    private let disposeBag = DisposeBag()

    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.accessibilityIdentifier = "authorNameLabel"
        return label
    }()
    private let avatarImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Avatar"))
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()
    private lazy var authorStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [avatarImageView, authorNameLabel])
        view.alignment = .center
        view.spacing = 20
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.accessibilityIdentifier = "titleLabel"
        return label
    }()
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.accessibilityIdentifier = "bodyLabel"
        return label
    }()
    private let commentCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.accessibilityIdentifier = "commentCountLabel"
        return label
    }()

    // Initialization
    init(postId: UInt64,
         managedDataService: ManagedDataServicing) {
        viewModel = PostDetailViewModel(postId: postId,
                                        managedDataService: managedDataService)
        super.init(nibName: nil, bundle: nil)

        title = "Post Detail"

        bindInputs()
        bindOutputs()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Initialize views
    override func loadView() {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceVertical = true
        let stackView = UIStackView(arrangedSubviews: [authorStackView, titleLabel, bodyLabel, commentCountLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        scrollView.addVerticalScrollableContentView(stackView, insets: .init(top: 20, left: 20, bottom: 20, right: 20))
        self.view = scrollView
    }

    // MARK: Bind Observables
    private func bindInputs() {
        viewModel.postDetail
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.postDetail
            .map { $0.body }
            .bind(to: bodyLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.postDetail
            .map { $0.author }
            .bind(to: authorNameLabel.rx.attributedText)
            .disposed(by: disposeBag)

        viewModel.postDetail
            .map { $0.commentCountText }
            .bind(to: commentCountLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.error
            .bind(to: showErrorBinder())
            .disposed(by: disposeBag)
    }

    private func bindOutputs() {
        rx.methodInvoked(#selector(UIViewController.viewDidLoad))
            .map { _ in return }
            .bind(to: viewModel.needsUpdate)
            .disposed(by: disposeBag)
    }
}
