//
//  CUstom Colors.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit

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
