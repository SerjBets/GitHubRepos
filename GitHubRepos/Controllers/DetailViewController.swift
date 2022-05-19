//
//  DetailViewController.swift
//  TestTask
//
//  Created by Сергей Бец on 17.05.2022.
//

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
        
    }
    
    //MARK: === ViewController LifeCycle ===
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: Constants.DetailNibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CommitTableViewCell.identifier)
        getCommits()
        updateUI()
    }

    func getCommits() {

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
        
    }

}

// === MARK: - UITableViewDataSource ===
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommitTableViewCell.identifier) as! CommitTableViewCell
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
