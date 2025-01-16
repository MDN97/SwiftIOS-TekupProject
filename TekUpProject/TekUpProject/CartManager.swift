//
//  CartManager.swift
//  TekUpProject
//
//  Created by USER on 16/1/2025.
//


import SwiftUI

class CartManager : ObservableObject {
    
    @Published private(set) var products : [ProductModel] = []
    @Published private(set) var total : Int = 0
    
    func addToCart(product : ProductModel) {
        products.append(product)
        total += product.price
    }
    
    func removeFromCart(product : ProductModel) {
        products.removeAll(where: { $0.id != product.id })
        total -= product.price
    }
}
