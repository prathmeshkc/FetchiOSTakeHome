//
//  DeveloperPreview.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import Foundation

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let meals = [
        Meal(id: "53049", mealName: "Apam balik", imageURL: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"),
        
        Meal(id: "52893", mealName: "Apple & Blackberry Crumble", imageURL: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg"),
        
        Meal(id: "52768", mealName: "Apple Frangipan Tart", imageURL: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg"),
        
        Meal(id: "52767", mealName: "Bakewell tart", imageURL: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg"),
        
        Meal(id: "52855", mealName: "Banana Pancakes", imageURL: "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg"),
        
        Meal(id: "52894", mealName: "Battenberg Cake", imageURL: "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg"),
        
        Meal(id: "52928", mealName: "BeaverTails", imageURL: "https://www.themealdb.com/images/media/meals/ryppsv1511815505.jpg"),
        
        Meal(id: "52891", mealName: "Blackberry Fool", imageURL: "https://www.themealdb.com/images/media/meals/rpvptu1511641092.jpg"),
        
        Meal(id: "52792", mealName: "Bread and Butter Pudding", imageURL: "https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg"),
        
        Meal(id: "52961", mealName: "Budino Di Ricotta", imageURL: "https://www.themealdb.com/images/media/meals/1549542877.jpg"),
        
        Meal(id: "52923", mealName: "Canadian Butter Tarts", imageURL: "https://www.themealdb.com/images/media/meals/wpputp1511812960.jpg")
        
    ]
}
