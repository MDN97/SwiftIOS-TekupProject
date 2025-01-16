//
//  CollectionView.swift
//  TekUpProject
//
//  Created by USER on 15/1/2025.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var cartManager: CartManager

    @Environment(\.presentationMode) var mode
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Welcome to Shop")
                            .font(.system(size: 30))
                        
                        Spacer()
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
                    .padding(10)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(products, id: \.id) { product in
                            SmallProductCard(product: product)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
    }
}


struct SmallProductCard : View {
    @EnvironmentObject var cartManager : CartManager
    var product:ProductModel
    var body: some View {
        ZStack{
            Image(systemName: "iphone")
                .resizable()
                .scaledToFit()
                .padding(.trailing, -100)
                .rotationEffect(.degrees(10))
            
            ZStack{
                VStack(alignment: .leading, content:    {
                    
                    Text(product.name)
                        .font(.system(size: 15))
                        .foregroundColor(Color.white)
                        .padding(.leading, 10)
                    
                    Text(product.category)
                        .font(.system(size: 20))
                        .background(.white.opacity(0.5))
                        .padding(.leading, 10)
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    HStack {
                        
                        Text("$\(product.price).0")
                            .font(.system(size: 20))
                            .background(.white.opacity(0.5))
                        Button {
                         cartManager.addToCart(product: product)
                            
                        }label: {
                            Image(systemName: "basket")
                                .imageScale(.large)
                                .frame(width: 45, height: 40)
                                .background(Color.black)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }
                        
                    }
                    
                    .padding(.trailing,-12)
                    .padding()
                    .frame(maxWidth:.infinity)
                    .frame(height:45)
                    .background(Color.white.opacity(0.9))
                })
                .padding()
                
            }
            
        }
        .frame(width:170, height:250)
        .background(product.color.opacity(0.13))
        .clipShape(.rect(cornerRadius: 30))
        .padding(.leading,10)
    }
}


#Preview {
    CollectionView()
        .environmentObject(CartManager())
}
