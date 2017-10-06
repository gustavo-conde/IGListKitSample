//
//  Posts.swift
//  OLX Feed Sample
//
//  Created by Gustavo Conde on 10/5/17.
//  Copyright © 2017 Gustavo Conde. All rights reserved.
//

import ObjectMapper
import IGListKit

class Posts: Mappable {
    
    var posts = [Post]()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        posts   <- map["data"]
    }
    
}

class Post {
    
    var title = ""
    var description = ""
    var creationYear = 0
    var creationMonth = 0
    var creationDay = 0
    var carPicture = ""
    
    required init?(map: Map) {
        
    }
}

extension Post: Mappable {
    
    func mapping(map: Map) {
        title           <- map["title"]
        description     <- map["description"]
        carPicture      <- map["mediumImage"]
        creationYear    <- map["date.year"]
        creationMonth   <- map["date.month"]
        creationDay     <- map["date.day"]
    }
}

extension Post: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return (title + String(creationDay) + String(creationMonth)).hashValue as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? Post {
            return object.title == self.title && object.description == self.description
        }
        return false
    }
}
