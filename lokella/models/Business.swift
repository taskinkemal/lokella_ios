//
//  Business.swift
//  lokella
//
//  Created by Kemal Taskin on 13.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

class Business : BaseModel, Codable
{
    @objc public dynamic var Id: Int = 0
    @objc public dynamic var Name: String = ""
    @objc public dynamic var Level: Int16 = 0
    @objc public dynamic var Category: Int16 = 0
    @objc public dynamic var LogoId: Int = 0
    @objc public dynamic var QrCodeId: Int = 0
    @objc public dynamic var BackgroundColor: String = ""
    @objc public dynamic var FontColor: String = ""
    @objc public dynamic var MenuSectionColor: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Name = "Name"
        case Level = "Level"
        case Category = "Category"
        case LogoId = "LogoId"
        case QrCodeId = "QrCodeId"
        case BackgroundColor = "BackgroundColor"
        case FontColor = "FontColor"
        case MenuSectionColor = "MenuSectionColor"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Id = try container.decode(Int.self, forKey: .Id)
        Name = try container.decode(String.self, forKey: .Name)
        Level = try container.decode(Int16.self, forKey: .Level)
        Category = try container.decode(Int16.self, forKey: .Category)
        LogoId = try container.decode(Int.self, forKey: .LogoId)
        QrCodeId = try container.decode(Int.self, forKey: .QrCodeId)
        BackgroundColor = try container.decode(String.self, forKey: .BackgroundColor)
        FontColor = try container.decode(String.self, forKey: .FontColor)
        MenuSectionColor = try container.decode(String.self, forKey: .MenuSectionColor)
    }
    
    convenience init(_ id: Int, _ name: String, level: Int16, category: Int16, logoId: Int,
                     qrCodeId: Int, backgroundColor: String, fontColor: String, menuSectionColor: String) {
        self.init()
        self.Id = id
        self.Name = name
        self.Level = level
        self.Category = category
        self.LogoId = logoId
        self.QrCodeId = qrCodeId
        self.BackgroundColor = backgroundColor
        self.FontColor = fontColor
        self.MenuSectionColor = menuSectionColor
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Id": self.Id,
            "Name": self.Name,
            "Level": self.Level,
            "Category": self.Category,
            "LogoId": self.LogoId,
            "QrCodeId": self.QrCodeId,
            "BackgroundColor": self.BackgroundColor,
            "FontColor": self.FontColor,
            "MenuSectionColor": self.MenuSectionColor
        ]
    }
}
