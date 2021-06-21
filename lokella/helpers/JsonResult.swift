//
//  JsonResult.swift
//  lokella
//
//  Created by Kemal Taskin on 12.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

struct JsonResult<T: Decodable> : Decodable
{
    var Value: T;
    
    /*
    private enum CodingKeys: String, CodingKey {
        case Value = "value"
    }
    
    init() {
        value = nil;
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(T?.self, forKey: .value)
    }
 */
}
