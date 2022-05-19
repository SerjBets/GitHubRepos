//
//  CommitTableViewCell_inCode.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation
import UIKit
import SDWebImage

class CommitTableVIewCell_inCode: UITableViewCell {
    static let identifier = "CommitTableVIewCell_inCode"
    
    private let commitNumberTitle: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.clipsToBounds = true
        label.font = UIFont(name: "SFProText-Medium", size: 17)
        return label
    }()
    
    private let commitAuthorTitle: UILabel = {
        let label = UILabel()
        label.text = "COMMIT AUTHOR NAME".uppercased()
        label.textColor = .blue
        label.clipsToBounds = true
        label.font = UIFont(name: "SFProText-Semibold", size: 11)
        return label
    }()
    
    private let authorEmailTitle: UILabel = {
        let label = UILabel()
        label.text = "email@authorname.com"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.clipsToBounds = true
        return label
    }()
    
    private let commitMessageTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.text = "This is commit message that need to fold over to the next line"
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.clipsToBounds = true
        return label
    }()
    
    private let commitNumBackground: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "cellBackground")
        button.layer.cornerRadius = 18
        button.titleLabel?.text = ""
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        commitNumBackground.frame = CGRect(x: 20,
                                           y: 26,
                                           width: 36,
                                           height: 36)
        commitNumberTitle.frame   = CGRect(x: commitNumBackground.left + 14,
                                           y: commitNumBackground.top + 8,
                                           width: 10,
                                           height: 20)
        commitAuthorTitle.frame   = CGRect(x: commitNumBackground.right + 20,
                                           y: 16,
                                           width: width - commitNumBackground.width - 56,
                                           height: 13)
        authorEmailTitle.frame    = CGRect(x: commitNumBackground.right + 20,
                                           y: commitAuthorTitle.bottom + 2,
                                           width: width - commitNumBackground.width - 56,
                                           height: 22)
        commitMessageTitle.frame  = CGRect(x: 76,
                                           y: authorEmailTitle.bottom + 2,
                                           width: width - commitNumBackground.width - 76,
                                           height: 22)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configureCell(with model: Commit, index: IndexPath)  {
        commitAuthorTitle.text  = model.commit.author.name.uppercased()
        authorEmailTitle.text   = model.commit.author.email
        commitNumberTitle.text  = "\(index.row + 1)"
        //commitMessageTitle.text = model.commit.message
    }
    
}
