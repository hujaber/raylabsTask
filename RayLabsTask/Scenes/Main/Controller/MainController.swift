//
//  MainController.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import UIKit

class MainController: UIViewController, Loads {
    
    private let viewModel: MainViewModel
    var loader: LoaderView!
    
    private lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = .init()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.registerClass(UserCell.self)
        tableView.registerClass(UserCellWithLocation.self)
        return tableView
    }()
    
    private var users: [User] = [] {
        didSet {
            userTableView.reloadData()
        }
    }
    
    init(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        #warning("if we call bindViewModel before addTableView, there is a big chance loader won't show up")
        bindViewModel()
        setupNavigationBar()
    }
    
    private func bindViewModel() {
        viewModel.isLoading = { [weak self] isLoading in
            isLoading ? self?.showLoader() : self?.hideLoader()
        }
        
        viewModel.onSuccessfulUserFetch = { [weak self] users in
            guard let self = self else { return }
            self.users = users
        }
        
        viewModel.fetchUsers()
    }

}

// MARK: - UI setups
extension MainController {
    private func addTableView() {
        view.addSubview(userTableView)
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            userTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Users"
    }
}

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        if user.hasLocation {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCellWithLocation.identifier,
                                                     for: indexPath) as! UserCellWithLocation
            cell.populate(with: user)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath)
                as! UserCell
            cell.populate(with: user)
            return cell
        }
        
    }
}

