//
//  MainViewController.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit
import SDWebImage
import DZNEmptyDataSet

class MainViewController: UIViewController  {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var reposList = [Repo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
//MARK: === ViewController LifeCycle ===
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showActivityIndicator()
        registerTableViewCells()

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segue,
                let repos = sender as? Repo,
                let detailedVC = segue.destination as? DetailViewController else { return }
        detailedVC.repoItem = repos
    }
}

// === MARK: - UITableViewDelegate ===
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
}

// === MARK: - UITableViewDataSource ===
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
// UI tableViewCell in Storyboard in xib
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
// UI tableViewCell in Storyboard in xib
//        let cellNib = UINib(nibName: Constants.MainNibName, bundle: nil)
//        self.tableView.register(cellNib, forCellReuseIdentifier: RepoTableViewCell.identifier)
        
        self.tableView.register(RepoTableVIewCell_inCode.self,
                                forCellReuseIdentifier: RepoTableVIewCell_inCode.identifier)
    }
}
// === MARK: - DZNEmptyDataSet ===
extension MainViewController {

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
