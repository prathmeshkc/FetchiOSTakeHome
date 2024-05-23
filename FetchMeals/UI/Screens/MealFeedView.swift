//
//  ContentView.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/21/24.
//

import SwiftUI

struct MealFeedView: View {
    @StateObject private var mealFeedViewModel: MealFeedViewModel = MealFeedViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch mealFeedViewModel.resultState {
                    case .idle:
                        VStack {}
                    case .loading:
                        ProgressView()
                    case .failed(let error):
                        ErrorView(error: error) {
                            self.mealFeedViewModel.getAllMeals()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .bottom))
                    case .success(let content):
                        MealList(mealList: content)
                }
            }
            .navigationTitle("Meals")
        }
    }
}

#Preview {
    MealFeedView()
}
