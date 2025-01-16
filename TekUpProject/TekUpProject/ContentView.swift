import SwiftUI

struct ContentView: View {
    
    @StateObject var cartManager = CartManager()  // Gérer les produits du panier
    @ObservedObject var authManager = AuthManager()  // Observer l'état d'authentification
    
    var body: some View {
        if authManager.isAuthenticated {
            NavigationView {
                VStack(alignment: .leading) {
                    Home()
                        .environmentObject(cartManager)
                    
                    if cartManager.products.count > 0 {
                        NavigationLink(destination: CardView().environmentObject(cartManager)) {
                            HStack(spacing: 30) {
                                Text("\(cartManager.products.count)")
                                    .padding()
                                    .background(Color.yellow.opacity(0.5))
                                    .clipShape(Circle())
                                    .foregroundColor(Color.black)
                                
                                VStack(alignment: .leading) {
                                    Text("Cart")
                                        .font(.system(size: 26, weight: .semibold))
                                        .foregroundColor(Color.white)
                                    
                                    Text("\(cartManager.products.count) item")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(30)
                            .frame(width: 400, height: 80)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        } else {
            SignInScreenView(isAuthenticated: $authManager.isAuthenticated)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
