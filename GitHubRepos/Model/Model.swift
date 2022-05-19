//
//  GitUsers.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation

struct Constants {
    static let MainNibName = "RepoTableViewCell"
    static let DetailNibName = "CommitTableViewCell"
    static let segue   = "detailSegue"
    static let userUrlString = "https://api.github.com/search/users"
    static let reposUrlString = "https://api.github.com/search/repositories?"
    static let commitsUrlString = "https://api.github.com/repos/freeCodeCamp/freeCodeCamp/commits"
}

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

// Array of commits
struct Commit: Codable {
    let sha       : String
    let commit    : CommitDetails
    let url       : URL
    let htmlUrl   : URL
    let author    : GitUser
    let committer : GitUser
    
    enum CodingKeys: String, CodingKey {
        case sha
        case commit
        case url
        case htmlUrl = "html_url"
        case author
        case committer
    }
}

// Commit detail informarion
struct CommitDetails: Codable {
    let author    : AuthorOfCommit
    let committer : Commiter
    let message   : String
}

// Author
struct AuthorOfCommit: Codable {
    let name  : String
    let email : String
    let data  : Data?
}

// Committer
struct Commiter: Codable {
    let name  : String
    let email : String
    let data  : Data?
}
