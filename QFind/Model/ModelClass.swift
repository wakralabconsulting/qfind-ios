//
//  ModelClass.swift
//  QFind
//
//  Created by Exalture on 25/01/18.
//  Copyright © 2018 QFind. All rights reserved.
//

import Foundation

//struct TokenData: Codable {
//    var accessToken: String
//
//}
//extension TokenData{
//    enum CodingKeys: String, CodingKey {
//        case accessToken = "result"
//    }
//}
struct TokenData: ResponseObjectSerializable {
    var accessToken: String? = nil

    public init?(response: HTTPURLResponse, representation: AnyObject) {
        if let representation = representation as? [String: Any] {
            self.accessToken = representation["result"] as? String

        }
    }
}

struct CategoryData: ResponseObjectSerializable {
        var categoryData: [Category]? = []
    
        public init?(response: HTTPURLResponse, representation: AnyObject) {
            if let data = representation["result"] as? [[String: Any]] {
                self.categoryData = Category.collection(response: response, representation: data as AnyObject )
            }
        }
}

struct Category: ResponseObjectSerializable, ResponseCollectionSerializable {
    var categories_id: Int? = nil
    var categories_imge: String? = nil
    var categories_name: String? = nil
    
   

    public init?(response: HTTPURLResponse, representation: AnyObject) {
        if let representation = representation as? [String: Any] {
            self.categories_id = representation["categories_id"] as? Int
            self.categories_imge = representation["categories_imge"] as? String
            self.categories_name = representation["categories_name"] as? String
            
            
            
        }
    }
}
struct SubCategoryData: ResponseObjectSerializable {
    var subCategoryData: [SubCategory]? = []
    var code:  String? = nil
    var response: String? = nil
    
    public init?(response: HTTPURLResponse, representation: AnyObject) {
        print(representation)
        if let representationData = representation as? [String: Any] {
            print(representationData)
            self.code = representationData["code"] as? String
            
            self.response = representationData["response"] as? String
            
        }
        if let data = representation["result"] as? [[String: Any]] {
           
            self.subCategoryData = SubCategory.collection(response: response, representation: data as AnyObject )
        }
        
        
    }
}

struct SubCategory: ResponseObjectSerializable, ResponseCollectionSerializable {
    var sub_categories_id: Int? = nil
    var sub_categories_imge: String? = nil
    var sub_categories_name: String? = nil
    var sub_categories_description: String? = nil
    
    
    public init?(response: HTTPURLResponse, representation: AnyObject) {
        if let representation = representation as? [String: Any] {
            self.sub_categories_id = representation["sub_categories_id"] as? Int
            self.sub_categories_imge = representation["sub_categories_imge"] as? String
            self.sub_categories_name = representation["sub_categories_name"] as? String
            self.sub_categories_description = representation["sub_categories_description"] as? String
           
            
        }
       
    }
}
//
//
//struct Badge: ResponseObjectSerializable, ResponseCollectionSerializable {
//    var id: String? = nil
//    var userId: String? = nil
//    var name: String? = nil
//    var key: String? = nil
//    var createdAt: NSDate? = nil
//    var limit: Int? = nil
//
//    public init?(response: HTTPURLResponse, representation: AnyObject) {
//        if let representation = representation as? [String: Any] {
//            self.id = representation["id"] as? String
//            self.userId = representation["user_id"] as? String
//            self.name = representation["name"] as? String
//            self.key = representation["key"] as? String
//            if let createdAtVal = representation["created_at"] as? NSString {
//                self.createdAt = NSDate(timeIntervalSince1970: createdAtVal.doubleValue / 1000)
//            }
//            if let limitVal = representation["limit"] as? Int {
//                self.limit = limitVal
//            }
//        }
//    }
//}
//
//struct TargetPlayer: ResponseObjectSerializable {
//    var targetPlayers: [PlayerData]? = []
//
//    public init?(response: HTTPURLResponse, representation: AnyObject) {
//        if let data = representation as? [[String: Any]] {
//            self.targetPlayers = PlayerData.collection(response: response, representation: data as AnyObject)
//        }
//    }
//}
//
//struct Badges: ResponseObjectSerializable {
//    var badges: [Badge]? = []
//
//    public init?(response: HTTPURLResponse, representation: AnyObject) {
//        if let data = representation as? [[String: Any]] {
//            self.badges = Badge.collection(response: response, representation: data as AnyObject)
//        }
//    }
//}
//
//struct ShootResponse: ResponseObjectSerializable {
//    var strikesLeft: Int? = nil
//    var badgesGained: Int? = nil
//    var pointsEarned: Int? = nil
//
//    public init?(response: HTTPURLResponse, representation: AnyObject) {
//        if let representation = representation as? [String: Any] {
//            if let strikesBal = representation["strikes_left"] as? Int {
//                self.strikesLeft = strikesBal
//            }
//            if let badges = representation["badges_gained"] as? Int {
//                self.badgesGained = badges
//            }
//            if let points = representation["points_gained"] as? Int {
//                self.pointsEarned = points
//            }
//        }
//    }
//}

