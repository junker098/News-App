//
//  NetworkManager.swift
//  News App
//
//  Created by Юрий Могорита on 26.10.2020.
//  Copyright © 2020 Yuri Mogorita. All rights reserved.
//

import Foundation
import Alamofire


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    var doesTheInternetWork: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    //MARK: - Send request
    
    func sendRequest(searchText: String?, completion: @escaping(_ listArticleModel: Result<ListArticleModel, ErrorMessage>) -> Void) {
        let url = "https://newsapi.org/v2/everything"
        let parametrs = ["q":"\(searchText ?? "")",
                         "apiKey":"7f4dd56be43842e58c2071efdeb00dfe",
                        ]
        if doesTheInternetWork {
            guard let url = URL(string: url) else { return }
            AF.request(url, method: .get, parameters: parametrs, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    print(value)
                    guard let data = response.data else { return }
                    
                    do {
                        let list = try JSONDecoder().decode(ListArticleModel.self, from: data)
                        completion(.success(list))
                        
                    } catch {
                        completion(.failure(.invalidData))
                    }
                case .failure:
                    completion(.failure(.unableToComplete))
                }
            }
        } else {
            completion(.failure(.noInternetConnection))
        }
    }
}
