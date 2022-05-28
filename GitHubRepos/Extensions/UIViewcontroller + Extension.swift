//
//  UIViewcontroller + Extension.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit
import DZNEmptyDataSet

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

//MARK: === hideKeyboard extension ===
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
