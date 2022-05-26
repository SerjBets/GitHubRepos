//
//  MainCoordinator.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation
import UIKit

class MainCoordinator : Coordinator {

    var navigationController: UINavigationController

    init(with _navigationController : UINavigationController){
        self.navigationController = _navigationController
    }

    func configureRootViewController() {
        let home = MainViewController()
        home.mainCoordinator = self
        self.navigationController.pushViewController(home, animated: false)
    }

    func navigateToDetailVC(with model: Repo) {
        let detailVC = DetailViewController(model: model)
        detailVC.mainCoordinator = self
        self.navigationController.pushViewController(detailVC, animated: true)
    }

}
