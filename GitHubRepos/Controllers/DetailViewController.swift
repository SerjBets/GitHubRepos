//
//  DetailViewController_inCode.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit
import SDWebImage
import SafariServices
import SwiftUI

class DetailViewController: UIViewController, CoordinatorBoard, SFSafariViewControllerDelegate, DetailViewDelegate {
    
    weak var mainCoordinator : MainCoordinator?
    private var detailView = DetailView()
    var repoItem: Repo!
    var commitsList = [Commit]() {
        didSet {
            detailView.updateUI(with: repoItem, commit: commitsList[0])
            self.detailView.tableView.reloadData()
        }
    }

//MARK: === Buttons Actions ===
    internal func backButtonTapped() {
        mainCoordinator?.configureRootViewController()
    }
    
    internal func viewOnlineButtonTapped() {
        showLinksClicked()
    }
    
    internal func shareButtonTapped() {
        let nameToShare = String(describing: repoItem.name)
        let urlToShare = repoItem.htmlUrl
        let shareItems = [nameToShare, urlToShare] as [Any]
        let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityVC.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.print
        ]
        self.present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            if completed  {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
// MARK: === Init ===
    init(model: Repo) {
        super.init(nibName: nil, bundle: nil)
        self.repoItem = model
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: === ViewController LifeCycle ===
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addDelegates()
        getCommits()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: detailView.backbutton)
    }
    
    private func getCommits() {
        APICaller.shared.fetchCommits(with: Endpoints.commitsUrlString) { results in
            switch results {
            case .success(let commits):
                self.commitsList = commits
                self.detailView.tableView.hideActivityIndicator()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addDelegates() {
        detailView.tableView.dataSource = self
        detailView.tableView.delegate = self
        detailView.tableView.emptyDataSetSource = self
        detailView.tableView.emptyDataSetDelegate = self
        detailView.delegate = self
    }
}

// === MARK: - UITableViewDelegate ===
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
}

// === MARK: - UITableViewDataSource ===
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.commitTableViewCell, for: indexPath)
                as? CommitTableVIewCell else { return UITableViewCell() }
        cell.configureCell(with: commitsList[indexPath.row], index: indexPath)
        if indexPath.row >= 3 {
            return UITableViewCell()
        }
        return cell
    }
}

// === MARK: - SafariService ===
extension DetailViewController {
    
    func showLinksClicked() {
        let safariVC = SFSafariViewController(url: repoItem.owner.htmlUrl)
        present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// === MARK: - DZNEmptyDataSet ===
extension DetailViewController {

    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.detailView.tableView.showActivityIndicator()
        getCommits()
    }
}
