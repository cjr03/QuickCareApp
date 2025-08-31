import SwiftUI

struct HomeView: View {
    let isParent: Bool
    @State private var budget: Double? = nil
    @State private var duration: Double? = nil
    @State private var hourlyWage: Double? = nil
    @State private var currentIndex = 0
    @State private var filteredUsers: [UserProfile] = []
    @State private var currentUser: UserProfile? = nil
    @State private var showETAScreen = false
    
    // Sample data for sitters and families
    let users: [UserProfile] = [
        UserProfile(
            name: "Sophie",
            rating: 4.9,
            backgroundCheck: true,
            imageName: "sitter1",
            hourlyRate: 15,
            hoursRequested: nil,
            etaMinutes: 7,
            directionsURL: URL(string: "http://maps.apple.com/?q=Current+Sitter+Location")
        ),
        UserProfile(
            name: "Michael",
            rating: 4.8,
            backgroundCheck: true,
            imageName: "sitter2",
            hourlyRate: 18,
            hoursRequested: nil,
            etaMinutes: 12,
            directionsURL: URL(string: "http://maps.apple.com/?q=Current+Sitter+Location")
        ),
        UserProfile(
            name: "Lucas Family",
            rating: 5.0,
            backgroundCheck: true,
            imageName: "family1",
            hourlyRate: 20,
            hoursRequested: 4,
            etaMinutes: 15,
            directionsURL: URL(string: "http://maps.apple.com/?q=Parent+Address")
        )
    ]
    
    func updateFilteredUsers() {
        if isParent {
            guard let budget = budget, budget > 0, let duration = duration, duration > 0 else {
                filteredUsers = []
                return
            }
            filteredUsers = users.filter {
                $0.hoursRequested == nil && ($0.hourlyRate * duration) <= budget
            }
        } else {
            guard let wage = hourlyWage, wage > 0 else {
                filteredUsers = []
                return
            }
            filteredUsers = users.filter {
                $0.hoursRequested != nil && $0.hourlyRate >= wage
            }
        }
        currentIndex = 0
    }
    
    func acceptUser(_ user: UserProfile) {
        currentUser = user
        DispatchQueue.main.async {
            showETAScreen = true
        }
    }
    
    func rejectUser() {
        currentIndex += 1
        if currentIndex >= filteredUsers.count {
            filteredUsers = []
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(isParent ? "Available Sitters" : "Available Families")
                .font(.title2)
                .bold()
                .foregroundColor(.deepBrown)
                .padding(.top)
            
            if isParent {
                VStack(spacing: 12) {
                    HStack {
                        Text("Total Budget: $")
                            .foregroundColor(.deepBrown)
                        TextField("Enter budget", value: $budget, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("Duration (hrs):")
                            .foregroundColor(.deepBrown)
                        TextField("Enter hours", value: $duration, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                }
                .padding(.horizontal)
                .onChange(of: budget) { _ in updateFilteredUsers() }
                .onChange(of: duration) { _ in updateFilteredUsers() }
            } else {
                HStack {
                    Text("Hourly Wage: $")
                        .foregroundColor(.deepBrown)
                    TextField("Enter wage", value: $hourlyWage, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding(.horizontal)
                .onChange(of: hourlyWage) { _ in updateFilteredUsers() }
            }
            
            Spacer()
            
            if !filteredUsers.isEmpty && currentIndex < filteredUsers.count {
                let user = filteredUsers[currentIndex]
                ProfileCard(profile: user, isParent: isParent, duration: duration ?? 0) {
                    acceptUser(user)
                } rejectAction: {
                    rejectUser()
                }
                .padding()
                .animation(.easeInOut, value: currentIndex)
            } else {
                Text(isParent ? "Set budget and duration to see available sitters." : "Enter your wage to see available families.")
                    .foregroundColor(.brown)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Spacer()
        }
        .background(Color.olive.ignoresSafeArea())
        .fullScreenCover(isPresented: $showETAScreen) {
            ETAScreenWrapper (
                user: currentUser,
                isParent: isParent,
                onClose: { showETAScreen = false }
            )
        }
    }
}
