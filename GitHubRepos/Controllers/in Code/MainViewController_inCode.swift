//
//  MainViewController_inCode.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit

class MainViewController_inCode: UIViewController {
    private var reposList = [Repo]() {
        didSet {
            reposList.sort { $0.starsCount > $1.starsCount }
            tableView.reloadData()
        }
    }
    private var filteredRepos = [Repo]()
    var isSearch = false
    
    //MARK: === UI Items ===
    private let searchTitle: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: customFonts.displayBold.rawValue, size: 34)
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private let tableViewTitle: UILabel = {
        let label = UILabel()
        label.text = "Repositories"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: customFonts.displayBold.rawValue, size: 22)
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(RepoTableVIewCell_inCode.self, forCellReuseIdentifier: Constants.repoTableViewCell)
        return table
    }()
    
    private func addSubviews() {
        view.addSubview(searchTitle)
        view.addSubview(searchBar)
        view.addSubview(tableViewTitle)
        view.addSubview(tableView)
    }
    
//MARK: === Constraints ===
    private func applyConstraints() {
        let margins: CGFloat = 16
        
        let searchTitleConstraints = [
            searchTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins),
            searchTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 89),
            searchTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margins),
            searchTitle.heightAnchor.constraint(equalToConstant: 41)
        ]
        let searchBarConstraints = [
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins),
            searchBar.topAnchor.constraint(equalTo: searchTitle.bottomAnchor, constant: 14),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margins),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ]
        let tableViewTitleConstraints = [
            tableViewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins),
            tableViewTitle.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
            tableViewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margins),
            tableViewTitle.heightAnchor.constraint(equalToConstant: 28)
        ]
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins),
            tableView.topAnchor.constraint(equalTo: tableViewTitle.bottomAnchor, constant: 18),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margins),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
            NSLayoutConstraint.activate(searchTitleConstraints)
            NSLayoutConstraint.activate(searchBarConstraints)
            NSLayoutConstraint.activate(tableViewTitleConstraints)
            NSLayoutConstraint.activate(tableViewConstraints)
    }
    
// MARK: === Init ===
    init() {
        super.init(nibName: nil, bundle: nil)
        addSubviews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: === ViewController LifeCycle ===
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.keyboardDismissMode = .onDrag
        
        addDelegates()
        tableView.showActivityIndicator()
        hideKeyboardWhenTappedAround()

        APICaller.shared.fetchStarsRepos(with: Constants.reposUrlString) { results in
            switch results {
            case .success(let repos):
                self.reposList = repos.items
                self.tableView.hideActivityIndicator()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addDelegates() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
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
        if filteredRepos.count == 0 { return reposList.count } else { return filteredRepos.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.repoTableViewCell, for: indexPath)
                as? RepoTableVIewCell_inCode else { return UITableViewCell() }
        if filteredRepos.count == 0 { filteredRepos = reposList }
        cell.configureCell(with: filteredRepos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoItem = reposList[indexPath.row]
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
                self.tableView.hideActivityIndicator()
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: === UISearchResultsUpdating Delegate ===
extension MainViewController_inCode: UISearchBarDelegate{

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
        self.tableView.reloadData()
    }
}
