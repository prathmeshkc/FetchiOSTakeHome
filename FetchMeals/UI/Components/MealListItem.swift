//
//  MealListItem.swift
//  FetchMeals
//
//  Created by Prathmesh Chaudhari on 5/21/24.
//

import SwiftUI

struct MealListItem: View {
    
    let meal: Meal
    
    
    var body: some View {
        HStack {
            Group {
                AsyncImage(url: URL(string: meal.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                
                Text(meal.mealName)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .foregroundColor(.black)
                
            }.padding(.all, 12)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Colors.listItemBackground)
        .padding()
    }
}

#Preview {
    
    MealListItem(meal: DeveloperPreview.instance.meals[1])
}
