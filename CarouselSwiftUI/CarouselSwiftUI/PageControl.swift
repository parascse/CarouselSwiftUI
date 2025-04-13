//
//  PageControl.swift
//  CarouselSwiftUI
//
//  Created by Paras Gupta on 13/04/25.
//

import SwiftUI

// Page Control
struct PageControl: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.gray : Color.gray.opacity(0.3))
                    .frame(width: 7, height: 7)
                    .scaleEffect(index == currentIndex ? 1.2 : 1)
                    .animation(.easeInOut, value: currentIndex)
            }
        }
    }
}
            
