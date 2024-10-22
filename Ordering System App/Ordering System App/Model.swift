//
//  Model.swift
//  Ordering System App
//
//  Created by hungwei on 2024/10/22.
//

import Foundation

struct FoodItem: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var price: Int
    var imageName: String
    var quantity: Int = 1
}
