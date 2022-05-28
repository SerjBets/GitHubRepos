//
//  MainView.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit

class MainView: UIView {
    //MARK: === UI Items ===
    lazy var searchTitle: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    lazy var tableViewTitle: UILabel = {
        let label = UILabel()
        label.text = "Repositories"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.keyboardDismissMode = .onDrag
        table.showActivityIndicator()
        table.register(RepoTableVIewCell.self, forCellReuseIdentifier: Identifiers.repoTableViewCell)
        return table
    }()
    
    private func addSubviews() {
        addSubview(searchTitle)
        addSubview(searchBar)
        addSubview(tableViewTitle)
        addSubview(tableView)
    }
    
    //MARK: === Constraints ===
    private func applyConstraints() {
        let margins: CGFloat = 16
        
        let searchTitleConstraints = [
            searchTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margins),
            searchTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 89),
            searchTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margins),
            searchTitle.heightAnchor.constraint(equalToConstant: 41)
        ]
        let searchBarConstraints = [
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margins),
            searchBar.topAnchor.constraint(equalTo: searchTitle.bottomAnchor, constant: 14),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margins),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ]
        let tableViewTitleConstraints = [
            tableViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margins),
            tableViewTitle.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
            tableViewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margins),
            tableViewTitle.heightAnchor.constraint(equalToConstant: 28)
        ]
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margins),
            tableView.topAnchor.constraint(equalTo: tableViewTitle.bottomAnchor, constant: 18),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margins),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
            NSLayoutConstraint.activate(searchTitleConstraints)
            NSLayoutConstraint.activate(searchBarConstraints)
            NSLayoutConstraint.activate(tableViewTitleConstraints)
            NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    // MARK: === Init ===
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
