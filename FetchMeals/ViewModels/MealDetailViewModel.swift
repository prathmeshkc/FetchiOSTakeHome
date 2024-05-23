//
//  MealDetailViewModel.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    
    let mealRepository: MealRepository
    
    @Published private(set) var resultState: APIResultState<MealDetail> = .idle
    
    var mealId: String?
    
    init(mealRepository: MealRepository = MealRepositoryImpl(), mealId: String? = nil) {
        self.mealRepository = mealRepository
        self.mealId = mealId
        getMealDetailsById(mealId: mealId ?? "52891")
    }
    
    
    func getMealDetailsById(mealId: String) {
        self.resultState = .loading
        Task { [weak self] in
            do {
                let rawData: RawData? = try await self?.mealRepository.request(endpoint: .getMealDetails(mealId: mealId), returnRawData: true)
                
                guard let rawData else {
                    self?.resultState = .failed(error: APIError.unknownDetail("Failed to get meal details for id: \(mealId)"))
                    
                    Logger.logMessage(message: "MealDetailViewModel::getMealDetailsById -> Failed to get meal details for id: \(mealId)", logType: .error)
                    
                    return
                }
                
                let jsonData = try JSONSerialization.jsonObject(with: rawData.data)
                
                guard let mealDetail = Helper.getMealDetailFromJson(jsonData: jsonData) else {
                    self?.resultState = .failed(error: APIError.decodingError)
                    Logger.logMessage(message: "MealDetailViewModel::getMealDetailsById -> Failed to parse json for meal details for id: \(mealId)", logType: .error)
                    return
                }
                
                self?.resultState = .success(content: mealDetail)
                
                dump(mealDetail)
                
            } catch let error {
                self?.resultState = .failed(error: error)
                Logger.logMessage(message: "MealDetailViewModel::getMealDetailsById -> Caught Exception: \(error)", logType: .error)
            }
        }
    }
}
