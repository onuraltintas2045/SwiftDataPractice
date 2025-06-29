//
//  Item.swift
//  SwiftDataPractice
//
//  Created by Onur Altintas on 29.06.2025.
//

import Foundation
import SwiftData

@Model
final class Item: Identifiable {
    var id: UUID
    var name: String
    var createdDate: Date
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.createdDate = Date()
    }
}
