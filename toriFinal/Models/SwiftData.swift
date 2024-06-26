//
//  SwiftData.swift
//  tori
//
//  Created by Fahad Munawar on 5/14/24.
//

import Foundation
import SwiftData

@Model
class ActivityRoot: Identifiable, Hashable {
    var id = UUID()
    var activity: swiftActivity
//    var didGo : Bool = false
    init(id: UUID = UUID(), activity: swiftActivity) {
        self.id = id
        self.activity = activity
    }
    
    static func == (lhs: ActivityRoot, rhs: ActivityRoot) -> Bool {
            return lhs.id == rhs.id
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Model
class swiftActivity: Identifiable {
    
    var id: String?
    var alias: String?
    var name: String?
    var image_url: String?
    var is_closed: Bool?
    var url: String?
    var review_count: Int?
    var categories: [swiftCategory]?
    var rating: Double?
    var coordinates: swiftCoordinates?
    var transactions: [String]?
    var price: String?
    var location: swiftLocation?
    var phone: String?
    var display_phone: String?
    var distance: Double?
    var attributes: swiftAttributes?
    
    // Switched nil -> [] for categories: [swiftCategory]? = []
    init(id: String? = nil, alias: String? = nil, name: String? = nil, image_url: String? = nil, is_closed: Bool? = nil, url: String? = nil, review_count: Int? = nil, categories: [swiftCategory]? = [], rating: Double? = nil, coordinates: swiftCoordinates? = nil, transactions: [String]? = nil, price: String? = nil, location: swiftLocation? = nil, phone: String? = nil, display_phone: String? = nil, distance: Double? = nil, attributes: swiftAttributes? = nil) {
        self.id = id
        self.alias = alias
        self.name = name
        self.image_url = image_url
        self.is_closed = is_closed
        self.url = url
        self.review_count = review_count
        self.categories = categories
        self.rating = rating
        self.coordinates = coordinates
        self.transactions = transactions
        self.price = price
        self.location = location
        self.phone = phone
        self.display_phone = display_phone
        self.distance = distance
        self.attributes = attributes
    }
    
    init(from activity: Activity) {
            self.id = activity.id
            self.alias = activity.alias
            self.name = activity.name
            self.image_url = activity.image_url
            self.is_closed = activity.is_closed
            self.url = activity.url
            self.review_count = activity.review_count
            self.categories = activity.categories?.map { swiftCategory(alias: $0.alias, title: $0.title) }
            self.rating = activity.rating
            self.coordinates = activity.coordinates.map { swiftCoordinates(latitude: $0.latitude, longitude: $0.longitude) }
            self.transactions = activity.transactions
            self.price = activity.price
            self.location = activity.location.map { swiftLocation(address1: $0.address1, address2: $0.address2, address3: $0.address3, city: $0.city, zipCode: $0.zipCode, country: $0.country, state: $0.state, display_address: $0.display_address) }
            self.phone = activity.phone
            self.display_phone = activity.display_phone
            self.distance = activity.distance
        self.attributes = activity.attributes.map { swiftAttributes(business_url: $0.business_url, businessTempClosed: $0.businessTempClosed, waitlistReservation: $0.waitlistReservation) }
        }
}

@Model
class swiftCategory {
    var alias: String?
    var title: String?
    
    init(alias: String? = nil, title: String? = nil) {
        self.alias = alias
        self.title = title
    }
}

@Model
class swiftCoordinates {
    var latitude: Double?
    var longitude: Double?
    
    init(latitude: Double? = nil, longitude: Double? = nil) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

@Model
class swiftLocation {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var display_address: [String]?
    
    init(address1: String? = nil, address2: String? = nil, address3: String? = nil, city: String? = nil, zipCode: String? = nil, country: String? = nil, state: String? = nil, display_address: [String]? = nil) {
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.city = city
        self.zipCode = zipCode
        self.country = country
        self.state = state
        self.display_address = display_address
    }
}

@Model
class swiftAttributes {
    var business_url: String?
    var businessTempClosed: Bool?
    var waitlistReservation: Bool?
    
    init(business_url: String? = nil,businessTempClosed: Bool? = nil, waitlistReservation: Bool? = nil) {
        self.business_url = business_url
        self.businessTempClosed = businessTempClosed
        self.waitlistReservation = waitlistReservation
    }
}

@Model
class swiftRegion {
    var center: swiftCoordinates?
    
    init(center: swiftCoordinates? = nil) {
        self.center = center
    }
}

//@Model
//class Products {
//
//    var productName:String = " ";
//    init(productName: String) {
//        self.productName = productName
//    }
//
//}
