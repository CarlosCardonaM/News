//
//  Article.swift
//  News
//
//  Created by Carlos Cardona on 20/05/20.
//  Copyright © 2020 D O G. All rights reserved.
//

import Foundation

struct Article: Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
}
