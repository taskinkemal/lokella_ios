//
//  MenuCategory.swift
//  lokella
//
//  Created by Kemal Taskin on 13.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

class MenuCategory : BaseModel, Codable
{
    @objc public dynamic var Id: Int = 0
    @objc public dynamic var BusinessId: Int = 0
    @objc public dynamic var Name: String = ""
    @objc public dynamic var ItemOrder: Int = 0
    var ParentId: Int?

    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case BusinessId = "BusinessId"
        case Name = "Name"
        case ItemOrder = "ItemOrder"
        case ParentId = "ParentId"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Id = try container.decode(Int.self, forKey: .Id)
        BusinessId = try container.decode(Int.self, forKey: .BusinessId)
        Name = try container.decode(String.self, forKey: .Name)
        ItemOrder = try container.decode(Int.self, forKey: .ItemOrder)
        ParentId = try container.decode(Int?.self, forKey: .ParentId)
    }
    
    convenience init(_ id: Int, _ businessId: Int, _ name: String, itemOrder: Int, parentId: Int?) {
        self.init()
        self.Id = id
        self.BusinessId = businessId
        self.Name = name
        self.ItemOrder = itemOrder
        self.ParentId = parentId
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Id": self.Id,
            "BusinessId": self.BusinessId,
            "Name": self.Name,
            "ItemOrder": self.ItemOrder,
            "ParentId": self.ParentId
        ]
    }
}
