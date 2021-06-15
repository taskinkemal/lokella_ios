//
//  MenuItem.swift
//  lokella
//
//  Created by Kemal Taskin on 15.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

class MenuItem : BaseModel, Codable
{
    @objc public dynamic var Id: Int = 0
    @objc public dynamic var Name: String = ""
    @objc public dynamic var Description: String = ""
    @objc public dynamic var CategoryId: Int = 0
    @objc public dynamic var PhotoId: Int = 0
    @objc public dynamic var ItemOrder: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Name = "Name"
        case Description = "Description"
        case CategoryId = "CategoryId"
        case PhotoId = "PhotoId"
        case ItemOrder = "ItemOrder"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Id = try container.decode(Int.self, forKey: .Id)
        Name = try container.decode(String.self, forKey: .Name)
        Description = try container.decode(String.self, forKey: .Description)
        CategoryId = try container.decode(Int.self, forKey: .CategoryId)
        PhotoId = try container.decode(Int.self, forKey: .PhotoId)
        ItemOrder = try container.decode(Int.self, forKey: .ItemOrder)
    }
    
    convenience init(_ id: Int, _ name: String, _ description: String,
                     _ categoryId: Int, photoId: Int, itemOrder: Int) {
        self.init()
        self.Id = id
        self.Name = name
        self.Description = description
        self.CategoryId = categoryId
        self.PhotoId = photoId
        self.ItemOrder = itemOrder
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Id": self.Id,
            "Name": self.Name,
            "Description": self.Description,
            "CategoryId": self.CategoryId,
            "PhotoId": self.PhotoId,
            "ItemOrder": self.ItemOrder
        ]
    }
}
