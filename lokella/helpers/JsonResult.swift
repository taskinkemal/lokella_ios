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
    var value: T
}
