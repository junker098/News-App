//
//  ListArticleModel.swift
//  News App
//
//  Created by Юрий Могорита on 26.10.2020.
//  Copyright © 2020 Yuri Mogorita. All rights reserved.
//

import Foundation

struct ListArticleModel: Decodable {

    let articles: [Articles]

    enum CodingKeys: String, CodingKey {
      case articles
    }
}

struct Articles: Decodable  {
    
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    
    enum CodingKeys: String, CodingKey {
      case title
    case description
        case url
        case urlToImage
    }
}
