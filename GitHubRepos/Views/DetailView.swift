//
//  DetailView.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit
import SDWebImage

protocol DetailViewDelegate: AnyObject {
    func shareButtonTapped()
    func backButtonTapped()
    func viewOnlineButtonTapped()
}

class DetailView: UIView {
    weak var delegate: DetailViewDelegate?
    
//MARK: === UI Items ===
    lazy var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var repoByTitle: UILabel = {
        let label = UILabel()
        label.text = "REPO BY"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.layer.opacity = 0.6
        return label
    }()
    
    lazy var repoAuthorTitle: UILabel = {
        let label = UILabel()
        label.text = "Repo Auther Name"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    lazy var starsCountImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "starIcon2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var numberStarsTitle: UILabel = {
        let label = UILabel()
        label.text = "8877"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.layer.opacity = 0.5
        return label
    }()

    lazy var repoTitle: UILabel = {
        let label = UILabel()
        label.text = "Repo Title"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var viewOnlineButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = customColors.btnBackground.rawValue
        button.layer.cornerRadius = 17
        button.setTitle("VIEW ONlINE".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(customColors.btnTitle.rawValue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(viewOnlineButtonTapped), for: .touchUpInside)
        return button
   }()
    
    lazy var commitHistoryTitle: UILabel = {
        let label = UILabel()
        label.text = "Commit History"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CommitTableVIewCell.self, forCellReuseIdentifier: Identifiers.commitTableViewCell)
        table.isScrollEnabled = false
        table.allowsSelection = false
        table.showActivityIndicator()
        return table
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(named: "btnBackground")
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "shareIcon"), for: .normal)
        button.setTitle(" Share Repo", for: .normal)
        button.setTitleColor(UIColor(named: "btnTitle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
   }()
    
    lazy var backbutton: UIButton = {
        var button = UIButton()
        let image = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysTemplate)
        button = UIButton(type: .custom)
        button.tintColor = .black
        button.setImage(image, for: .normal)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
//MARK: === Constraints ===
    private func applyConstraints() {
        let constantSize: CGFloat = 20
        let margins: CGFloat = 16
        
        NSLayoutConstraint.activate(
        [
            headerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerImage.topAnchor.constraint(equalTo: self.topAnchor),
            headerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerImage.heightAnchor.constraint(equalToConstant: 263),

            repoByTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constantSize),
            repoByTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 159),
            repoByTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constantSize),
            repoByTitle.heightAnchor.constraint(equalToConstant: constantSize),

            repoAuthorTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constantSize),
            repoAuthorTitle.topAnchor.constraint(equalTo: repoByTitle.bottomAnchor, constant: 4),
            repoAuthorTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constantSize),
            repoAuthorTitle.heightAnchor.constraint(equalToConstant: constantSize),

            starsCountImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constantSize),
            starsCountImage.topAnchor.constraint(equalTo: repoAuthorTitle.bottomAnchor, constant: 9),
            starsCountImage.widthAnchor.constraint(equalToConstant: 13),
            starsCountImage.heightAnchor.constraint(equalToConstant: 13),

            numberStarsTitle.leadingAnchor.constraint(equalTo: starsCountImage.trailingAnchor, constant: 5),
            numberStarsTitle.topAnchor.constraint(equalTo: repoAuthorTitle.bottomAnchor, constant: 6),
            numberStarsTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constantSize),
            numberStarsTitle.heightAnchor.constraint(equalToConstant: 18),

            repoTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constantSize),
            repoTitle.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 21),
            repoTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150),
            repoTitle.heightAnchor.constraint(equalToConstant: 22),

            viewOnlineButton.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 17),
            viewOnlineButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margins),
            viewOnlineButton.widthAnchor.constraint(equalToConstant: 120),
            viewOnlineButton.heightAnchor.constraint(equalToConstant: 30),

            commitHistoryTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margins),
            commitHistoryTitle.topAnchor.constraint(equalTo: repoTitle.bottomAnchor, constant: 39),
            commitHistoryTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constantSize),
            commitHistoryTitle.heightAnchor.constraint(equalToConstant: 28),

            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: commitHistoryTitle.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 333),

            shareButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margins),
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margins),
            shareButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 24),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addSubviews() {
        addSubview(headerImage)
        addSubview(repoByTitle)
        addSubview(repoAuthorTitle)
        addSubview(starsCountImage)
        addSubview(numberStarsTitle)
        addSubview(repoTitle)
        addSubview(viewOnlineButton)
        addSubview(commitHistoryTitle)
        addSubview(tableView)
        addSubview(shareButton)
    }
    
    // MARK: === Init ===
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: === Buttons Actions ===
    @objc private func shareButtonTapped() {
        delegate?.shareButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    @objc private func viewOnlineButtonTapped() {
        delegate?.viewOnlineButtonTapped()
    }
    
    func updateUI(with repo: Repo, commit: Commit) {
        let avatarUrl = repo.owner.avatarUrl
        headerImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        headerImage.sd_setImage(with: avatarUrl)
        repoTitle.text = repo.name
        repoAuthorTitle.text = commit.commit.author.name
        numberStarsTitle.text = "\(repo.starsCount)"
    }
}
