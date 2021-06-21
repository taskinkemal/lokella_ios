//
//  DataStore.swift
//  lokella
//
//  Created by Kemal Taskin on 12.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

final class DataStore {
    
    static func GetCustomer() -> Customer? {
        
        var userData: Customer!
                if let data = UserDefaults.standard.value(forKey: "Customer") as? Data {
                    userData = try? PropertyListDecoder().decode(Customer.self, from: data)
                    return userData!
                } else {
                    return userData
                }
    }
    
    static func SetCustomer(customer: Customer?) {
        
        if (customer == nil) {
            UserDefaults.standard.removeObject(forKey: "Customer");
        } else {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(customer!), forKey: "Customer");
        }
    }
    
    static func IsCustomerVerified() -> Bool {
        
        return UserDefaults.standard.object(forKey: "IsCustomerVerified") as? Bool == true;
    }
    
    static func SetIsCustomerVerified(isVerified: Bool) {
        
        UserDefaults.standard.set(isVerified, forKey: "IsCustomerVerified");
    }
}
