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

class Post: Mappable, ListDiffable {
    
    var title = ""
    var description = ""
    var creationDate = ""
    var carPicture = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title           <- map["title"]
        description     <- map["description"]
        carPicture      <- map["fullImage"]
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return (title + creationDate).hashValue as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? Post {
            return object.title == self.title && object.description == self.description
        }
        return false
    }
}
