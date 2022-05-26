//
//  RepoModel.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation

//Array of repositories
struct Repos: Codable {
    let items: [Repo]
}

//Repository
struct Repo: Codable {
    let id          : Int
    let name        : String
    let fullName    : String
    let owner       : GitUser
    let htmlUrl     : URL
    let description : String?
    let commitsUrl  : String
    let starsCount  : Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName    = "full_name"
        case owner
        case htmlUrl     = "html_url"
        case description
        case commitsUrl  = "commits_url"
        case starsCount  = "stargazers_count"
    }
}
