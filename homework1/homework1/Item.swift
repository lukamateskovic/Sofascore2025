//
//  Item.swift
//  homework1
//
//  Created by Luka Matešković on 10.03.2025..
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
