//
//  Coordinator.swift
//  GitHubRepos
//
//  Created by Сергей Бец on 23.05.2022.
//

import Foundation
import UIKit

protocol Coordinator : AnyObject {
    var navigationController: UINavigationController { get set }

    func configureRootViewController()
}
