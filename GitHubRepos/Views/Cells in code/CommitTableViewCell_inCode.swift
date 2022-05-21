//
//  CommitTableViewCell_inCode.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation
import UIKit
import SDWebImage

class CommitTableVIewCell_inCode: UITableViewCell {
    
//MARK: === UI Items ===
    private let commitNumberTitle: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: customFonts.textMedium.rawValue, size: 17)
        return label
    }()
    
    private let commitAuthorTitle: UILabel = {
        let label = UILabel()
        label.text = "COMMIT AUTHOR NAME".uppercased()
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: customFonts.textSemibold.rawValue, size: 11)
        return label
    }()
    
    private let authorEmailTitle: UILabel = {
        let label = UILabel()
        label.text = "email@authorname.com"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: customFonts.textRegular.rawValue, size: 17)
        label.clipsToBounds = true
        return label
    }()
    
    private let commitMessageTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.text = "This is commit message that need to fold over to the next line"
        label.font = UIFont(name: customFonts.textRegular.rawValue, size: 17)
        label.clipsToBounds = true
        return label
    }()
    
    private let commitNumBackground: UIButton = {
        let button = UIButton()
        button.backgroundColor = customColors.cellBackground.rawValue
        button.layer.cornerRadius = 18
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    private func addSubviews() {
        contentView.addSubview(commitNumBackground)
        contentView.addSubview(commitNumberTitle)
        contentView.addSubview(commitAuthorTitle)
        contentView.addSubview(authorEmailTitle)
        contentView.addSubview(commitMessageTitle)
    }
    
//MARK: === Constraints ==
    private func applyConstraints() {
        let constantSize              : CGFloat = 20
        let margins                   : CGFloat = 16
        let circleBackgroundImageSize : CGFloat = 36
        
        let commitNumBackgroundConstraints = [
            commitNumBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constantSize),
            commitNumBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            commitNumBackground.widthAnchor.constraint(equalToConstant: circleBackgroundImageSize),
            commitNumBackground.heightAnchor.constraint(equalToConstant: circleBackgroundImageSize)
        ]
        let commitNumberTitleConstraints = [
            commitNumberTitle.leadingAnchor.constraint(equalTo: commitNumBackground.leadingAnchor, constant: 14),
            commitNumberTitle.topAnchor.constraint(equalTo: commitNumBackground.topAnchor, constant: 8),
            commitNumberTitle.trailingAnchor.constraint(equalTo: commitNumBackground.trailingAnchor, constant: -14),
            commitNumberTitle.heightAnchor.constraint(equalToConstant: constantSize)
        ]
        let commitAuthorTitleConstraints = [
            commitAuthorTitle.leadingAnchor.constraint(equalTo: commitNumBackground.trailingAnchor, constant: constantSize),
            commitAuthorTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            commitAuthorTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margins),
            commitAuthorTitle.heightAnchor.constraint(equalToConstant: 13)
        ]
        let authorEmailTitleConstraints = [
            authorEmailTitle.leadingAnchor.constraint(equalTo: commitNumBackground.trailingAnchor, constant: constantSize),
            authorEmailTitle.topAnchor.constraint(equalTo: commitAuthorTitle.bottomAnchor, constant: 2),
            authorEmailTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margins),
            authorEmailTitle.heightAnchor.constraint(equalToConstant: 22)
        ]
        let commitMessageTitleConstraints = [
            commitMessageTitle.leadingAnchor.constraint(equalTo: commitNumBackground.trailingAnchor, constant: constantSize),
            commitMessageTitle.topAnchor.constraint(equalTo: authorEmailTitle.bottomAnchor, constant: 2),
            commitMessageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margins),
            commitMessageTitle.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(commitNumBackgroundConstraints)
        NSLayoutConstraint.activate(commitNumberTitleConstraints)
        NSLayoutConstraint.activate(commitAuthorTitleConstraints)
        NSLayoutConstraint.activate(authorEmailTitleConstraints)
        NSLayoutConstraint.activate(commitMessageTitleConstraints)
    }
    
//MARK: === Init ===
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configureCell(with model: Commit, index: IndexPath)  {
        commitAuthorTitle.text  = model.commit.author.name.uppercased()
        authorEmailTitle.text   = model.commit.author.email
        commitNumberTitle.text  = "\(index.row + 1)"
        commitMessageTitle.text = model.commit.message
    }
    
}
