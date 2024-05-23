//
//  MealDetailView.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import SwiftUI

struct MealDetailView: View {
    
    @StateObject var mealDetailViewModel: MealDetailViewModel = MealDetailViewModel()
    
    var body: some View {
        
        switch mealDetailViewModel.resultState {
            case .idle:
                VStack {}
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error) {}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
            case .success(let content):
                
                NavigationStack {
                    ScrollView {
                        VStack {
                            Group {
                                Text("Instructions:-")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text(Helper.formatInstructionDescription(instructions: content.instructions))
                                    .fontWeight(.regular)
                                
                                Text("Ingredients & Measurements:-")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    
                                ForEach(content.ingredients) {
                                    ingredient in
                                    Text("\(ingredient.measurement) \(ingredient.name)")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        }
                    }.navigationTitle(content.name)
                }
        }
    }
}

#Preview {
    MealDetailView()
}
