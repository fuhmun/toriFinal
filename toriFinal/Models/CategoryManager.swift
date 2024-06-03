//
//  CategoryManager.swift
//  tori
//
//  Created by Fahad Munawar on 5/15/24.
//

import Foundation
import SwiftUI
import SwiftData

enum yelpCategories: String, CaseIterable{
    
    case activeLife = "Active"
    case arts = "Leisure"
    case beauty = "Relax"
    case food = "Food"
    case nightLife = "Night"
    case localFlavor = "Local"
    
    var background: Color {
        switch self {
        default:
                .gray
        }
    }
    
    var icon: String {
        switch self {
        case .activeLife:
            "figure.cooldown"
        case .arts:
            "pencil.and.scribble"
        case .beauty:
            "bubbles.and.sparkles.fill"
        case .food:
            "fork.knife"
        case .nightLife:
            "music.quarternote.3"
        default:
            "figure"
        }
    }
}

@Model
class YelpCategory {
    var name: String
    var subCategories: [SubCategory] = []
    
    init(name: String, subCategories: [SubCategory]) {
        self.name = name
        self.subCategories = subCategories
    }
}

@Model
class SubCategory {
    var name: String
    var count: Int
    
    init(name: String, count: Int = 0) {
        self.name = name
        self.count = count
    }
}

@Model
class CategoryManager: ObservableObject {
    
    var categories: [YelpCategory]
        
