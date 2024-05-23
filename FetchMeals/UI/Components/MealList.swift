//
//  MealList.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/22/24.
//

import SwiftUI

struct MealList: View {
    
    let mealList: [Meal]
    
    var body: some View {
        ZStack {
            List {
                ForEach(mealList, id: \.id) { meal in
                    MealListItem(meal: meal)
                        .background(
                            NavigationLink("", destination: {
                                MealDetailView(mealDetailViewModel: MealDetailViewModel(mealId: meal.id))
                            }).opacity(0.0))
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.visible, edges: .all)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    MealList(mealList: DeveloperPreview.instance.meals)
}
