//
//  Article.swift
//  WeatherAppTest
//
//  Created by Vinay on 8/2/18.
//  Copyright © 2018 iOSApp. All rights reserved.
//

import UIKit

class Article {
    var author: String?
    var description: String?
    var publishedAt: String?
//    var source: Dictionary<String, String>?
    var title: String?
    var url: String?
    var urlToImage: String?
   
    
    init(dict:[AnyHashable :Any]?){
        self.author = dict?["author"] as? String
        self.description = dict?["description"] as? String
        self.publishedAt = dict?["publishedAt"] as? String
        self.title = dict?["title"] as? String
        self.url = dict?["url"] as? String
        self.urlToImage = dict?["urlToImage"] as? String
    }
}
