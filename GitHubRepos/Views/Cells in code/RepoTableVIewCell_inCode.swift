//
//  RepoTableVIewCell_inCode.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation
import UIKit
import SDWebImage

class RepoTableVIewCell_inCode: UITableViewCell {
     static let identifier = "RepoTableVIewCell_inCode"
    
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
//        imageView.layer.borderWidth = 1.0
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellBackground.frame = CGRect(x: 16,
                                      y: 9,
                                      width: width - 32,
                                      height: height - 18)
        repoImage.frame      = CGRect(x: cellBackground.left + 16,
                                      y: cellBackground.top + 16,
                                      width: 60,
                                      height: 60)
        repoTitle.frame      = CGRect(x: repoImage.right + 16,
                                      y: cellBackground.top + 26,
                                      width: width - repoImage.width - 48,
                                      height: 22)
        starImage.frame      = CGRect(x: repoImage.right + 16,
                                      y: repoTitle.bottom + 4,
                                      width: 14,
                                      height: 14)
        starsTitle.frame     = CGRect(x: starImage.right + 4,
                                      y: repoTitle.bottom,
                                      width: width - starImage.right - 16,
                                      height: 22)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configureCell(with model: Repo) {
        let avatarUrl = model.owner.avatarUrl
        repoTitle.text = model.owner.login
        starsTitle.text = String(model.starsCount)
        repoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        repoImage.sd_setImage(with: avatarUrl)
    }
    
}
