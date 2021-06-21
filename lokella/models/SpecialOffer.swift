//
//  SpecialOffer.swift
//  lokella
//
//  Created by meisinger06 on 21.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

class SpecialOffer : BaseModel, Codable
{
    var Id: Int
    var BusinessId: Int
    var FileId: Int
    var Status: UInt8
    @objc public dynamic var DateFrom = Date()
    @objc public dynamic var DateTo = Date()
    var HourFrom: String?
    var HourTo: String?
    
    init() {
        
            self.Id = 0;
            self.BusinessId = 0;
            self.FileId = 0;
            self.Status = 0;
            self.DateFrom = Date();
            self.DateTo = Date();
            self.HourFrom = "";
            self.HourTo = "";
    }
    
    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case BusinessId = "BusinessId"
        case FileId = "FileId"
        case Status = "Status"
        case DateFrom = "DateFrom"
        case DateTo = "DateTo"
        case HourFrom = "HourFrom"
        case HourTo = "HourTo"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Id = try container.decode(Int.self, forKey: .Id)
        BusinessId = try container.decode(Int.self, forKey: .BusinessId)
        FileId = try container.decode(Int.self, forKey: .FileId)
        Status = try container.decode(UInt8.self, forKey: .Status)
        DateFrom = try container.decode(Date.self, forKey: .DateFrom)
        DateTo = try container.decode(Date.self, forKey: .DateTo)
        HourFrom = try container.decode(String?.self, forKey: .HourFrom)
        HourTo = try container.decode(String?.self, forKey: .HourTo)
    }
    
    convenience init(_ id: Int, _ businessId: Int, fileId: Int, status: UInt8, dateFrom: Date,
                     dateTo: Date, hourFrom: String?, hourTo: String?) {
        self.init()
        self.Id = id
        self.BusinessId = businessId
        self.FileId = fileId
        self.Status = status
        self.DateFrom = dateFrom
        self.DateTo = dateTo
        self.HourFrom = hourFrom
        self.HourTo = hourTo
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Id": self.Id,
            "BusinessId": self.BusinessId,
            "FileId": self.FileId,
            "Status": self.Status,
            "DateFrom": DateFormatter.iso8601DateOnly.string(from: self.DateFrom),
            "DateTo": DateFormatter.iso8601DateOnly.string(from: self.DateTo),
            "HourFrom": self.HourFrom,
            "HourTo": self.HourTo
        ]
    }
}
