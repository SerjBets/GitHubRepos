//
//  CommitTableViewCell.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit

class CommitTableViewCell: UITableViewCell {
    static let identifier = "CommitTableViewCell"

    @IBOutlet weak var commitNumber: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var commitMessage: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        commitNumber.text   = ""
        userName.text       = ""
        userName.text       = ""
        commitMessage.text  = ""
    }
    
    func configureCell(with model: Commit, index: IndexPath) {
        userName.text      = model.commit.author.name
        userEmail.text     = model.commit.author.email
        commitNumber.text  = "\(index.row + 1)"
        commitMessage.text = model.commit.message
    }
}
