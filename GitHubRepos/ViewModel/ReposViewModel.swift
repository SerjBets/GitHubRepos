//
//  ReposViewModel.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation

class ReposViewModel: NSObject {
    var reposList = [Repo]()
    
    private func getStarRepos() {
        APICaller.shared.fetchStarsRepos(with: Endpoints.reposUrlString) { results in
            switch results {
            case .success(let repos):
                self.reposList = repos.items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
