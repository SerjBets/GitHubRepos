//
//  MainCoordinator.swift
//  GitHubRepos
//
//  Created by Сергей Бец on 23.05.2022.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator {

    var navigationController: UINavigationController

    init(with _navigationController : UINavigationController){
        self.navigationController = _navigationController
    }

    func configureRootViewController() {
        let home = MainViewController_inCode()
        home.mainCoordinator = self
        self.navigationController.pushViewController(home, animated: false)
    }

    func navigateToDetailVC(with model: Repo) {
        let detailVC = DetailViewController_inCode(model: model)
        detailVC.mainCoordinator = self
        self.navigationController.pushViewController(detailVC, animated: true)
    }

}
