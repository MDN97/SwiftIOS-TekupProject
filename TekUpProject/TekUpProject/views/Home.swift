//
//  Home.swift
//  TekUpProject
//
//  Created by USER on 15/1/2025.
//
import SwiftUI

struct Home: View {
    @EnvironmentObject var cartManager: CartManager
    
    @State var showCategoryList: Bool = false
    @State var selectedCategory = "All"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Welcome to Shop")
                            .font(.system(size: 30))
                        
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .padding()
                            .frame(width: 70, height: 90)
                            .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                    }
                    .padding(10)
                    
                    categoryListView
                        .environmentObject(CartManager())
                    
                    HStack {
                        Text("Iphones")
                            .font(.system(size: 24))
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: CollectionView()
                                .environmentObject(cartManager)
                            ,
                            label: {
                                Image(systemName: "arrow.right")
                                    .imageScale(.large)
                            }
                        )
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    
                    //productList
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(products.filter { product in
                                // Si on est sur "Tous", on n'applique pas de filtre.
                                selectedCategory == "All" || product.category == selectedCategory
                            }, id: \.id) { product in
                                
                                ProductCard(product: product)
                                    .environmentObject(cartManager)
                            }
                        }
                        
                    }
                }
                .padding(10)
            }
        }
    }
    
    //categorylist view
    
    var categoryListView: some View {
        HStack {
            ScrollView (.horizontal,showsIndicators: false){
                HStack {
                    ForEach(categoryList, id: \.id) { category in
                        Button {
                            selectedCategory = category.title
                        } label: {
                            HStack {
                                Text(category.title)
                                
                            }
                            .padding(20)
                            .background(selectedCategory == category.title ? .black : .gray.opacity(0.1))
                            .foregroundColor(.gray)
                            .foregroundColor(selectedCategory != category.title ? .black : .white)
                            .clipShape(Capsule())
                        }
                        
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}


//ProductCardView
struct ProductCard: View {
    @EnvironmentObject var cartManager : CartManager
    
    var product : ProductModel
    var body: some View {
        
        ZStack {
            
            Image(systemName: "iphone")
                .font(.system(size: 200))
                .scaledToFit()
                .padding(.trailing, -130)
                .rotationEffect(.degrees(30))
            
            
            ZStack {
                VStack(alignment: .leading, content: {
                    Text("\(product.name)")
                        .font(.system(size: 28, weight: .semibold))
                        .frame(width: 140)
                    Text(product.category)
                        .font(.callout)
                        .padding()
                        .background(.white.opacity(0.5))
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    HStack {
                        Text("$ \(product.price).000")
                            .font(.system(size: 24, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            cartManager.addToCart(product: product)
                        }label: {
                            Image(systemName: "cart")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 60, height: .infinity)
                                .background(.white)
                                .clipShape(Circle())
                                .foregroundColor(.yellow)
                            
                        }
                        .padding(.horizontal, -10)
                    }
                    .padding(.leading)
                    .padding()
                    .frame(maxWidth:.infinity)
                    .frame(height: 80)
                    .background(.white.opacity(0.5))
                    .clipShape(Capsule())
                    
                })
                .frame(width:336, height: 422)
            }
            .padding()
            .background(product.color.opacity(0.13))
            .clipShape(.rect(cornerRadius: 50))
            .padding(.leading,20)
        }
    }
}


#Preview {
    Home()
        .environmentObject(CartManager())
}
