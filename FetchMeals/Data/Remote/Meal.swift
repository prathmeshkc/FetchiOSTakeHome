//
//  Meals.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import Foundation


struct MealFeed: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable, Identifiable {
    let id: String
    let mealName: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case mealName = "strMeal"
        case imageURL = "strMealThumb"
    }
}
