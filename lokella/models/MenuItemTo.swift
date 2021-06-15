//
//  MenuItemTo.swift
//  lokella
//
//  Created by Kemal Taskin on 15.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

class MenuItemTo : BaseModel, Codable
{
    var Item: MenuItem = MenuItem()
    var Prices: [MenuItemPrice] = []
    var Additives: [CatalogAdditive] = []
    var Allergies: [CatalogAllergy] = []
    var Tags: [CatalogMenuItemTag] = []
    
    private enum CodingKeys: String, CodingKey {
        case Item = "Item"
        case Prices = "Prices"
        case Additives = "Additives"
        case Allergies = "Allergies"
        case Tags = "Tags"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        Item = try container.decode(MenuItem.self, forKey: .Item)
        
        let pricesArray = try container.decode([MenuItemPrice].self, forKey: .Prices)
        pricesArray.forEach{ Prices.append($0) }
        
        let additivesArray = try container.decode([CatalogAdditive].self, forKey: .Additives)
        additivesArray.forEach{ Additives.append($0) }
        
        let allergiesArray = try container.decode([CatalogAllergy].self, forKey: .Allergies)
        allergiesArray.forEach{ Allergies.append($0) }
        
        let tagsArray = try container.decode([CatalogMenuItemTag].self, forKey: .Tags)
        tagsArray.forEach{ Tags.append($0) }
        
    }
    
    convenience init(_ item: MenuItem, _ prices: [MenuItemPrice],
                     _ additives: [CatalogAdditive],
                     allergies: [CatalogAllergy],
                     tags: [CatalogMenuItemTag]) {
        self.init()
        self.Item = item
        self.Prices = prices
        self.Additives = additives
        self.Allergies = allergies
        self.Tags = tags
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Item": self.Item,
            "Prices": self.Prices,
            "Additives": self.Additives,
            "Allergies": self.Allergies,
            "Tags": self.Tags
        ]
    }
}