    init() {
        categories = [
            YelpCategory(name: "Active", subCategories: [
                SubCategory(name: "Airsoft"),
                SubCategory(name: "Amateur Sports Teams"),
                SubCategory(name: "Amusement Parks"),
                SubCategory(name: "Aquariums"),
                SubCategory(name: "Archery"),
                SubCategory(name: "ATV Rentals/Tours"),
                SubCategory(name: "Axe Throwing"),
                SubCategory(name: "Badminton"),
                SubCategory(name: "Baseball Fields"),
                SubCategory(name: "Basketball Courts"),
                SubCategory(name: "Bathing Area"),
                SubCategory(name: "Batting Cages"),
                SubCategory(name: "Beach Equipment Rentals"),
                SubCategory(name: "Beach Volleyball"),
                SubCategory(name: "Beaches"),
                SubCategory(name: "Bicycle Paths"),
                SubCategory(name: "Bike Parking"),
                SubCategory(name: "Bike Rentals"),
                SubCategory(name: "Boating"),
                SubCategory(name: "Bobsledding"),
                SubCategory(name: "Bocce Ball"),
                SubCategory(name: "Bowling"),
                SubCategory(name: "Bubble Soccer"),
                SubCategory(name: "Bungee Jumping"),
                SubCategory(name: "Canyoneering"),
                SubCategory(name: "Carousels"),
                SubCategory(name: "Challenge Courses"),
                SubCategory(name: "Climbing"),
                SubCategory(name: "Cycling Classes"),
                SubCategory(name: "Dart Arenas"),
                SubCategory(name: "Disc Golf"),
                SubCategory(name: "Diving"),
                SubCategory(name: "Free Diving"),
                SubCategory(name: "Scuba Diving"),
                SubCategory(name: "Escape Games"),
                SubCategory(name: "Fencing Clubs"),
                SubCategory(name: "Fishing"),
                SubCategory(name: "Fitness & Instruction"),
                SubCategory(name: "Aerial Fitness"),
                SubCategory(name: "Barre Classes"),
                SubCategory(name: "Boxing"),
                SubCategory(name: "Cardio Classes"),
                SubCategory(name: "Dance Studios"),
                SubCategory(name: "Golf Lessons"),
                SubCategory(name: "Gyms"),
                SubCategory(name: "Circuit Training Gyms"),
                SubCategory(name: "Interval Training Gyms"),
                SubCategory(name: "Martial Arts"),
                SubCategory(name: "Brazilian Jiu-jitsu"),
                SubCategory(name: "Chinese Martial Arts"),
                SubCategory(name: "Karate"),
                SubCategory(name: "Kickboxing"),
                SubCategory(name: "Muay Thai"),
                SubCategory(name: "Taekwondo"),
                SubCategory(name: "Meditation Centers"),
                SubCategory(name: "Pilates"),
                SubCategory(name: "Qi Gong"),
                SubCategory(name: "Self-defense Classes"),
                SubCategory(name: "Swimming Lessons/Schools"),
                SubCategory(name: "Tai Chi"),
                SubCategory(name: "Trainers"),
                SubCategory(name: "Yoga"),
                SubCategory(name: "Flyboarding"),
                SubCategory(name: "Gliding"),
                SubCategory(name: "Go Karts"),
                SubCategory(name: "Golf"),
                SubCategory(name: "Gun/Rifle Ranges"),
                SubCategory(name: "Gymnastics"),
                SubCategory(name: "Handball"),
                SubCategory(name: "Hang Gliding"),
                SubCategory(name: "Hiking"),
                SubCategory(name: "Horse Racing"),
                SubCategory(name: "Horseback Riding"),
                SubCategory(name: "Hot Air Balloons"),
                SubCategory(name: "Indoor Playcentre"),
                SubCategory(name: "Jet Skis"),
                SubCategory(name: "Kids Activities"),
                SubCategory(name: "Kiteboarding"),
                SubCategory(name: "Lakes"),
                SubCategory(name: "Laser Tag"),
                SubCategory(name: "Lawn Bowling"),
                SubCategory(name: "Mini Golf"),
                SubCategory(name: "Mountain Biking"),
                SubCategory(name: "Nudist"),
                SubCategory(name: "Paddleboarding"),
                SubCategory(name: "Paintball"),
                SubCategory(name: "Paragliding"),
                SubCategory(name: "Parasailing"),
                SubCategory(name: "Parks"),
                SubCategory(name: "Dog Parks"),
                SubCategory(name: "Skate Parks"),
                SubCategory(name: "Pickleball"),
                SubCategory(name: "Playgrounds"),
                SubCategory(name: "Public Plazas"),
                SubCategory(name: "Races & Competitions"),
                SubCategory(name: "Racing Experience"),
                SubCategory(name: "Rafting/Kayaking"),
                SubCategory(name: "Recreation Centers"),
                SubCategory(name: "Rock Climbing"),
                SubCategory(name: "Sailing"),
                SubCategory(name: "Scavenger Hunts"),
                SubCategory(name: "Scooter Rentals"),
                SubCategory(name: "Senior Centers"),
                SubCategory(name: "Skating Rinks"),
                SubCategory(name: "Skiing"),
                SubCategory(name: "Skydiving"),
                SubCategory(name: "Sledding"),
                SubCategory(name: "Snorkeling"),
                SubCategory(name: "Soccer"),
                SubCategory(name: "Sport Equipment Hire"),
                SubCategory(name: "Sports Clubs"),
                SubCategory(name: "Squash"),
                SubCategory(name: "Summer Camps"),
                SubCategory(name: "Surf Lifesaving"),
                SubCategory(name: "Surfing"),
                SubCategory(name: "Swimming Pools"),
                SubCategory(name: "Tennis"),
                SubCategory(name: "Trampoline Parks"),
                SubCategory(name: "Tubing"),
                SubCategory(name: "Volleyball"),
                SubCategory(name: "Water Parks"),
                SubCategory(name: "Wildlife Hunting Ranges"),
                SubCategory(name: "Ziplining"),
                SubCategory(name: "Zoos"),
                SubCategory(name: "Petting Zoos"),
                SubCategory(name: "Zorbing")
            ]),
            YelpCategory(name: "Night", subCategories: [
                SubCategory(name: "Adult Entertainment"),
                SubCategory(name: "Strip Clubs"),
                SubCategory(name: "Striptease Dancers"),
                SubCategory(name: "Bar Crawl"),
                SubCategory(name: "Bars"),
                SubCategory(name: "Airport Lounges"),
                SubCategory(name: "Beer Bar"),
                SubCategory(name: "Champagne Bars"),
                SubCategory(name: "Cigar Bars"),
                SubCategory(name: "Cocktail Bars"),
                SubCategory(name: "Dive Bars"),
                SubCategory(name: "Drive-Thru Bars"),
                SubCategory(name: "Gay Bars"),
                SubCategory(name: "Hookah Bars"),
                SubCategory(name: "Irish Pub"),
                SubCategory(name: "Lounges"),
                SubCategory(name: "Pubs"),
                SubCategory(name: "Speakeasies"),
                SubCategory(name: "Sports Bars"),
                SubCategory(name: "Tiki Bars"),
                SubCategory(name: "Vermouth Bars"),
                SubCategory(name: "Whiskey Bars"),
                SubCategory(name: "Wine Bars"),
                SubCategory(name: "Beer Gardens"),
                SubCategory(name: "Club Crawl"),
                SubCategory(name: "Comedy Clubs"),
                SubCategory(name: "Country Dance Halls"),
                SubCategory(name: "Dance Clubs"),
                SubCategory(name: "Jazz & Blues"),
                SubCategory(name: "Karaoke"),
                SubCategory(name: "Music Venues"),
                SubCategory(name: "Piano Bars"),
                SubCategory(name: "Pool Halls")
            ]),
            YelpCategory(name: "Food", subCategories: [
                SubCategory(name: "Afghan"),
                SubCategory(name: "African"),
                SubCategory(name: "Senegalese"),
                SubCategory(name: "South African"),
                SubCategory(name: "American (New)"),
                SubCategory(name: "American (Traditional)"),
                SubCategory(name: "Andalusian"),
                SubCategory(name: "Arabian"),
                SubCategory(name: "Arab Pizza"),
                SubCategory(name: "Argentine"),
                SubCategory(name: "Armenian"),
                SubCategory(name: "Asian Fusion"),
                SubCategory(name: "Asturian"),
                SubCategory(name: "Australian"),
                SubCategory(name: "Austrian"),
                SubCategory(name: "Baguettes"),
                SubCategory(name: "Bangladeshi"),
                SubCategory(name: "Barbeque"),
                SubCategory(name: "Basque"),
                SubCategory(name: "Bavarian"),
                SubCategory(name: "Beer Garden"),
                SubCategory(name: "Beer Hall"),
                SubCategory(name: "Beisl"),
                SubCategory(name: "Belgian"),
                SubCategory(name: "Flemish"),
                SubCategory(name: "Bistros"),
                SubCategory(name: "Black Sea"),
                SubCategory(name: "Brasseries"),
                SubCategory(name: "Brazilian"),
                SubCategory(name: "Brazilian Empanadas"),
                SubCategory(name: "Central Brazilian"),
                SubCategory(name: "Northeastern Brazilian"),
                SubCategory(name: "Northern Brazilian"),
                SubCategory(name: "Rodizios"),
                SubCategory(name: "Breakfast & Brunch"),
                SubCategory(name: "Pancakes"),
                SubCategory(name: "British"),
                SubCategory(name: "Buffets"),
                SubCategory(name: "Bulgarian"),
                SubCategory(name: "Burgers"),
                SubCategory(name: "Burmese"),
                SubCategory(name: "Cafes"),
                SubCategory(name: "Themed Cafes"),
                SubCategory(name: "Cafeteria"),
                SubCategory(name: "Cajun/Creole"),
                SubCategory(name: "Cambodian"),
                SubCategory(name: "Canadian (New)"),
                SubCategory(name: "Canteen"),
                SubCategory(name: "Caribbean"),
                SubCategory(name: "Dominican"),
                SubCategory(name: "Haitian"),
                SubCategory(name: "Puerto Rican"),
                SubCategory(name: "Trinidadian"),
                SubCategory(name: "Catalan"),
                SubCategory(name: "Cheesesteaks"),
                SubCategory(name: "Chicken Shop"),
                SubCategory(name: "Chicken Wings"),
                SubCategory(name: "Chilean"),
                SubCategory(name: "Chinese"),
                SubCategory(name: "Cantonese"),
                SubCategory(name: "Congee"),
                SubCategory(name: "Dim Sum"),
                SubCategory(name: "Fuzhou"),
                SubCategory(name: "Hainan"),
                SubCategory(name: "Hakka"),
                SubCategory(name: "Henghwa"),
                SubCategory(name: "Hokkien"),
                SubCategory(name: "Hunan"),
                SubCategory(name: "Pekinese"),
                SubCategory(name: "Shanghainese"),
                SubCategory(name: "Szechuan"),
                SubCategory(name: "Teochew"),
                SubCategory(name: "Comfort Food"),
                SubCategory(name: "Corsican"),
                SubCategory(name: "Creperies"),
                SubCategory(name: "Cuban"),
                SubCategory(name: "Curry Sausage"),
                SubCategory(name: "Cypriot"),
                SubCategory(name: "Czech"),
                SubCategory(name: "Czech/Slovakian"),
                SubCategory(name: "Danish"),
                SubCategory(name: "Delis"),
                SubCategory(name: "Diners"),
                SubCategory(name: "Dinner Theater"),
                SubCategory(name: "Dumplings"),
                SubCategory(name: "Eastern European"),
                SubCategory(name: "Eritrean"),
                SubCategory(name: "Ethiopian"),
                SubCategory(name: "Fast Food"),
                SubCategory(name: "Filipino"),
                SubCategory(name: "Fischbroetchen"),
                SubCategory(name: "Fish & Chips"),
                SubCategory(name: "Flatbread"),
                SubCategory(name: "Fondue"),
                SubCategory(name: "Food Court"),
                SubCategory(name: "Food Stands"),
                SubCategory(name: "Freiduria"),
                SubCategory(name: "French"),
                SubCategory(name: "Alsatian"),
                SubCategory(name: "Auvergnat"),
                SubCategory(name: "Berrichon"),
                SubCategory(name: "Bourguignon"),
                SubCategory(name: "Mauritius"),
                SubCategory(name: "Nicoise"),
                SubCategory(name: "Provencal"),
                SubCategory(name: "French Southwest"),
                SubCategory(name: "Galician"),
                SubCategory(name: "Game Meat"),
                SubCategory(name: "Gastropubs"),
                SubCategory(name: "Georgian"),
                SubCategory(name: "German"),
                SubCategory(name: "Baden"),
                SubCategory(name: "Eastern German"),
                SubCategory(name: "Franconian"),
                SubCategory(name: "Hessian"),
                SubCategory(name: "Northern German"),
                SubCategory(name: "Palatine"),
                SubCategory(name: "Rhinelandian"),
                SubCategory(name: "Giblets"),
                SubCategory(name: "Gluten-Free"),
                SubCategory(name: "Greek"),
                SubCategory(name: "Guamanian"),
                SubCategory(name: "Halal"),
                SubCategory(name: "Hawaiian"),
                SubCategory(name: "Heuriger"),
                SubCategory(name: "Himalayan/Nepalese"),
                SubCategory(name: "Honduran"),
                SubCategory(name: "Hong Kong Style Cafe"),
                SubCategory(name: "Hot Dogs"),
                SubCategory(name: "Hot Pot"),
                SubCategory(name: "Hungarian"),
                SubCategory(name: "Iberian"),
                SubCategory(name: "Indian"),
                SubCategory(name: "Indonesian"),
                SubCategory(name: "International"),
                SubCategory(name: "Irish"),
                SubCategory(name: "Island Pub"),
                SubCategory(name: "Israeli"),
                SubCategory(name: "Italian"),
                SubCategory(name: "Abruzzese"),
                SubCategory(name: "Altoatesine"),
                SubCategory(name: "Apulian"),
                SubCategory(name: "Calabrian"),
                SubCategory(name: "Cucina Campana"),
                SubCategory(name: "Emilian"),
                SubCategory(name: "Friulan"),
                SubCategory(name: "Ligurian"),
                SubCategory(name: "Lumbard"),
                SubCategory(name: "Napoletana"),
                SubCategory(name: "Piemonte"),
                SubCategory(name: "Roman"),
                SubCategory(name: "Sardinian"),
                SubCategory(name: "Sicilian"),
                SubCategory(name: "Tuscan"),
                SubCategory(name: "Venetian"),
                SubCategory(name: "Japanese"),
                SubCategory(name: "Blowfish"),
                SubCategory(name: "Conveyor Belt Sushi"),
                SubCategory(name: "Donburi"),
                SubCategory(name: "Gyudon"),
                SubCategory(name: "Oyakodon"),
                SubCategory(name: "Hand Rolls"),
                SubCategory(name: "Horumon"),
                SubCategory(name: "Izakaya"),
                SubCategory(name: "Japanese Curry"),
                SubCategory(name: "Kaiseki"),
                SubCategory(name: "Kushikatsu"),
                SubCategory(name: "Oden"),
                SubCategory(name: "Okinawan"),
                SubCategory(name: "Okonomiyaki"),
                SubCategory(name: "Onigiri"),
                SubCategory(name: "Ramen"),
                SubCategory(name: "Robatayaki"),
                SubCategory(name: "Soba"),
                SubCategory(name: "Sukiyaki"),
                SubCategory(name: "Takoyaki"),
                SubCategory(name: "Tempura"),
                SubCategory(name: "Teppanyaki"),
                SubCategory(name: "Tonkatsu"),
                SubCategory(name: "Udon"),
                SubCategory(name: "Unagi"),
                SubCategory(name: "Western Style Japanese Food"),
                SubCategory(name: "Yakiniku"),
                SubCategory(name: "Yakitori"),
                SubCategory(name: "Jewish"),
                SubCategory(name: "Kebab"),
                SubCategory(name: "Kopitiam"),
                SubCategory(name: "Korean"),
                SubCategory(name: "Kosher"),
                SubCategory(name: "Kurdish"),
                SubCategory(name: "Laos"),
                SubCategory(name: "Laotian"),
                SubCategory(name: "Latin American"),
                SubCategory(name: "Colombian"),
                SubCategory(name: "Salvadoran"),
                SubCategory(name: "Venezuelan"),
                SubCategory(name: "Live/Raw Food"),
                SubCategory(name: "Lyonnais"),
                SubCategory(name: "Malaysian"),
                SubCategory(name: "Mamak"),
                SubCategory(name: "Nyonya"),
                SubCategory(name: "Meatballs"),
                SubCategory(name: "Mediterranean"),
                SubCategory(name: "Falafel"),
                SubCategory(name: "Mexican"),
                SubCategory(name: "Eastern Mexican"),
                SubCategory(name: "Jaliscan"),
                SubCategory(name: "Northern Mexican"),
                SubCategory(name: "Oaxacan"),
                SubCategory(name: "Pueblan"),
                SubCategory(name: "Tacos"),
                SubCategory(name: "Tamales"),
                SubCategory(name: "Yucatan"),
                SubCategory(name: "Middle Eastern"),
                SubCategory(name: "Egyptian"),
                SubCategory(name: "Lebanese"),
                SubCategory(name: "Milk Bars"),
                SubCategory(name: "Modern Australian"),
                SubCategory(name: "Modern European"),
                SubCategory(name: "Mongolian"),
                SubCategory(name: "Moroccan"),
                SubCategory(name: "New Mexican Cuisine"),
                SubCategory(name: "New Zealand"),
                SubCategory(name: "Nicaraguan"),
                SubCategory(name: "Night Food"),
                SubCategory(name: "Nikkei"),
                SubCategory(name: "Noodles"),
                SubCategory(name: "Norcinerie"),
                SubCategory(name: "Open Sandwiches"),
                SubCategory(name: "Oriental"),
                SubCategory(name: "Pakistani"),
                SubCategory(name: "Pan Asian"),
                SubCategory(name: "Parent Cafes"),
                SubCategory(name: "Parma"),
                SubCategory(name: "Peruvian"),
                SubCategory(name: "PF/Comercial"),
                SubCategory(name: "Pita"),
                SubCategory(name: "Pizza"),
                SubCategory(name: "Polish"),
                SubCategory(name: "Pierogis"),
                SubCategory(name: "Polynesian"),
                SubCategory(name: "Pop-Up Restaurants"),
                SubCategory(name: "Portuguese"),
                SubCategory(name: "Alentejo"),
                SubCategory(name: "Algarve"),
                SubCategory(name: "Azores"),
                SubCategory(name: "Beira"),
                SubCategory(name: "Fado Houses"),
                SubCategory(name: "Madeira"),
                SubCategory(name: "Minho"),
                SubCategory(name: "Ribatejo"),
                SubCategory(name: "Tras-os-Montes"),
                SubCategory(name: "Potatoes"),
                SubCategory(name: "Poutineries"),
                SubCategory(name: "Pub Food"),
                SubCategory(name: "Rice"),
                SubCategory(name: "Romanian"),
                SubCategory(name: "Rotisserie Chicken"),
                SubCategory(name: "Russian"),
                SubCategory(name: "Salad"),
                SubCategory(name: "Sandwiches"),
                SubCategory(name: "Scandinavian"),
                SubCategory(name: "Schnitzel"),
                SubCategory(name: "Scottish"),
                SubCategory(name: "Seafood"),
                SubCategory(name: "Serbo Croatian"),
                SubCategory(name: "Signature Cuisine"),
                SubCategory(name: "Singaporean"),
                SubCategory(name: "Slovakian"),
                SubCategory(name: "Somali"),
                SubCategory(name: "Soul Food"),
                SubCategory(name: "Soup"),
                SubCategory(name: "Southern"),
                SubCategory(name: "Spanish"),
                SubCategory(name: "Arroceria/Paella"),
                SubCategory(name: "Sri Lankan"),
                SubCategory(name: "Steakhouses"),
                SubCategory(name: "Supper Clubs"),
                SubCategory(name: "Sushi Bars"),
                SubCategory(name: "Swabian"),
                SubCategory(name: "Swedish"),
                SubCategory(name: "Swiss Food"),
                SubCategory(name: "Syrian"),
                SubCategory(name: "Tabernas"),
                SubCategory(name: "Taiwanese"),
                SubCategory(name: "Tapas Bars"),
                SubCategory(name: "Tapas/Small Plates"),
                SubCategory(name: "Tavola Calda"),
                SubCategory(name: "Tex-Mex"),
                SubCategory(name: "Thai"),
                SubCategory(name: "Traditional Norwegian"),
                SubCategory(name: "Traditional Swedish"),
                SubCategory(name: "Trattorie"),
                SubCategory(name: "Turkish"),
                SubCategory(name: "Chee Kufta"),
                SubCategory(name: "Gozleme"),
                SubCategory(name: "Homemade Food"),
                SubCategory(name: "Lahmacun"),
                SubCategory(name: "Ottoman Cuisine"),
                SubCategory(name: "Turkish Ravioli"),
                SubCategory(name: "Ukrainian"),
                SubCategory(name: "Uzbek"),
                SubCategory(name: "Vegan"),
                SubCategory(name: "Vegetarian"),
                SubCategory(name: "Venison"),
                SubCategory(name: "Vietnamese"),
                SubCategory(name: "Waffles"),
                SubCategory(name: "Wok"),
                SubCategory(name: "Wraps"),
                SubCategory(name: "Yugoslav")
            ]),
            YelpCategory(name: "Relax", subCategories: [
                SubCategory(name: "Acne Treatment"),
                SubCategory(name: "Barbers"),
                SubCategory(name: "Cosmetics & Beauty Supply"),
                SubCategory(name: "Day Spas"),
                SubCategory(name: "Erotic Massage"),
                SubCategory(name: "Eyebrow Services"),
                SubCategory(name: "Eyelash Service"),
                SubCategory(name: "Foot Care"),
                SubCategory(name: "Hair Extensions"),
                SubCategory(name: "Hair Loss Centers"),
                SubCategory(name: "Hair Removal"),
                SubCategory(name: "Laser Hair Removal"),
                SubCategory(name: "Sugaring"),
                SubCategory(name: "Threading Services"),
                SubCategory(name: "Waxing"),
                SubCategory(name: "Hair Salons"),
                SubCategory(name: "Blow Dry/Out Services"),
                SubCategory(name: "Hair Stylists"),
                SubCategory(name: "Kids Hair Salons"),
                SubCategory(name: "Men’s Hair Salons"),
                SubCategory(name: "Hot Springs"),
                SubCategory(name: "Makeup Artists"),
                SubCategory(name: "Massage"),
                SubCategory(name: "Medical Spas"),
                SubCategory(name: "Nail Salons"),
                SubCategory(name: "Nail Technicians"),
                SubCategory(name: "Perfume"),
                SubCategory(name: "Permanent Makeup"),
                SubCategory(name: "Piercing"),
                SubCategory(name: "Skin Care"),
                SubCategory(name: "Estheticians"),
                SubCategory(name: "Tanning"),
                SubCategory(name: "Spray Tanning"),
                SubCategory(name: "Tanning Beds"),
                SubCategory(name: "Tattoo"),
                SubCategory(name: "Teeth Whitening")
            ]),
            YelpCategory(name: "Entertainment", subCategories: [
                SubCategory(name: "Arcades"),
                SubCategory(name: "Art Galleries"),
                SubCategory(name: "Bingo Halls"),
                SubCategory(name: "Botanical Gardens"),
                SubCategory(name: "Cabaret"),
                SubCategory(name: "Casinos"),
                SubCategory(name: "Cinema"),
                SubCategory(name: "Drive-In Theater"),
                SubCategory(name: "Outdoor Movies"),
                SubCategory(name: "Country Clubs"),
                SubCategory(name: "Cultural Center"),
                SubCategory(name: "Entertainment"),
                SubCategory(name: "Farms"),
                SubCategory(name: "Attraction Farms"),
                SubCategory(name: "Pick Your Own Farms"),
                SubCategory(name: "Ranches"),
                SubCategory(name: "Festivals"),
                SubCategory(name: "Haunted Houses"),
                SubCategory(name: "Jazz & Blues"),
                SubCategory(name: "LAN Centers"),
                SubCategory(name: "Makerspaces"),
                SubCategory(name: "Museums"),
                SubCategory(name: "Art Museums"),
                SubCategory(name: "Children’s Museums"),
                SubCategory(name: "Music Venues"),
                SubCategory(name: "Observatories"),
                SubCategory(name: "Opera & Ballet"),
                SubCategory(name: "Paint & Sip"),
                SubCategory(name: "Performing Arts"),
                SubCategory(name: "Planetarium"),
                SubCategory(name: "Professional Sports Teams"),
                SubCategory(name: "Race Tracks"),
                SubCategory(name: "Rodeo"),
                SubCategory(name: "Social Clubs"),
                SubCategory(name: "Veterans Organizations"),
                SubCategory(name: "Sports Betting"),
                SubCategory(name: "Stadiums & Arenas"),
                SubCategory(name: "Studio Taping"),
                SubCategory(name: "Supernatural Readings"),
                SubCategory(name: "Astrologers"),
                SubCategory(name: "Mystics"),
                SubCategory(name: "Psychic Mediums"),
                SubCategory(name: "Psychics"),
                SubCategory(name: "Tablao Flamenco"),
                SubCategory(name: "Ticket Sales"),
                SubCategory(name: "Virtual Reality Centers"),
                SubCategory(name: "Wineries"),
                SubCategory(name: "Wine Tasting Room")
            ]),
            YelpCategory(name: "Local", subCategories: [
                SubCategory(name: "Parklets"),
                SubCategory(name: "Public Art"),
                SubCategory(name: "Unofficial Yelp Events"),
                SubCategory(name: "Yelp Events")
            ])
        ]
    }
    
