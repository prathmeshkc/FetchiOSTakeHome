//
//  MealRepository.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import Foundation

protocol MealRepository {
    func request<T: Decodable>(endpoint: MealsAPI, returnRawData: Bool) async throws -> T
}

struct MealRepositoryImpl: MealRepository {
    func request<T>(endpoint: MealsAPI, returnRawData: Bool = false) async throws -> T where T : Decodable {
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: endpoint.urlRequest)
            
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                throw APIError.unknownDetail("MealRepositoryImpl::request -> Failed with response code: \(String(describing: urlResponse))")
            }
            
            guard (200...299).contains(httpUrlResponse.statusCode) else {
                throw APIError.errorCode(httpUrlResponse.statusCode)
            }
            
            dump(data)
            
            if returnRawData {
                if T.self == RawData.self || T.self == RawData?.self {
                    Logger.logMessage(message: "MealRepositoryImpl::request -> Returning raw JSON")
                    return RawData(data: data) as! T
                } else {
                    throw APIError.unknownDetail("MealRepositoryImpl::request -> Invalid type for raw data return: \(T.self)")
                }
            }
            
            let response = try JSONDecoder().decode(T.self, from: data)
            
            return response
            
        } catch DecodingError.dataCorrupted {
            throw APIError.decodingError
        } catch let error {
            Logger.logMessage(message: "MealRepositoryImpl::request -> Failed with error: \(String(describing: error.localizedDescription))", logType: .error)
            
            throw APIError.unknownDetail("MealRepositoryImpl::request -> Failed with error: \(String(describing: error.localizedDescription))")
        }
    }
}
