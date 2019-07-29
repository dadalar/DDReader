//
//  PostsViewController.swift
//  DDReader
//
//  Created by Deniz Adalar on 05/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class PostsViewController: UITableViewController {

    // MARK: Private properties
    private static let reuseIdentifier = "cell"
    private let viewModel: PostsViewModel
    private let disposeBag = DisposeBag()
    private let tableRefreshControl = UIRefreshControl()
    private let managedDataService: ManagedDataServicing

    private lazy var warningLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.backgroundColor = UIColor.orange
        label.textColor = UIColor.white
        label.text = "You're viewing cached data"
        label.textAlignment = .center
        return label
    }()

    // Initialization
    init(managedDataService: ManagedDataServicing) {
        self.viewModel = PostsViewModel(managedDataService: managedDataService)
        self.managedDataService = managedDataService
        super.init(nibName: nil, bundle: nil)

        setupView()
        bindInputs()
        bindOutputs()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.title = "Posts"
        self.refreshControl = tableRefreshControl

        tableView.estimatedRowHeight = 60
        tableView.dataSource = nil
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostsViewController.reuseIdentifier)
    }

    // MARK: Bind Observables
    private func bindInputs() {
        viewModel.isLoading
            .bind(to: tableView.tableRefresBinder)
            .disposed(by: disposeBag)

        viewModel.posts
            .map { $0.posts.map(PostTableViewCellModel.init) }
            .bind(to: tableView.rx.items(cellIdentifier: PostsViewController.reuseIdentifier,
                                         cellType: PostTableViewCell.self)) { _, item, cell in
                cell.update(with: item)
            }
            .disposed(by: disposeBag)

        viewModel.posts
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [tableView, warningLabel] in
                tableView?.tableHeaderView = $0.isCached ? warningLabel : nil
            }).disposed(by: disposeBag)

        viewModel.error
            .bind(to: showErrorBinder())
            .disposed(by: disposeBag)

    }

    private func bindOutputs() {
        // Reload data on viewWillAppear AND pull-to-refresh
        let updateDataSignal = Observable.merge(
            rx.methodInvoked(#selector(UIViewController.viewWillAppear))
                .map { _ in return },
            tableRefreshControl.rx.controlEvent(.valueChanged)
                .map { [tableRefreshControl] in tableRefreshControl.isRefreshing }
                .filter { $0 }
                .map { _ in return }
        )

        updateDataSignal
            .bind(to: viewModel.needsUpdate)
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(PostTableViewCellModel.self)
            .map { [managedDataService] in
                PostDetailViewController(postId: $0.id, managedDataService: managedDataService)
            }
            .bind(to: showDetail())
            .disposed(by: disposeBag)
    }

}