    func incrementSubCategory(categoryName: String, subCategoryName: String) {
        guard let categoryIndex = categories.firstIndex(where: { $0.name == categoryName }) else { return }
        guard let subCategoryIndex = categories[categoryIndex].subCategories.firstIndex(where: { $0.name == subCategoryName }) else { return }
        
        categories[categoryIndex].subCategories[subCategoryIndex].count += 1
    }
    
//    func findMaxCategory(categoryName: String, subCategoryName: String) -> String {
//
//    }
    
}

struct RandomCategory {
    let activities : [String] = ["airsoft", "amateursportsteams", "amusementparks", "aquariums", "archery", "atvrentals/tours", "axethrowing", "badminton", "baseballfields", "basketballcourts", "bathingarea", "battingcages", "beachvolleyball", "beaches", "bicyclepaths", "bikeparking", "boating", "bobsledding", "bocceball", "bowling", "bubblesoccer", "bungeejumping", "canyoneering", "challengecourses", "climbing", "cyclingclasses", "dartarenas", "discgolf", "diving", "freediving", "scubadiving", "escapegames", "fencingclubs", "fishing", "fitness&instruction", "aerialfitness", "barreclasses", "boxing", "cardioclasses", "dancestudios", "golflessons", "gyms", "circuittraininggyms", "intervaltraininggyms", "martialarts", "brazilianjiu-jitsu", "chinesemartialarts", "karate", "kickboxing", "muaythai", "taekwondo", "meditationcenters", "pilates", "qigong", "self-defenseclasses", "swimminglessons/schools", "taichi", "trainers", "yoga", "flyboarding", "gliding", "gokarts", "golf", "gun/rifleranges", "gymnastics", "handball", "hanggliding", "hiking", "horseracing", "horsebackriding", "hotairballoons", "indoorplaycentre", "jetskis", "kiteboarding", "lakes", "lasertag", "lawnbowling", "minigolf", "mountainbiking", "nudist", "paddleboarding", "paintball", "paragliding", "parasailing", "parks", "dogparks", "skateparks", "pickleball", "playgrounds", "publicplazas", "races&competitions", "racingexperience", "rafting/kayaking", "recreationcenters", "rockclimbing", "sailing", "scavengerhunts", "scooterrentals", "skatingrinks", "skiing", "skydiving", "sledding", "snorkeling", "soccer", "sportsclubs", "surfing", "swimmingpools", "tennis", "trampolineparks", "tubing", "volleyball", "waterparks", "wildlifehuntingranges", "ziplining", "zoos", "pettingzoos", "zorbing","arcades", "artgalleries", "bingohalls", "cabaret", "casinos", "cinema", "drive-intheater", "outdoormovies", "countryclubs", "culturalcenter", "entertainment", "farms", "attractionfarms", "ranches", "festivals", "hauntedhouses", "jazz&blues", "lancenters", "makerspaces", "museums", "artmuseums", "musicvenues", "observatories", "opera&ballet", "paint&sip", "performingarts", "planetarium", "professionalsportsteams", "racetracks", "rodeo", "socialclubs", "veteransorganizations", "sportsbetting", "stadiums&arenas", "studiotaping", "supernaturalreadings", "astrologers", "mystics", "psychicmediums", "psychics", "tablaoflamenco", "ticketsales", "virtualrealitycenters", "wineries", "winetastingroom","acnetreatment", "barbers", "cosmetics&beautysupply", "dayspas", "eroticmassage", "eyebrowservices", "eyelashservice", "footcare", "hairextensions", "hairlosscenters", "hairremoval", "laserhairremoval", "sugaring", "threadingservices", "waxing", "hairsalons", "blowdry/outservices", "hairextensions", "hairstylists", "men’shairsalons", "hotsprings", "makeupartists", "massage", "medicalspas", "nailsalons", "nailtechnicians", "perfume", "permanentmakeup", "piercing", "skincare", "estheticians", "tanning", "spraytanning", "tanningbeds", "tattoo","acaibowls", "backshop", "bagels", "bakeries", "beer,wine&spirits", "bento", "beveragestore", "breweries", "brewpubs", "bubbletea", "butcher", "chimneycakes", "churros", "cideries", "coffee&tea", "coffee&teasupplies", "coffeeroasteries", "conveniencestores", "csa", "cupcakes", "customcakes", "delicatessen", "desserts", "distilleries", "do-it-yourselffood", "donairs", "donuts", "empanadas", "ethicalgrocery", "farmersmarket", "fishmonger", "fooddeliveryservices", "foodtrucks", "friterie", "gelato", "grocery", "hawkercentre", "honey", "icecream&frozenyogurt", "importedfood", "internationalgrocery", "internetcafes", "japanesesweets", "taiyaki", "juicebars&smoothies", "kiosk", "kombucha", "meaderies", "milkshakebars", "mulledwine", "nasilemak", "organicstores", "panzerotti", "parentcafes", "patisserie/cakeshop", "piadina", "poke", "pretzels", "salumerie", "shavedice", "shavedsnow", "smokehouse", "specialtyfood", "candystores", "cheeseshops", "chocolatiers&shops", "dagashi", "driedfruit", "frozenfood", "fruits&veggies", "healthmarkets", "herbs&spices", "macarons", "meatshops", "pastashops", "popcornshops", "seafoodmarkets", "tofushops", "streetvendors", "sugarshacks", "tearooms", "torshi", "tortillas", "waterstores", "wineries", "zapiekanka", "adultentertainment", "stripclubs", "stripteasedancers", "barcrawl", "bars", "beerbar", "champagnebars", "cigarbars", "cocktailbars", "divebars", "drive-thrubars", "gaybars", "hookahbars", "irishpub", "lounges", "pubs", "speakeasies", "sportsbars", "tikibars", "vermouthbars", "whiskeybars", "winebars", "beergardens", "clubcrawl", "comedyclubs", "countrydancehalls", "danceclubs", "jazz&blues", "karaoke", "musicvenues", "pianobars", "poolhalls","afghan", "african", "senegalese", "southafrican", "american(new)", "american(traditional)", "andalusian", "arabian", "arabpizza", "argentine", "armenian", "asianfusion", "asturian", "australian", "austrian", "baguettes", "bangladeshi", "barbeque", "basque", "bavarian", "beergarden", "beerhall", "beisl", "belgian", "flemish", "bistros", "blacksea", "brasseries", "brazilian", "brazilianempanadas", "centralbrazilian", "northeasternbrazilian", "northernbrazilian", "rodizios", "breakfast&brunch", "pancakes", "british", "buffets", "bulgarian", "burgers", "burmese", "cafes", "themedcafes", "cafeteria", "cajun/creole", "cambodian", "canadian(new)", "canteen", "caribbean", "dominican", "haitian", "puertorican", "trinidadian", "catalan", "cheesesteaks", "chickenshop", "chickenwings", "chilean", "chinese", "cantonese", "congee", "dimsum", "fuzhou", "hainan", "hakka", "henghwa", "hokkien", "hunan", "pekinese", "shanghainese", "szechuan", "teochew", "comfortfood", "corsican", "creperies", "cuban", "currysausage", "cypriot", "czech", "czech/slovakian", "danish", "delis", "diners", "dinnertheater", "dumplings", "easterneuropean", "eritrean", "ethiopian", "fastfood", "filipino", "fischbroetchen", "fish&chips", "flatbread", "fondue", "foodcourt", "foodstands", "freiduria", "french", "alsatian", "auvergnat", "berrichon", "bourguignon", "mauritius", "nicoise", "provencal", "frenchsouthwest", "galician", "gamemeat", "gastropubs", "georgian", "german", "baden", "easterngerman", "franconian", "hessian", "northerngerman", "palatine", "rhinelandian", "giblets", "gluten-free", "greek", "guamanian", "halal", "hawaiian", "heuriger", "himalayan/nepalese", "honduran", "hongkongstylecafe", "hotdogs", "hotpot", "hungarian", "iberian", "indian", "indonesian", "international", "irish", "islandpub", "israeli", "italian", "abruzzese", "altoatesine", "apulian", "calabrian", "cucinacampana", "emilian", "friulan", "ligurian", "lumbard", "napoletana", "piemonte", "roman", "sardinian", "sicilian", "tuscan", "venetian", "japanese", "blowfish", "conveyorbeltushi", "donburi", "gyudon", "oyakodon", "handrolls", "horumon", "izakaya", "japanesecurry", "kaiseki", "kushikatsu", "oden", "okinawan", "okonomiyaki", "onigiri", "ramen", "robatayaki", "soba", "sukiyaki", "takoyaki", "tempura", "teppanyaki", "tonkatsu", "udon", "unagi", "westernstylejapanesefood", "yakiniku", "yakitori", "jewish", "kebab", "kopitiam", "korean", "kosher", "kurdish", "laos", "laotian", "latinamerican", "colombian", "salvadoran", "venezuelan", "live/rawfood", "lyonnais", "malaysian", "mamak", "nyonya", "meatballs", "mediterranean", "falafel", "mexican", "easternmexican", "jaliscan", "northernmexican", "oaxacan", "pueblan", "tacos", "tamales", "yucatan", "middleeastern", "egyptian", "lebanese", "milkbars", "modernaustralian", "moderneuropean", "mongolian", "moroccan", "newmexicancuisine", "newzealand", "nicaraguan", "nightfood", "nikkei", "noodles", "norcinerie", "opensandwiches", "oriental", "pakistani", "panasian", "parentcafes", "parma", "persian/iranian", "peruvian", "pf/comercial", "pita", "pizza", "polish", "pierogis", "polynesian", "pop-uprestaurants", "portuguese", "alentejo", "algarve", "azores", "beira", "fadohouses", "madeira", "minho", "ribatejo", "tras-os-montes", "potatoes", "poutineries", "pubfood", "rice", "romanian", "rotisseriechicken", "russian", "salad", "sandwiches", "scandinavian", "schnitzel", "scottish", "seafood", "serbocroatian", "signaturecuisine", "singaporean", "slovakian", "somali", "soulfood", "soup", "southern", "spanish", "arroceria/paella", "srilankan", "steakhouses", "supperclubs", "sushibars", "swabian", "swedish", "swissfood", "syrian", "tabernas", "taiwanese", "tapasbars", "tapas/smallplates", "tavolacalda", "tex-mex", "thai", "traditionalnorwegian", "traditionalwedish", "trattorie", "turkish", "cheeku", "gozleme", "lahmacun", "ottomancuisine", "turkishravioli", "ukrainian", "uzbek", "vegan", "vegetarian", "venison", "vietnamese", "waffles", "wok", "wraps", "yugoslav","parklets", "publicart", "unofficialyelpevents", "yelpevents"]
}
