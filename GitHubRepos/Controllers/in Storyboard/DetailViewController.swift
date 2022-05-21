//
//  DetailViewController.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit
import SDWebImage
import SafariServices

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var repoAuthorTitle: UILabel!
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var numberStarsTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var repoItem: Repo!
    var commitsList = [Commit]() {
        didSet {
            updateUI()
            tableView.reloadData()
        }
    }
    
    //MARK: === Button Actions ===
    @IBAction func viewOnlineButton(_ sender: Any) {
        showLinksClicked()
    }
    
    @IBAction func shareRepoButton(_ sender: Any) {
        prepareForShare()
    }
    
    private func prepareForShare() {
        let nameToShare = String(describing: repoItem.name)
        let urlToShare = repoItem.htmlUrl
        let shareItems = [nameToShare, urlToShare] as [Any]
        let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)

        //Apps to exclude sharing to
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
    
    //MARK: === ViewController LifeCycle ===
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        registerTableViewCells()
        getCommits()
    }

    private func getCommits() {
        APICaller.shared.fetchCommits(with: Constants.commitsUrlString) { results in
            switch results {
            case .success(let commits):
                debugPrint(commits)
                self.commitsList = commits
                debugPrint(commits)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateUI() {
        let avatarUrl = repoItem.owner.avatarUrl
        userImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        userImage.sd_setImage(with: avatarUrl)
        repoTitle.text = repoItem.name
        repoAuthorTitle.text = commitsList[0].commit.author.name
        numberStarsTitle.text = "\(repoItem.starsCount)"
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
// UI tableViewCell in Storyboard in xib
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DetailNibName, for: indexPath)
//                as? CommitTableViewCell else { return UITableViewCell() }
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.commitTableViewCell, for: indexPath)
                as? CommitTableVIewCell_inCode else { return UITableViewCell() }
        
        
        cell.configureCell(with: commitsList[indexPath.row], index: indexPath)
        
        if indexPath.row >= 3 {
            return UITableViewCell()
        }
        return cell
    }
    
    private func registerTableViewCells() {
// UI tableViewCell in Storyboard in xib
//        let cellNib = UINib(nibName: Constants.DetailNibName, bundle: nil)
//        tableView.register(cellNib, forCellReuseIdentifier: CommitTableViewCell.identifier)
        
        self.tableView.register(CommitTableVIewCell_inCode.self,
                                forCellReuseIdentifier: Constants.commitTableViewCell)
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
        self.tableView.showActivityIndicator()
        
        APICaller.shared.fetchCommits(with: Constants.commitsUrlString) { results in
            switch results {
            case .success(let commits):
                debugPrint(commits)
                self.commitsList = commits
                self.tableView.reloadData()
                self.tableView.hideActivityIndicator()
                debugPrint(commits)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
