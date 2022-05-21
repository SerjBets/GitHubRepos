//
//  Constraints.swift
//  GitHubRepos
//
//  Created by Сергей Бец on 21.05.2022.
//

import Foundation
import UIKit

struct Constants {
    static let MainNibName = "RepoTableViewCell"
    static let DetailNibName = "CommitTableViewCell"
    static let segue   = "detailSegue"
    static let userUrlString = "https://api.github.com/search/users"
    static let reposUrlString = "https://api.github.com/search/repositories?"
    static let commitsUrlString = "https://api.github.com/repos/freeCodeCamp/freeCodeCamp/commits"
    static let commitTableViewCell = "CommitTableVIewCell_inCode"
}

enum customFonts {
    case textBold
    case textSemibold
    case textRegular
    case textMedium
    case displayBold
    case displaySemibold
    case displayRegular
    
    var rawValue: String {
        switch self {
            case .textBold       : return "SFProText-Bold"
            case .textSemibold   : return "SFProText-Semibold"
            case .textRegular    : return "SFProText-Regular"
            case .textMedium     : return "SFProText-Medium"
            case .displayBold    : return "SFProDisplay-Bold"
            case .displaySemibold: return "SFProDisplay-Semibold"
            case .displayRegular : return "SFProDisplay-Regular"
        }
    }
}

enum customColors {
    case btnBackground
    case btnTitle
    case cellBackground
    
    var rawValue: UIColor {
        switch self {
            case .btnBackground : return UIColor(named: "btnBackground")!
            case .btnTitle      : return UIColor(named: "btnTitle")!
            case .cellBackground: return UIColor(named: "cellBackground")!
        }
    }
}


