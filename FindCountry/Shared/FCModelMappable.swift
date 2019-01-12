//
//  FCModelMappable.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 06/05/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol FCModelMappable {
    init?(json: JSON)
}
