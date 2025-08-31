import SwiftUI

struct LoginView: View {
    private let roles = ["Parent", "Babysitter"]
    @State private var roleIndex = 0
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text("QuickCare")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.deepBrown)
            
            VStack(spacing: 12) {
                TextField("Username", text: $username)
                    .padding(10)
                    .background(Color.beige)
                    .cornerRadius(8)
                    .foregroundColor(.deepBrown)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .padding(10)
                    .background(Color.beige)
                    .cornerRadius(8)
                    .foregroundColor(.deepBrown)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            
            ZStack(alignment: roleIndex == 0 ? .leading : .trailing) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.mustard.opacity(0.6))
                    .frame(height: 40)
                    .padding(.horizontal)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.mustard)
                    .frame(width: UIScreen.main.bounds.width * 0.5 - 32, height: 40)
                    .padding(.horizontal)
                    .offset(x: roleIndex == 0 ? -UIScreen.main.bounds.width * 0.25 + 102 : UIScreen.main.bounds.width * 0.25 - 102)
                    .animation(.easeInOut(duration: 0.3), value: roleIndex)
                
                HStack(spacing: 0) {
                    ForEach(roles.indices, id: \.self) { i in
                        Text(roles[i])
                            .fontWeight(.semibold)
                            .foregroundColor(roleIndex == i ? Color.deepBrown : Color.brown.opacity(0.7))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation {
                                    roleIndex = i
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 40)
            
            Button(action: {
                isLoggedIn = true
            }) {
                Text("Login")
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.mustard)
                    .foregroundColor(.deepBrown)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .disabled(username.isEmpty || password.isEmpty)
            .opacity(username.isEmpty || password.isEmpty ? 0.5 : 1.0)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.olive.ignoresSafeArea())
        .fullScreenCover(isPresented: $isLoggedIn) {
            HomeView(isParent: roleIndex == 0)
        }
    }
}
