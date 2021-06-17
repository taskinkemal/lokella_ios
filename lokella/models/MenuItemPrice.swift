//
//  MenuItemPrice.swift
//  lokella
//
//  Created by Kemal Taskin on 15.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

class MenuItemPrice : BaseModel, Codable
{
    @objc public dynamic var Id: Int = 0
    @objc public dynamic var MenuItemId: Int = 0
    var Unit: String?
    var Quantity: Decimal?
    @objc public dynamic var Price: Decimal = 0
    
    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case MenuItemId = "MenuItemId"
        case Unit = "Unit"
        case Quantity = "Quantity"
        case Price = "Price"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        MenuItemId = try container.decode(Int.self, forKey: .MenuItemId)
        Unit = try container.decode(String?.self, forKey: .Unit)
        Quantity = try container.decode(Decimal?.self, forKey: .Quantity)
        Price = try container.decode(Decimal.self, forKey: .Price)
    }
    
    convenience init(_ id: Int, _ menuItemId: Int, _ unit: String?, quantity: Decimal?, price: Decimal) {
        self.init()
        self.Id = id
        self.MenuItemId = menuItemId
        self.Unit = unit
        self.Quantity = quantity
        self.Price = price
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Id": self.Id,
            "MenuItemId": self.MenuItemId,
            "Unit": self.Unit,
            "Quantity": self.Quantity,
            "Price": self.Price
        ]
    }
    
    func toString() -> String {

        var text = "";
        
        if (self.Quantity != nil) {
            text += self.Quantity!.formattedAmount ?? "";
            text += " ";
        }
        
        if (self.Unit != nil) {
            text += self.Unit!;
            text += " ";
        }
        
        if (text.count > 0) {
            text += "| ";
        }
        
        text += self.Price.formattedAmount ?? "";
        
        return text;
    }
}
