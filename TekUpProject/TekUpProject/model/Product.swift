//
//  Product.swift
//  TekUpProject
//
//  Created by USER on 15/1/2025.
//
import SwiftUI

struct ProductModel :Identifiable, Hashable{
    var id: UUID = .init()
    var name: String
    var category: String
    var image: String
    var color : Color
    var price: Int
}
 var products: [ProductModel] = [
    .init(name: "Iphone 15", category: "IPhone 15", image: "apple",color: .red ,price: 100),
    .init(name: "Iphone 16", category: "IPhone 16", image: "apple", color: .gray,price: 200),
    .init(name: "Iphone 14", category: "IPhone 14", image: "apple", color: .black, price: 300),]
    

