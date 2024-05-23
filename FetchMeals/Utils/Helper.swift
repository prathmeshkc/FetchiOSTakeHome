//
//  Helper.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import Foundation

class Helper {
    
    public static func formatInstructionDescription(instructions: String) -> String {
        return instructions.replacingOccurrences(of: "\r\n", with: "\n")
    }
    
    public static func sortMealsByName(meals: [Meal]) -> [Meal] {
        return meals.sorted { $0.mealName.lowercased() < $1.mealName.lowercased() }
    }
    
    public static func getMealDetailFromJson(jsonData: Any) -> MealDetail? {
        
        guard let json = jsonData as? [String: Any],
              let meals = json["meals"] as? [[String: Any]],
              let meal = meals.first
        else {
            return nil
        }
        
        guard let name = meal["strMeal"] as? String,
              let instructions = meal["strInstructions"] as? String else {
            return nil
        }
        
        var ingredients: [Ingredient] = []
        
        for i in 1...20 {
            if let ingredient = meal["strIngredient\(i)"] as? String, !ingredient.isEmpty,
               let measure = meal["strMeasure\(i)"] as? String, !measure.isEmpty {
                ingredients.append(Ingredient(name: ingredient, measurement: measure))
            }
        }
        
        return MealDetail(name: name, instructions: instructions, ingredients: ingredients)
    }
}
