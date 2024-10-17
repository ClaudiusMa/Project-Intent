//
//  Item.swift
//  Intent
//
//  Created by Claudius Ma on 10/15/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date = Date.now
    var userIntent: String = "I want to ..."
    
    init( userIntent: String) {
        self.userIntent = userIntent
    }
}
