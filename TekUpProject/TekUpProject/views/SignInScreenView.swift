import SwiftUI
import Firebase
import FirebaseAuth

struct SignInScreenView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage = ""
    @State private var isAnimating = false
    @Binding var isAuthenticated: Bool 
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeIn(duration: 0.6), value: isAnimating)
                    
                    SocalLoginButton(image: Image(systemName: "applelogo"), text: Text("Sign in with Apple"), action: {})
                    SocalLoginButton(image: Image(systemName: "globe"), text: Text("Sign in with Google").foregroundColor(Color.blue), action: {})
                        .padding(.vertical)
                    
                    Text("or sign in using email and password")
                        .foregroundColor(Color.black.opacity(0.4))
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeIn(duration: 0.6).delay(0.2), value: isAnimating)
                    
                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.vertical, 8)
                        .keyboardType(.emailAddress)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeIn(duration: 0.6).delay(0.4), value: isAnimating)
                    
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.vertical, 8)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeIn(duration: 0.6).delay(0.6), value: isAnimating)
                    
                    // Error Message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.top, 8)
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.easeIn(duration: 0.6).delay(0.8), value: isAnimating)
                    }
                    
                    PrimaryButton(title: "Sign In", action: signIn)
                    
                    Button(action: {
                        print("Navigate to Sign Up Screen")
                    }) {
                        Text("Don't have an account? Sign up")
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.top, 16)
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.easeIn(duration: 0.6).delay(1.0), value: isAnimating)
                    }
                }
                
                Spacer()
                
            }
            .padding()
            .onAppear {
                isAnimating = true
            }
        }
    }
    
    func signIn() {
        // Clear previous error message
        errorMessage = ""
        
        // Validate email and password
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter both email and password."
            return
        }
        
        // Sign in using Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            
            guard let user = result?.user else {
                errorMessage = "Unknown error occurred."
                return
            }
            
            print("User signed in successfully: \(user.email ?? "No email")")
            
            // Notify ContentView that the user is authenticated
            isAuthenticated = true
        }
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView(isAuthenticated: .constant(false))
    }
}

struct SocalLoginButton: View {
    var image: Image
    var text: Text
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                image
                    .padding(.horizontal)
                    .foregroundColor(.white)
                Spacer()
                text
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(50.0)
            .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
            .scaleEffect(1.0)
            .animation(.spring(), value: 1.0)
        }
    }
}

struct PrimaryButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("PrimaryColor"))
                .cornerRadius(25.0)
                .foregroundColor(.white)
                .shadow(radius: 5)
                .scaleEffect(1.0)
                .animation(.spring(), value: 1.0)
        }
        .padding(.vertical)
    }
}
