//
//  MealDetails.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import Foundation


struct MealDetail: Decodable {
    let name: String
    let instructions: String
    let ingredients: [Ingredient]
}

struct Ingredient: Decodable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let measurement: String
}
