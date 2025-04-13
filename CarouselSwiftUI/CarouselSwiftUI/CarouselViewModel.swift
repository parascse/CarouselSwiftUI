//
//  CarouselViewModel.swift
//  CarouselSwiftUI
//
//  Created by Paras Gupta on 13/04/25.
//

import SwiftUI

class CarouselViewModel: ObservableObject {
    @Published var currentIndex: Int = 1
    @Published var dragOffset: CGFloat = 0
    let items: [CarouselItem] = CarouselItem.mockData
    
    func getImage(_ index: Int) -> String {
        items[index].name
    }
    
    func updateIndex(dragAmount: CGFloat, cardSpacing: CGFloat) {
        let indexOffset = (dragAmount / cardSpacing).rounded()
        let newIndex = currentIndex - Int(indexOffset)
        currentIndex = max(0, min(newIndex, items.count - 1))
    }
    
    func dragGestureState(value: DragGesture.Value) {
        dragOffset = value.translation.width
    }
    
    func onDragEnded(value: DragGesture.Value, cardSpacing: CGFloat) {
        updateIndex(dragAmount: value.translation.width, cardSpacing: cardSpacing)
        dragOffset = 0
    }
    
    func getScaleEffect(_ index: Int) -> CGFloat {
        index == currentIndex ? 1.0 : 0.8
    }
    
    func getZIndex(_ index: Int) -> Double {
        index == currentIndex ? 1 : 0
    }
    
}
