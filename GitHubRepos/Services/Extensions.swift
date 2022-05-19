//
//  Extensions.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation
import UIKit
import DZNEmptyDataSet
import SDWebImage

// === MARK: - DZNEmptyDataSet Delegate extension ===
extension UIViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    public func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: ConnectionErrors.noData.localizedDescription, attributes: attrs)
    }
    
    public func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: ConnectionErrors.noConnection.localizedDescription, attributes: attrs)
    }

    public func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        let str = "Retry"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .callout)]
        return NSAttributedString(string: str, attributes: attrs)
    }
}

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

// MARK: === UIView extension ===
extension UIView {

    public var width: CGFloat {
        return frame.size.width
    }

    public var height: CGFloat {
        return frame.size.height
    }

    public var top: CGFloat {
        return frame.origin.y
    }

    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }

    public var left: CGFloat {
        return frame.origin.x
    }

    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}
