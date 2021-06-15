//
//  CatalogAdditive.swift
//  lokella
//
//  Created by Kemal Taskin on 15.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

class CatalogAdditive : BaseModel, Codable
{
    @objc public dynamic var Id: Int16 = 0
    @objc public dynamic var ShortName: String = ""
    @objc public dynamic var Name: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case ShortName = "ShortName"
        case Name = "Name"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Id = try container.decode(Int16.self, forKey: .Id)
        ShortName = try container.decode(String.self, forKey: .ShortName)
        Name = try container.decode(String.self, forKey: .Name)
    }
    
    convenience init(_ id: Int16, _ shortName: String, _ name: String) {
        self.init()
        self.Id = id
        self.ShortName = shortName
        self.Name = name
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Id": self.Id,
            "ShortName": self.ShortName,
            "Name": self.Name
        ]
    }
}
