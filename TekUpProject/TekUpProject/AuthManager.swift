import FirebaseAuth
import Combine

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let user = user {
                self?.isAuthenticated = true
            } else {
                self?.isAuthenticated = false
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
}

