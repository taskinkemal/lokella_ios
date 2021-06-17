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
    var Category: MenuCategory = MenuCategory()
    var Prices: [MenuItemPrice] = []
    var Additives: [CatalogAdditive] = []
    var Allergies: [CatalogAllergy] = []
    var Tags: [CatalogMenuItemTag] = []
    
    private enum CodingKeys: String, CodingKey {
        case Item = "Item"
        case Category = "Category"
        case Prices = "Prices"
        case Additives = "Additives"
        case Allergies = "Allergies"
        case Tags = "Tags"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        Item = try container.decode(MenuItem.self, forKey: .Item)
        Category = try container.decode(MenuCategory.self, forKey: .Category)
        
        let pricesArray = try container.decode([MenuItemPrice].self, forKey: .Prices)
        pricesArray.forEach{ Prices.append($0) }
        
        let additivesArray = try container.decode([CatalogAdditive].self, forKey: .Additives)
        additivesArray.forEach{ Additives.append($0) }
        
        let allergiesArray = try container.decode([CatalogAllergy].self, forKey: .Allergies)
        allergiesArray.forEach{ Allergies.append($0) }
        
        let tagsArray = try container.decode([CatalogMenuItemTag].self, forKey: .Tags)
        tagsArray.forEach{ Tags.append($0) }
    }
    
    convenience init(_ item: MenuItem, _ category: MenuCategory, _ prices: [MenuItemPrice],
                     _ additives: [CatalogAdditive],
                     allergies: [CatalogAllergy],
                     tags: [CatalogMenuItemTag]) {
        self.init()
        self.Item = item
        self.Category = category
        self.Prices = prices
        self.Additives = additives
        self.Allergies = allergies
        self.Tags = tags
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Item": self.Item,
            "Category": self.Category,
            "Prices": self.Prices,
            "Additives": self.Additives,
            "Allergies": self.Allergies,
            "Tags": self.Tags
        ]
    }
    
    func getAdditivesAllergiesSummary() -> String {
        
        var arrAdditives: [String] = [];
        var arrAllergies: [String] = [];
        
        for item in self.Additives {
            arrAdditives.append(item.ShortName);
        }
        
        arrAdditives.sort();
        
        for item in self.Allergies {
            arrAllergies.append(item.ShortName);
        }
        
        arrAllergies.sort();
        
        arrAdditives.append(contentsOf: arrAllergies);
        arrAdditives = arrAdditives.uniqued();
        
        return (arrAdditives.map{String($0)}).joined(separator: ",");
    }
    

}
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
