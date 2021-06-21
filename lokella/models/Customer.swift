//
//  Customer.swift
//  lokella
//
//  Created by Kemal Taskin on 12.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

class Customer : BaseModel, Codable
{
    var Id: Int
    var Email: String
    var FirstName: String
    var LastName: String
    var PhoneNumber: String
    var DeviceId: String
    
    init() {
        
            self.Id = 0;
            self.Email = "";
            self.FirstName = "";
            self.LastName = "";
            self.PhoneNumber = "";
            self.DeviceId = "";
    }
    
    init(Email: String, FirstName: String, LastName: String,
         PhoneNumber: String, DeviceId: String)
    {
        self.Id = 0;
        self.Email = Email;
        self.FirstName = FirstName;
        self.LastName = LastName;
        self.PhoneNumber = PhoneNumber;
        self.DeviceId = DeviceId;
    }
    
    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Email = "Email"
        case FirstName = "FirstName"
        case LastName = "LastName"
        case PhoneNumber = "PhoneNumber"
        case DeviceId = "DeviceId"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Id = try container.decode(Int.self, forKey: .Id)
        Email = try container.decode(String.self, forKey: .Email)
        FirstName = try container.decode(String.self, forKey: .FirstName)
        LastName = try container.decode(String.self, forKey: .LastName)
        PhoneNumber = try container.decode(String.self, forKey: .PhoneNumber)
        DeviceId = try container.decode(String.self, forKey: .DeviceId)
    }
    
    convenience init(_ id: Int, _ email: String, firstName: String, lastName: String, phoneNumber: String,
                     deviceId: String) {
        self.init()
        self.Id = id
        self.Email = email
        self.FirstName = firstName
        self.LastName = lastName
        self.PhoneNumber = phoneNumber
        self.DeviceId = deviceId
    }
    
    func GetFullName() -> String {
        
        return FirstName + " " + LastName
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Id": self.Id,
            "Email": self.Email,
            "FirstName": self.FirstName,
            "LastName": self.LastName,
            "PhoneNumber": self.PhoneNumber,
            "DeviceId": self.DeviceId
        ]
    }
}

struct ListWrapper<T : Codable> : Codable
{
    var Items: [T]
    var Count: Int?
    
    /*
     enum CodingKeys : String, CodingKey
     {
     case Items = "Items"
     case Count = "Count"
     }
     */
}
/*
class Customer : Object, Codable, BaseModel
{
    @objc public dynamic var Id = 0
    @objc public dynamic var Email = ""
    @objc public dynamic var FirstName = ""
    @objc public dynamic var LastName = ""
    @objc public dynamic var PhoneNumber = ""
    
    override class func primaryKey() -> String? { return "Id" }
    
    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Email = "Email"
        case FirstName = "FirstName"
        case LastName = "LastName"
        case PhoneNumber = "PhoneNumber"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Id = try container.decode(Int.self, forKey: .Id)
        Email = try container.decode(String.self, forKey: .Email)
        FirstName = try container.decode(String.self, forKey: .FirstName)
        LastName = try container.decode(String.self, forKey: .LastName)
        PhoneNumber = try container.decode(String.self, forKey: .PhoneNumber)
    }
    
    convenience init(_ id: Int, _ label: String, email: String, firstName: String,
                     lastName: String, phoneNumber: String) {
        self.init()
        self.Id = id
        self.Email = email
        self.FirstName = firstName
        self.LastName = lastName
        self.PhoneNumber = phoneNumber
    }
    
    func toJSON() -> NSDictionary {
        return [
            "Id": self.Id,
            "Email": self.Email,
            "FirstName": self.FirstName,
            "LastName": self.LastName,
            "PhoneNumber": self.PhoneNumber
        ]
    }
}
*/
