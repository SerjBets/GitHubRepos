//
//  UITableView + Extension.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit

// === MARK: - TableView extension ===
extension UITableView {
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .medium)
            self.backgroundView = activityView
            activityView.startAnimating()
            UIApplication.shared.inputView?.isUserInteractionEnabled = true
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView = nil
            UIApplication.shared.inputView?.isUserInteractionEnabled = false
        }
    }
}
