//
//  DetailViewController_inCode.swift
//  GitHubRepos
//
//  Created by Сергей Бец on 20.05.2022.
//

import UIKit
import SDWebImage
import SafariServices

class DetailViewController_inCode: UIViewController, SFSafariViewControllerDelegate {

    var repoItem: Repo!
    var commitsList = [Commit]() {
        didSet {
            updateUI()
            tableView.reloadData()
        }
    }
    
    //MARK: === UI Items ===
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let repoByTitle: UILabel = {
        let label = UILabel()
        label.text = "REPO BY"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Semibold", size: 15)
        label.layer.opacity = 0.6
        return label
    }()
    
    private let repoAuthorTitle: UILabel = {
        let label = UILabel()
        label.text = "Repo Auther Name"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Bold", size: 28)
        return label
    }()
    
    private let starsCountImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "starIcon2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let numberStarsTitle: UILabel = {
        let label = UILabel()
        label.text = "8877"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.layer.opacity = 0.5
        return label
    }()

    private let repoTitle: UILabel = {
        let label = UILabel()
        label.text = "Repo Title"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        return label
    }()
    
    private let viewOnlineButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 17
        button.titleLabel?.text = "VIEW ONlINE"
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
   }()
    
    private let commitHistoryTitle: UILabel = {
        let label = UILabel()
        label.text = "Commit History"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProDisplay-Bold", size: 22)
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CommitTableVIewCell_inCode.self, forCellReuseIdentifier: CommitTableVIewCell_inCode.identifier)
        return table
    }()
    
    private func addSubviews() {
        view.addSubview(headerImage)
        view.addSubview(repoByTitle)
        view.addSubview(repoAuthorTitle)
        view.addSubview(starsCountImage)
        view.addSubview(numberStarsTitle)
        view.addSubview(repoTitle)
        view.addSubview(viewOnlineButton)
        view.addSubview(commitHistoryTitle)
        view.addSubview(tableView)
    }
    
    private func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIButton(type: .custom)
        backButton.tintColor = .systemBackground
        backButton.setImage(backButtonImage, for: .normal)
        backButton.setTitle("  Back", for: .normal)
        backButton.setTitleColor(.systemBackground, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        addSubviews()
        getCommits()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        headerImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        headerImage.sd_setImage(with: avatarUrl)
        repoTitle.text = repoItem.name
        repoAuthorTitle.text = commitsList[0].commit.author.name
        numberStarsTitle.text = "\(repoItem.starsCount)"
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
}

// === MARK: - UITableViewDelegate ===
extension DetailViewController_inCode: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
}

// === MARK: - UITableViewDataSource ===
extension DetailViewController_inCode: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommitTableVIewCell_inCode.identifier, for: indexPath)
                as? CommitTableVIewCell_inCode else { return UITableViewCell() }
        cell.configureCell(with: commitsList[indexPath.row], index: indexPath)
        if indexPath.row >= 3 {
            return UITableViewCell()
        }
        return cell
    }
}

// === MARK: - SafariService ===
extension DetailViewController_inCode {
    
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
extension DetailViewController_inCode {

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

extension DetailViewController_inCode: MainViewController_inCodeDelegate {
    func didTaptableViewCell(with model: Repo) {
        updateUI()
    }
}
