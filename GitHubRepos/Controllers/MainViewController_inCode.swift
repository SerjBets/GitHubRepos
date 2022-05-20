//
//  MainViewController_inCode.swift
//  GitHubRepos
//
//  Created by Сергей Бец on 19.05.2022.
//

import UIKit

class MainViewController_inCode: UIViewController {
    var reposList = [Repo]() {
        didSet {
            tableView.reloadData()
        }
    }

    private let searchTitle: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(RepoTableVIewCell_inCode.self, forCellReuseIdentifier: RepoTableVIewCell_inCode.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.showActivityIndicator()
        self.registerTableViewCells()
        
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
}

// === MARK: - UITableViewDelegate ===
extension MainViewController_inCode: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
}

// === MARK: - UITableViewDataSource ===
extension MainViewController_inCode: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MainNibName, for: indexPath)
//                as? RepoTableViewCell else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableVIewCell_inCode.identifier, for: indexPath)
                as? RepoTableVIewCell_inCode else { return UITableViewCell() }
        cell.configureCell(with: reposList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoItem = reposList[indexPath.row]
        performSegue(withIdentifier: Constants.segue, sender: repoItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func registerTableViewCells() {
        self.tableView.register(RepoTableVIewCell_inCode.self,
                                forCellReuseIdentifier: RepoTableVIewCell_inCode.identifier)
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
