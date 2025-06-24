//
//  CarouselView.swift
//  CarouselPractice
//
//  Created by 이주현 on 6/23/25.
//

import SwiftUI

struct CarouselView2: View {
    @State private var selectedCard: Card? = Cards.first
    
    var body: some View {
        GeometryReader(content: { proxy in
            let size = proxy.size
            
            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    ForEach(Cards) { card in
                        GeometryReader(content: { proxy in
                            let cardSize = proxy.size
                            
                            let cardMidX = proxy.frame(in: .global).midX
                            let screenMidX = UIScreen.main.bounds.midX
                            let isCentered = abs(cardMidX - screenMidX) < 20
                            
                            Image(card.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: cardSize.width)
                                .clipShape(.rect(cornerRadius: 15))
                                .onChange(of: cardMidX) {
                                    if isCentered {
                                        selectedCard = card
                                    }
                                }
                        })
                        .frame(width: size.width - 200)
                        .scrollTransition(.interactive, axis: .horizontal) {
                            view, phase in
                            view
                                .scaleEffect(phase.isIdentity ? 1 : 0.95)
                        }
                    }
                }
                .padding(.horizontal, 100)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        })
        .frame(height: 500)
        .padding(.horizontal, -15)
        
        if let selectedCard {
            Text(selectedCard.subtitle)
                .font(.headline)
        }
        
    }
}

#Preview {
    CarouselView2()
}
