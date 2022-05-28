//
//  RepoTableVIewCell_inCode.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation
import UIKit
import SDWebImage

class RepoTableVIewCell: UITableViewCell {
    
//MARK: === UI Items ===
     private let cellBackground: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "cellBackground")
        button.layer.cornerRadius = 13
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    private let repoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "starIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let repoTitle: UILabel = {
        let label = UILabel()
        label.text = "Repo Title"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        return label
    }()
    
    private let starsTitle: UILabel = {
        let label = UILabel()
        label.text = "8877"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "warmGray")
        return label
    }()
    
    private func addSubviews() {
        contentView.addSubview(cellBackground)
        contentView.addSubview(repoImage)
        contentView.addSubview(repoTitle)
        contentView.addSubview(starImage)
        contentView.addSubview(starsTitle)
    }
    
//MARK: === Constraints ==
    private func applyConstraints() {
        let margins       : CGFloat = 16
        let repoImageSize : CGFloat = 60
        let starImageSize : CGFloat = 14
        let textHeight    : CGFloat = 22
        
        let cellBackgrounddConstraints = [
            cellBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margins),
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.5),
            cellBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margins),
            cellBackground.heightAnchor.constraint(equalToConstant: 92)
        ]
        let repoImageConstraints = [
            repoImage.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: margins),
            repoImage.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: margins),
            repoImage.widthAnchor.constraint(equalToConstant: repoImageSize),
            repoImage.heightAnchor.constraint(equalToConstant: repoImageSize)
        ]
        let repoTitleConstraints = [
            repoTitle.leadingAnchor.constraint(equalTo: repoImage.trailingAnchor, constant: margins),
            repoTitle.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 26),
            repoTitle.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: 30),
            repoTitle.heightAnchor.constraint(equalToConstant: textHeight)
        ]
        let starImageConstraints = [
            starImage.leadingAnchor.constraint(equalTo: repoImage.trailingAnchor, constant: margins),
            starImage.topAnchor.constraint(equalTo: repoTitle.bottomAnchor, constant: 4),
            starImage.widthAnchor.constraint(equalToConstant: starImageSize),
            starImage.heightAnchor.constraint(equalToConstant: starImageSize)
        ]
        let starsTitleConstraints = [
            starsTitle.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 4),
            starsTitle.topAnchor.constraint(equalTo: repoTitle.bottomAnchor, constant: 0),
            starsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margins),
            starsTitle.heightAnchor.constraint(equalToConstant: textHeight)
        ]
        NSLayoutConstraint.activate(cellBackgrounddConstraints)
        NSLayoutConstraint.activate(repoImageConstraints)
        NSLayoutConstraint.activate(repoTitleConstraints)
        NSLayoutConstraint.activate(starImageConstraints)
        NSLayoutConstraint.activate(starsTitleConstraints)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repoImage.image = nil
        repoTitle.text  = ""
        starImage.image = nil
        starsTitle.text = ""
    }
    
    public func configureCell(with model: Repo) {
        let avatarUrl = model.owner.avatarUrl
        repoTitle.text = model.owner.login
        starsTitle.text = String(model.starsCount)
        repoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        repoImage.sd_setImage(with: avatarUrl)
    }
    
}
