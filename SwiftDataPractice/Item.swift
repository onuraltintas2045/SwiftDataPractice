//
//  Item.swift
//  SwiftDataPractice
//
//  Created by Onur Altintas on 29.06.2025.
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
