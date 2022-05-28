//
//  CommitsViewModel.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import UIKit

class CommitsViewModel: NSObject {
    var commitsList = [Commit]()
    
    func getCommits() {
        APICaller.shared.fetchCommits(with: Endpoints.commitsUrlString) { results in
            switch results {
            case .success(let commits):
                self.commitsList = commits
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
