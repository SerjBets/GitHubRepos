//
//  RepoTableViewCell.swift
//  TestTask
//
//  Created by Сергей Бец on 16.05.2022.
//

import UIKit
import SDWebImage

class RepoTableViewCell: UITableViewCell {
    static let identifier = "RepoTableViewCell"
    
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
