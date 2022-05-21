//
//  RepoTableViewCell.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit
import SDWebImage

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var starsCountSubTitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image         = nil
        repoTitle.text          = ""
        starsCountSubTitle.text = ""
    }
    
    func configureCell(with model: Repo) {
        let avatarUrl = model.owner.avatarUrl
        repoTitle.text = model.owner.login
        starsCountSubTitle.text = String(model.starsCount)
        userImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        userImage.sd_setImage(with: avatarUrl)
    }
}
