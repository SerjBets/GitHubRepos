//
//  MainViewController_inCode.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit

protocol MainViewController_inCodeDelegate {
    func didTaptableViewCell(with model: Repo)
}

class MainViewController_inCode: UIViewController {
    var reposList = [Repo]() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: MainViewController_inCodeDelegate?
    
    //MARK: === UI Items ===
    private let searchTitle: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.font = UIFont(name: customFonts.displayBold.rawValue, size: 34)
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        return bar
    }()
    
    private let tableViewTitle: UILabel = {
        let label = UILabel()
        label.text = "Repositories"
        label.numberOfLines = 0
        label.font = UIFont(name: customFonts.displayBold.rawValue, size: 22)
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(RepoTableVIewCell_inCode.self, forCellReuseIdentifier: RepoTableVIewCell_inCode.identifier)
        return table
    }()
    
    private func addSubviews() {
        view.addSubview(searchTitle)
        view.addSubview(searchBar)
        view.addSubview(tableViewTitle)
        view.addSubview(tableView)
    }

//MARK: === ViewController LifeCycle ===
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showActivityIndicator()
        addSubviews()
        
        //Get repos
        APICaller.shared.fetchStarsRepos(with: Constants.reposUrlString) { results in
            switch results {
            case .success(let repos):
                self.reposList = repos.items
                //debugPrint(repos)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTitle.frame    = CGRect(x: 16,
                                      y: 89,
                                      width: view.width - 32,
                                      height: 41)
        searchBar.frame      = CGRect(x: 16,
                                      y: searchTitle.bottom + 14,
                                      width: view.width - 32,
                                      height: 36)
        tableViewTitle.frame = CGRect(x: 16,
                                      y: searchBar.bottom + 30,
                                      width: view.width - 32,
                                      height: 28)
        tableView.frame      = CGRect(x: 0,
                                      y: tableViewTitle.bottom,
                                      width: view.width,
                                      height: view.height - tableViewTitle.bottom)
    }
}

// === MARK: - UITableViewDelegate ===
extension MainViewController_inCode: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
}

// === MARK: - UITableViewDataSource ===
extension MainViewController_inCode: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableVIewCell_inCode.identifier, for: indexPath)
                as? RepoTableVIewCell_inCode else { return UITableViewCell() }
        cell.configureCell(with: reposList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoItem = reposList[indexPath.row]
        delegate?.didTaptableViewCell(with: repoItem)
        let vc = DetailViewController_inCode(model: repoItem)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .custom
        present(navVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
// === MARK: - DZNEmptyDataSet ===
extension MainViewController_inCode {

    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.tableView.showActivityIndicator()
        
        //Get repos
        APICaller.shared.fetchStarsRepos(with: Constants.reposUrlString) { results in
            switch results {
            case .success(let repos):
                self.reposList = repos.items
                self.tableView.reloadData()
                self.tableView.hideActivityIndicator()
                //debugPrint(repos)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
