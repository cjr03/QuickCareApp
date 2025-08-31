import SwiftUI

struct ETAScreenWrapper: View {
    let user: UserProfile?
    let isParent: Bool
    let onClose: () -> Void

    var body: some View {
        if let user = user {
            ETAScreenView(profile: user, isParent: isParent, onClose: onClose)
        } else {
            VStack {
                Text("Error loading user data")
                    .foregroundColor(.red)
                Button("Close") {
                    onClose()
                }
            }
            .padding()
            .background(Color.olive.ignoresSafeArea())
        }
    }
}


struct ETAScreenView: View {
    let profile: UserProfile
    let isParent: Bool
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Text(isParent ? "Your sitter is on the way!" : "Family accepted!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.deepBrown)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            if let eta = profile.etaMinutes {
                Text("Estimated arrival: \(eta) minutes")
                    .font(.title3)
                    .foregroundColor(.deepBrown)
            } else {
                Text("ETA information unavailable")
                    .font(.title3)
                    .foregroundColor(.brown)
            }
            
            if let directionsURL = profile.directionsURL {
                Link(destination: directionsURL) {
                    Text("Open Directions")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.mustard)
                        .foregroundColor(.deepBrown)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            } else {
                Text("Directions not available.")
                    .font(.title3)
                    .foregroundColor(.brown)
            }
            
            Text("Use the link above to " + (isParent ? "view your Sitter's location." : "navigate to the family's home."))
                .font(.body)
                .foregroundColor(.deepBrown)

            Spacer()

            Button(action: onClose) {
                Text("Close")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.beige)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .background(Color.olive.ignoresSafeArea())
    }
}
