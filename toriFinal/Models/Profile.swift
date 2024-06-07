//
//  Profile.swift
//  tori
//
//  Created by Fahad Munawar on 5/14/24.
//

import Foundation
import SwiftData
import AppIntents
import PhotosUI
import UIKit

@Model
class Profile: Identifiable {
    var didOnboarding: Bool
    var id: UUID
    var firstName: String
    var lastName: String
    var diet: Dietary
    var priceLimit: String
    var drinker: Bool
    var smoker: Bool
    var likes: [ActivityRoot]
    var dislikes: [ActivityRoot]
    var favorites: [ActivityRoot]
    var mustTrys: [ActivityRoot]
    var visited: [ActivityRoot]
    var likedCategories : CategoryManager
//    var selectedImage: UIImage?

    init(didOnboarding: Bool = false, id: UUID = UUID(), firstName: String = "", lastName: String = "", diet: Dietary = .everything, priceLimit: String = "", drinker: Bool = false, smoker: Bool = false, likes: [ActivityRoot] = [], dislikes: [ActivityRoot] = [], favorites: [ActivityRoot] = [], mustTrys: [ActivityRoot] = [], visited: [ActivityRoot] = [], likedCategories: CategoryManager = CategoryManager()) {
        self.didOnboarding = didOnboarding
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.diet = diet
        self.priceLimit = priceLimit
        self.drinker = drinker
        self.smoker = smoker
        self.likes = likes
        self.dislikes = dislikes
        self.favorites = favorites
        self.mustTrys = mustTrys
        self.visited = visited
        self.likedCategories = likedCategories
    }
}

enum Dietary: Codable {
    case everything/* = "No food restrictions"*/
    case carnivore/* = "Carnivore"*/
    case vegetarian/* = "Vegetarian"*/
    case vegan/* = "Vegan"*/
    case halal/* = "Halal"*/
    case pescetarian/* = "Pescetarian"*/
}

struct User {
    var topCategories: [yelpCategories] = [.activeLife, .food, .nightLife/*, .shopping, .restaurants*/]    //append the categories they selected from onboarding
}

//    func updateUserPreferences(newPreferences: Preferences) {
//        // update user preferences based on newPreferences
//        self.preferences = newPreferences
//    }
//
//    func addFavorite(place: Activity) {   // array of yelp class that will be used when passing in to favs
//        if favorites.contains(place) {
//            favorites.removeAll{ $0 == place }  //removes from fav
//        }
//        else {
//            favorites.append(place)
//        }
//    }
//
//    func removeFavorite(place: Activity) {
//        if let index = favorites.firstIndex(of: place) {
//            favorites.remove(at: index)
//        }
//    }
