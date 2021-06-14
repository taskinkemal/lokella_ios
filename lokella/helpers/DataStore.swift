//
//  DataStore.swift
//  lokella
//
//  Created by Kemal Taskin on 12.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

final class DataStore {
    
    static func GetCustomer() -> CustomerLogin? {
        
        return UserDefaults.standard.object(forKey: "Customer") as? CustomerLogin
    }
    
    static func SetCustomer(customerLogin: CustomerLogin) {
        
        return UserDefaults.standard.set(customerLogin, forKey: "Customer")
    }
    
    static func IsCustomerVerified() -> Bool {
        
        return UserDefaults.standard.object(forKey: "IsCustomerVerified") as? Bool == true;
    }
    
    static func SetIsCustomerVerified(isVerified: Bool) {
        
        return UserDefaults.standard.set(isVerified, forKey: "IsCustomerVerified");
    }
}
