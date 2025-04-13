//
//  CarouselItem.swift
//  CarouselSwiftUI
//
//  Created by Paras Gupta on 13/04/25.
//

import Foundation

struct CarouselItem: Identifiable {
    let id = UUID()
    let name: String
}

extension CarouselItem {
    static var mockData: [Self] {
        [
            CarouselItem(name: "dubai"),
            CarouselItem(name: "malaysia"),
            CarouselItem(name: "japan")
        ]
    }
}
