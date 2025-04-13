//
//  CarouselPageView.swift
//  CarouselSwiftUI
//
//  Created by Paras Gupta on 13/04/25.
//

import SwiftUI

struct SnappingCarouselView: View {
    var body: some View {
        VStack {
            SampleView(title: "Top Child View")
                .frame(height: 100)
            CarouselWithPageControlView()
            Spacer()
            SampleView(title: "Bottom Child View")
                .frame(height: 400)
        }
    }
    
    func SampleView(title: String) -> some View {
        ZStack {
            Rectangle().fill(.blue)
            Text(title)
                .foregroundStyle(.white)
                .font(.title)
        }
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct CarouselWithPageControlView: View {
    @StateObject private var viewModel = CarouselViewModel()

    var body: some View {
        VStack(spacing: 5) {
            CarouselView(viewModel: viewModel)
            PageControl(pageCount: viewModel.items.count, currentIndex: $viewModel.currentIndex)
        }
        .frame(maxHeight: 250)
    }
}


struct CarouselView: View {
    @ObservedObject var viewModel: CarouselViewModel
    
    var body: some View {
        GeometryReader { geo in
            let availableHeight = geo.size.height
            let cardSize = min(geo.size.width * 0.7, availableHeight * 0.9)
            let spacing: CGFloat = -50
            let cardSpacing = cardSize + spacing
            
            HStack(spacing: spacing) {
                ForEach(viewModel.items.indices, id: \.self) { index in
                    Image(viewModel.getImage(index))
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardSize, height: cardSize)
                        .clipped()
                        .cornerRadius(15)
                        .scaleEffect(viewModel.getScaleEffect(index))
                        .zIndex(viewModel.getZIndex(index))
                }
            }
            .frame(height: geo.size.height)
            .padding(.horizontal, (geo.size.width - cardSize) / 2)
            .offset(x: -CGFloat(viewModel.currentIndex) * cardSpacing + viewModel.dragOffset)
            .animation(.easeOut(duration: 0.3), value: viewModel.currentIndex)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        viewModel.dragGestureState(value: value)
                    }
                    .onEnded { value in
                        viewModel.onDragEnded(value: value, cardSpacing: cardSpacing)
                    }
            )
        }
    }
}
