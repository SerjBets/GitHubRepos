//
//  UserModel.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation

struct GitUsers: Codable {
    let items: [GitUser]
}

//Author (user) of repository
struct GitUser: Codable {
    let login       : String
    let id          : Int
    let avatarUrl   : URL
    let userUrl     : URL
    let htmlUrl     : URL
    let reposUrl    : URL
    let name        : String?
    let email       : String?

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case name
        case email
        case avatarUrl  = "avatar_url"
        case htmlUrl    = "html_url"
        case userUrl    = "url"
        case reposUrl   = "repos_url"
    }
}
