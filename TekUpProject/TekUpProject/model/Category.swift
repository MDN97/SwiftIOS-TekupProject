//
//  Category.swift
//  TekUpProject
//
//  Created by USER on 15/1/2025.
//

import SwiftUI

struct CotegoryModel  :Identifiable, Hashable{
    var id: UUID = .init()
    var icon: String
    var title: String
}

var categoryList: [CotegoryModel] = [
    CotegoryModel(icon: "", title: "All"),
    CotegoryModel(icon: "apple", title: "IPhone 16"),
    CotegoryModel(icon: "apple", title: "IPhone 15"),
   CotegoryModel(icon: "apple", title: "IPhone 14")
]
