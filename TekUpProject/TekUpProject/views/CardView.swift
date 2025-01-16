//
//  CardView.swift
//  TekUpProject
//
//  Created by USER on 15/1/2025.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var cartManager: CartManager
    
    @Environment(\.presentationMode) var mode
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Cart")
                            .font(.system(size: 30))
                        
                        Spacer()
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        }label: {
                            Text("\(cartManager.products.count)")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 70, height: 90)
                                .background(.yellow.opacity(0.5))
                                .clipShape(Capsule())
                        }
                        .foregroundColor(.black)
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        }label: {
                            Image(systemName: "arrow.left")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 70, height: 90)
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                        }
                        .foregroundColor(.black)
                    }
                    .padding(30)
                    
                    //cartProducts
                    VStack(spacing:20)
                    {
                        ForEach(cartManager.products){ product in
                            CartProductCard(product: product)
                                .environmentObject(cartManager)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading)
                    {
                        HStack
                        {
                            Text("Delivery amount")
                            Spacer()
                            Text("$ 0.000")
                                .font(.system(size:22, weight: .semibold))
                        }
                        Divider()
                        Text("Total amount")
                        Text("\(cartManager.total)")
                            .font(.system(size:22, weight: .semibold))
                        
                        
                    }
                    .padding(30)
                    .frame(width: 400)
                    .background(Color.yellow.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding()
                    
                    //Buttons
                    
                    Button {
                        
                    } label: {
                         Text("Make payment")
                    }
                    .padding(30)
                    .frame(width: 400)
                    .background(Color.yellow.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding()
                    
                   
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    CardView()
        .environmentObject(CartManager())
}

struct CartProductCard : View {
    
    @EnvironmentObject var cartManager: CartManager
    var product: ProductModel
    var body: some View {
        HStack (alignment: .center, spacing: 20){
            Image(systemName: "iphone")
            
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .background(.gray.opacity(0.5))
                .clipShape(Circle())
            
            VStack(alignment: .leading, content: {
                
                Text(product.name)
                    .font(.headline)
                    
                Text(product.category)
                    .font(.headline)
                
            })
            
            Spacer()
            
            Text("$\(product.price)")
                .padding()
                .background(Color.yellow.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 50))
            
            Button() {
                
                cartManager.removeFromCart(product: product)
            }
                 label: {
                     Image(systemName: "trash")
            }
                
            
                
        }
        .padding()
        
    }
}
