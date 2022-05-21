//
//  DetailViewController_inCode.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit
import SDWebImage
import SafariServices
import SwiftUI

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
        label.font = UIFont(name: customFonts.textSemibold.rawValue, size: 15)
        label.layer.opacity = 0.6
        return label
    }()
    
    private let repoAuthorTitle: UILabel = {
        let label = UILabel()
        label.text = "Repo Auther Name"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: customFonts.displayBold.rawValue, size: 28)
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
        label.font = UIFont(name: customFonts.textRegular.rawValue, size: 13)
        label.layer.opacity = 0.5
        return label
    }()

    private let repoTitle: UILabel = {
        let label = UILabel()
        label.text = "Repo Title"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: customFonts.textSemibold.rawValue, size: 17)
        return label
    }()
    
    private let viewOnlineButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = customColors.btnBackground.rawValue
        button.layer.cornerRadius = 17
        button.setTitle("VIEW ONlINE".uppercased(), for: .normal)
        button.titleLabel?.font =  UIFont(name: customFonts.textSemibold.rawValue, size: 15)
        button.setTitleColor(customColors.btnTitle.rawValue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
   }()
    
    private let commitHistoryTitle: UILabel = {
        let label = UILabel()
        label.text = "Commit History"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: customFonts.displayBold.rawValue, size: 22)
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CommitTableVIewCell_inCode.self, forCellReuseIdentifier: Constants.commitTableViewCell)
        table.isScrollEnabled = false
        table.allowsSelection = false
        return table
    }()
    
    @objc private let shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(named: "btnBackground")
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "shareIcon"), for: .normal)
        button.setTitle(" Share Repo", for: .normal)
        button.setTitleColor(UIColor(named: "btnTitle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
   }()
    
//MARK: === Constraints ===
    private func applyConstraints() {
        let constantSize: CGFloat = 20
        let margins: CGFloat = 16
        
        let headerImageConstraints = [
            headerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImage.topAnchor.constraint(equalTo: view.topAnchor),
            headerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImage.heightAnchor.constraint(equalToConstant: 263)
        ]
        let repoByTitleConstraints = [
            repoByTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantSize),
            repoByTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 159),
            repoByTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constantSize),
            repoByTitle.heightAnchor.constraint(equalToConstant: constantSize)
        ]
        let repoAuthorTitleConstraints = [
            repoAuthorTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantSize),
            repoAuthorTitle.topAnchor.constraint(equalTo: repoByTitle.bottomAnchor, constant: 4),
            repoAuthorTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constantSize),
            repoAuthorTitle.heightAnchor.constraint(equalToConstant: constantSize)
        ]
        let starsCountImageConstraints = [
            starsCountImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantSize),
            starsCountImage.topAnchor.constraint(equalTo: repoAuthorTitle.bottomAnchor, constant: 9),
            starsCountImage.widthAnchor.constraint(equalToConstant: 13),
            starsCountImage.heightAnchor.constraint(equalToConstant: 13)
        ]
        let numberStarsTitleConstraints = [
            numberStarsTitle.leadingAnchor.constraint(equalTo: starsCountImage.trailingAnchor, constant: 5),
            numberStarsTitle.topAnchor.constraint(equalTo: repoAuthorTitle.bottomAnchor, constant: 6),
            numberStarsTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constantSize),
            numberStarsTitle.heightAnchor.constraint(equalToConstant: 18)
        ]
        let repoTitleConstraints = [
            repoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantSize),
            repoTitle.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 21),
            repoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            repoTitle.heightAnchor.constraint(equalToConstant: 22)
        ]
        let viewOnlineButtonConstraints = [
            viewOnlineButton.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 17),
            viewOnlineButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margins),
            viewOnlineButton.widthAnchor.constraint(equalToConstant: 120),
            viewOnlineButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        let commitHistoryTitleConstraints = [
            commitHistoryTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins),
            commitHistoryTitle.topAnchor.constraint(equalTo: repoTitle.bottomAnchor, constant: 39),
            commitHistoryTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constantSize),
            commitHistoryTitle.heightAnchor.constraint(equalToConstant: 28)
        ]
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: commitHistoryTitle.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 333)
        ]
        let shareButtonConstraints = [
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margins),
            shareButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 24),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(headerImageConstraints)
        NSLayoutConstraint.activate(repoByTitleConstraints)
        NSLayoutConstraint.activate(repoAuthorTitleConstraints)
        NSLayoutConstraint.activate(starsCountImageConstraints)
        NSLayoutConstraint.activate(numberStarsTitleConstraints)
        NSLayoutConstraint.activate(repoTitleConstraints)
        NSLayoutConstraint.activate(viewOnlineButtonConstraints)
        NSLayoutConstraint.activate(commitHistoryTitleConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
        NSLayoutConstraint.activate(shareButtonConstraints)
    }
    
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
        view.addSubview(shareButton)
    }
    
    private func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIButton(type: .custom)
        backButton.tintColor = .systemBackground
        backButton.setImage(backButtonImage, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.systemBackground, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
//MARK: === Buttons Actions ===
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func shareButtonTapped() {
        prepareForShare()
    }
    
    @objc private func viewOnlineButtontapped() {
        showLinksClicked()
    }
    
// MARK: === Init ===
    init(model: Repo) {
        super.init(nibName: nil, bundle: nil)
        self.repoItem = model
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        getCommits()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        viewOnlineButton.addTarget(self, action: #selector(viewOnlineButtontapped), for: .touchUpInside)
    }
    

    private func getCommits() {
        APICaller.shared.fetchCommits(with: Constants.commitsUrlString) { results in
            switch results {
            case .success(let commits):
                //debugPrint(commits)
                self.commitsList = commits
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.commitTableViewCell, for: indexPath)
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
                //debugPrint(commits)
                self.commitsList = commits
                self.tableView.reloadData()
                self.tableView.hideActivityIndicator()
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
