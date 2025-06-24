//
//  CardCarouselView.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 6/23/25.
//

import SwiftUI

struct CardCarouselView: View {
    @State private var selectedCard: Card? = Cards.first
    
    var body: some View {
        GeometryReader(content: { geometry in
            let size = geometry.size
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(Cards) { card in
                        GeometryReader { proxy in
                            let cardSize = proxy.size
                            
                            let cardMidX = proxy.frame(in: .global).midX
                            let screenMidX = UIScreen.main.bounds.midX
                            let isCentered = abs(cardMidX - screenMidX) < 20
                            
                            VStack {
                                Image(card.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: cardSize.width)
                                    .clipShape(.rect(cornerRadius: 15))
                                
//                                Text(card.subtitle)
//                                    .foregroundStyle(Color.red)
                            }
                            .onChange(of: cardMidX) {
                                if isCentered {
                                    selectedCard = card
                                }
                            }
                        }
                        .frame(width: size.width - 220)
                        .scrollTransition(.interactive, axis: .horizontal) {
                            view, phase in
                            view
                                .scaleEffect(phase.isIdentity ? 1 : 0.95)
                        }
                    }
                    .padding(.horizontal, 110)
                }
                .scrollTargetLayout()
            } // ScrollView
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        })
        .frame(height: 500)
        .padding(.horizontal, -30)
        
        if let selectedCard {
            Text(selectedCard.subtitle)
                .font(.headline)
        }
        
    }
}

#Preview {
    CardCarouselView()
}
