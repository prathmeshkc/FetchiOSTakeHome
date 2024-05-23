//
//  MealViewModel.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import Foundation

@MainActor
class MealFeedViewModel: ObservableObject {
    
    private let mealRepository: MealRepository
    
    @Published private(set) var resultState: APIResultState<[Meal]> = .idle
    
    init(mealRepository: MealRepository = MealRepositoryImpl()) {
        self.mealRepository = mealRepository
        getAllMeals()
    }
    
    
    func getAllMeals() {
        self.resultState = .loading
        Task { [weak self] in
            do {
                
                let mealFeed: MealFeed? = try await self?.mealRepository.request(endpoint: .getAllMeals(category: .dessert), returnRawData: false)
                
                guard let mealFeed else {
                    
                    self?.resultState = .failed(error: APIError.unknownDetail("Failed to get meals"))
                    
                    Logger.logMessage(message: "MealFeedViewModel::getAllMeals -> Failed to get meals", logType: .error)
                    
                    return
                    
                }
                
                self?.resultState = .success(content: Helper.sortMealsByName(meals: mealFeed.meals))
                dump(mealFeed.meals)
            } catch let error {
                self?.resultState = .failed(error: error)
                Logger.logMessage(message: "MealFeedViewModel::getAllMeals -> Caught Exception: \(error)", logType: .error)
            }
        }
    }
}
