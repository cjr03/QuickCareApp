import SwiftUI

struct ProfileCard: View {
    let profile: UserProfile
    let isParent: Bool
    let duration: Double
    let acceptAction: () -> Void
    let rejectAction: () -> Void
    
    var totalCost: Double {
        if isParent {
            return profile.hourlyRate * duration
        } else if let hours = profile.hoursRequested {
            return profile.hourlyRate * hours
        }
        return 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(profile.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 160)
                .clipped()
                .cornerRadius(12)
            
            Text(profile.name)
                .font(.title3)
                .bold()
                .foregroundColor(.deepBrown)
            
            HStack(spacing: 12) {
                Image(systemName: "star.fill")
                    .foregroundColor(.mustard)
                Text(String(format: "%.1f", profile.rating))
                    .foregroundColor(.deepBrown)
                
                if profile.backgroundCheck {
                    Image(systemName: "checkmark.shield.fill")
                        .foregroundColor(.mustard)
                    Text("Background Checked")
                        .foregroundColor(.deepBrown)
                }
            }
            .font(.subheadline)
            
            if isParent {
                Text("Total: $\(String(format: "%.2f", totalCost))")
                    .foregroundColor(.deepBrown)
            } else {
                if let hours = profile.hoursRequested {
                    Text("Requested: \(Int(hours)) hrs")
                        .foregroundColor(.deepBrown)
                    Text("Earnings: $\(String(format: "%.2f", totalCost))")
                        .foregroundColor(.deepBrown)
                }
            }
            if let eta = profile.etaMinutes {
                Text("ETA: \(eta) minutes")
                    .foregroundColor(.deepBrown)
            }
            
            HStack(spacing: 16) {
                Button(action: rejectAction) {
                    Text("Reject")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown.opacity(0.8))
                        .foregroundColor(.beige)
                        .cornerRadius(10)
                }
                Button(action: acceptAction) {
                    Text("Accept")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.mustard)
                        .foregroundColor(.deepBrown)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.beige)
        .cornerRadius(16)
        .shadow(radius: 5)
        .frame(maxWidth: 380)
        .fixedSize(horizontal: false, vertical: true)
    }
}
