//
//  MainViewController_inCode.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit

class MainViewController: UIViewController, CoordinatorBoard {
    weak var mainCoordinator : MainCoordinator?
    private var filteredRepos = [Repo]()
    private var mainView      = MainView()
    private var reposList     = [Repo]() {
        didSet {
            reposList.sort { $0.starsCount > $1.starsCount }
            mainView.tableView.reloadData()
        }
    }
    
//MARK: === ViewController LifeCycle ===
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        getStarRepos()
        addDelegates()
        hideKeyboardWhenTappedAround()
    }
    
    private func addDelegates() {
        mainView.tableView.emptyDataSetSource = self
        mainView.tableView.emptyDataSetDelegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchBar.delegate = self
    }
    
    private func getStarRepos() {
        APICaller.shared.fetchStarsRepos(with: Endpoints.reposUrlString) { results in
            switch results {
            case .success(let repos):
                self.reposList = repos.items
                self.mainView.tableView.hideActivityIndicator()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// === MARK: - UITableViewDelegate ===
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
}

// === MARK: - UITableViewDataSource ===
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredRepos.count == 0 { return reposList.count } else { return filteredRepos.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.repoTableViewCell, for: indexPath)
                as? RepoTableVIewCell else { return UITableViewCell() }
        if filteredRepos.count == 0 { filteredRepos = reposList }
        cell.configureCell(with: filteredRepos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoItem = reposList[indexPath.row]
        mainCoordinator?.navigateToDetailVC(with: repoItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// === MARK: - DZNEmptyDataSet ===
extension MainViewController {
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.mainView.tableView.showActivityIndicator()
        getStarRepos()
    }
}

// MARK: === UISearchResultsUpdating Delegate ===
extension MainViewController: UISearchBarDelegate{

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 { filteredRepos = reposList } else {
            filteredRepos = reposList.filter({ (repo: Repo) -> Bool in
                return repo.owner.login.lowercased().contains(searchText.lowercased())
            })
        }
        filteredRepos.sort { $0.starsCount > $1.starsCount }
        self.mainView.tableView.reloadData()
    }
}
