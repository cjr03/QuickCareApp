import SwiftUI

struct UserProfile: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let rating: Double
    let backgroundCheck: Bool
    let imageName: String
    let hourlyRate: Double
    let hoursRequested: Double?
    let etaMinutes: Int?
    let directionsURL: URL?
}
