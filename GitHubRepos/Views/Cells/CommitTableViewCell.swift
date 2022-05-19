//
//  CommitTableViewCell.swift
//  TestTask
//
//  Created by Сергей Бец on 16.05.2022.
//

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
