//
//  APICaller.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation
import Alamofire

class APICaller {
    static let shared = APICaller()
    
    func fetchStarsRepos(with urlString: String, completion: @escaping (Result<Repos, ConnectionErrors>) -> Void) {
        let params = ["q"    : "stars:>=10000",
                      "sort" : "stars",
                      "order": "desc"
        ]
        
        guard let url = URL(string: urlString) else { return }
        let _ = AF.request(url, method: .get, parameters: params).validate().response { response in
            guard let data = response.data else {
                completion(.failure(.noData))
                return
            }
            do {
                let repos = try JSONDecoder().decode(Repos.self, from: data)
                completion(.success(repos))
            } catch {
                print("error: ", error)
            }
        }
    }
    
    func fetchCommits(with urlString: String, completion: @escaping (Result<[Commit], ConnectionErrors>) ->Void) {
        guard let url = URL(string: urlString) else { return }
        let _ = AF.request(url, method: .get).validate().response { response in
//               print(response.request)
//               print(response.response)
//               print(response.data)
//               print(response.result)
            guard let data = response.data else {
                completion(.failure(.noData))
                return
            }
            do {
                let commits = try JSONDecoder().decode([Commit].self, from: data)
                completion(.success(commits))
            } catch {
                print("error: ", error)
            }
        }
    }
    
}
