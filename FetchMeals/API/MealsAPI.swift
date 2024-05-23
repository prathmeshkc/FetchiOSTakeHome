//
//  MealsAPI.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}



protocol APIBuilder {
    var baseUrl: URL { get }
    var urlRequest: URLRequest { get }
}

enum APIResultState<T: Decodable> {
    case idle
    case loading
    case failed(error: Error)
    case success(content: T)
}

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
    case unknownDetail(String)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .decodingError:
                return "Failed to decode the error from the service"
            case .errorCode(let code):
                return "Status Code - \(code)"
            case .unknown:
                return "Unknwon Error Occured!"
            case .unknownDetail(let description):
                return description
        }
    }
}

enum MealsAPI {
    case getAllMeals(category: MealCategory)
    case getMealDetails(mealId: String)
}

extension MealsAPI: APIBuilder {
    var baseUrl: URL {
        return URL(string: BASE_URL)!
    }
    
    var urlRequest: URLRequest {
        switch self {
            case .getAllMeals(let category):
                var urlComponents = URLComponents(url: self.baseUrl.appending(path: "filter.php"), resolvingAgainstBaseURL: true)
                let categoryQueryItem = URLQueryItem(name: "c", value: category.rawValue)
                urlComponents?.queryItems = [categoryQueryItem]
                
                guard let url = urlComponents?.url else {
                    Logger.logMessage(message: "MealsAPI::getAllMeals -> Cannot get URL from URL Components!", logType: .error)
                    return URLRequest(url: URL(string: "")!)
                }
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.GET.rawValue
                
                Logger.logMessage(message: "MealsAPI::getAllMeals -> URL - \(urlRequest)")
                
                return urlRequest
                
            case .getMealDetails(let mealId):
                var urlComponents = URLComponents(url: self.baseUrl.appending(path: "lookup.php"), resolvingAgainstBaseURL: true)
                let mealIdQueryItem = URLQueryItem(name: "i", value: mealId)
                urlComponents?.queryItems = [mealIdQueryItem]
                
                guard let url = urlComponents?.url else {
                    Logger.logMessage(message: "MealsAPI::getMealDetails -> Cannot get URL from URL Components!", logType: .error)
                    return URLRequest(url: URL(string: "")!)
                }
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.GET.rawValue
                
                Logger.logMessage(message: "MealsAPI::getMealDetails -> URL - \(urlRequest)")
                
                return urlRequest
        }
    }
    
    
}

