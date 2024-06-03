//
//  Yelp Fusion.swift
//  DreamTeam
//
//  Created by Fahad Munawar on 5/6/24.
//

import Foundation
import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import SwiftData

struct ActivityResponse: Decodable { // Protocols
    var businesses: [Activity]?
    var total: Int?
    var region: Region?
}

struct Activity: Decodable, Hashable, Equatable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String?
    var alias: String?
    var name: String?
    var image_url: String?
    var is_closed: Bool?
    var url: String?
    var review_count: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinates?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    var attributes: Attributes?
}

struct Category: Decodable {
    var alias: String?
    var title: String?
}

struct Coordinates: Decodable {
    var latitude: Double?
    var longitude: Double?
}

struct Location: Decodable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var display_address: [String]?
}

struct Attributes: Decodable {
    var businessTempClosed: Bool?
    var waitlistReservation: Bool?
}

struct Region: Decodable {
    var center: Coordinates?
}

class YelpAPI : ObservableObject {
    
    @Published var foundActivities: [Activity] = []
    
    func retrieveBusiness(cat: [String], lim: Int, sort: String, rad: Int, list: RandomCategory) async {
        
        let locationDataManager = LocationDataManager()
        
        guard let location = locationDataManager.locationManager?.location else {
            print("Error: Location services are not enabled")
            return
        }
        
        print("latitude: \(location.coordinate.latitude)")
        print("longitude: \(location.coordinate.longitude)")
        
        var cate: String
        
        if (cat.count == 1) {
            cate = cat.first ?? ""
        } else {
            cate = cat.joined(separator: "&categories=")
        }
        
        print(cate)
        
        let apiKey = "vqv650052B9RbYLV983v3bs9qnqpR5Z89vuzuPrmkf05RmvpyhJaZmBkNpbvz2FI6p8qrFyTGmgc38dKbQu1L9Fyj6qdZAOeNIR_LF_35RSqRIm_Mla5M26ja-U4ZnYx"
        
        let baseURL = "https://api.yelp.com/v3/businesses/search"
        
        let url = URL(string: baseURL)!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories" , value: cate),
            URLQueryItem(name: "limit" , value: String(lim)),
//            URLQueryItem(name: "sort_by" , value: sort),
            URLQueryItem(name: "radius", value: String(rad))
        ]
        
        components.queryItems = components.queryItems.map {$0 + queryItems} ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["Authorization" : "Bearer \(apiKey)", "accept": "application/json"]
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Error: No data recieved")
                return
            }
            let decoder = JSONDecoder()
            do {
                
                let json = String(decoding: data, as: UTF8.self)
                print(json)
                
                let response = try decoder.decode(ActivityResponse.self, from: data)
                
                if let activites = response.businesses {
                    DispatchQueue.main.async {
                        self.foundActivities.insert(contentsOf: activites, at: 0)
                    }
                }
                
                if let activites = response.businesses, !activites.isEmpty {
                    for activity in activites {
                        print("Name: \(activity.name ?? "Not Found")")
                    }
                } else {
                    Task {
                        await self.retrieveBusiness(cat: [list.activities.randomElement() ?? "food"], lim: 10, sort: "distance", rad: 40000, list: list)
                    }
                }
            } catch {
                print("Error: \(error)")
            }
        }
        .resume()
    }
}
