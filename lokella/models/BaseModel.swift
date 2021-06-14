//
//  BaseModel.swift
//  lokella
//
//  Created by Kemal Taskin on 12.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import Foundation

protocol BaseModel
{
    func toJSON() -> NSDictionary
}
