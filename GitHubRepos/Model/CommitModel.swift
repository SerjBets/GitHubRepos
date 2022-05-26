//
//  GitUsers.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation

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
