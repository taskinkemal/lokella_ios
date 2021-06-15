//
//  CatalogMenuItemTag.swift
//  lokella
//
//  Created by Kemal Taskin on 15.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

class CatalogMenuItemTag : BaseModel, Codable
{
    @objc public dynamic var Id: Int16 = 0
    @objc public dynamic var Name: String = ""
    @objc public dynamic var PhotoId: Int = 0
    @objc public dynamic var ItemOrder: Int16 = 0
    
    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Name = "Name"
        case PhotoId = "PhotoId"
        case ItemOrder = "ItemOrder"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Id = try container.decode(Int16.self, forKey: .Id)
        Name = try container.decode(String.self, forKey: .Name)
        PhotoId = try container.decode(Int.self, forKey: .PhotoId)
        ItemOrder = try container.decode(Int16.self, forKey: .ItemOrder)
    }
    
    convenience init(_ id: Int16, _ name: String, photoId: Int, itemOrder: Int16) {
        self.init()
        self.Id = id
        self.Name = name
        self.PhotoId = photoId
        self.ItemOrder = itemOrder
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Id": self.Id,
            "Name": self.Name,
            "PhotoId": self.PhotoId,
            "ItemOrder": self.ItemOrder
        ]
    }
}
