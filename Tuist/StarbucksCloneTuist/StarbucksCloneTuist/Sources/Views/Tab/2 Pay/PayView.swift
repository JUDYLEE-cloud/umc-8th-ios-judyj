//
//  PayView.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 6/23/25.
//

import SwiftUI
import SwiftData

struct PayView: View {
    @State private var showingCardView = false
    
    @Environment(\.modelContext) private var context
    // @Query private var cards: [Card]
    @Query(sort: \Card.createdAt, order: .reverse) private var cards: [Card]
    
    @State private var selectedCard: Card?
    @State private var remainingTime: Int = 180
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            HStack {
                Text("Pay")
                    .font(.mainTextBold24())
                Spacer()
                Button {
                    showingCardView = true
                } label: {
                    Image(systemName: "plus")
                        .bold()
                }
            }
            .foregroundStyle(Color("black03"))
            .padding(.horizontal, 23)
            .padding(.bottom, 25)
            
            GeometryReader(content: { proxy in
                let size = proxy.size
                
                ScrollView(.horizontal) {
                    HStack(spacing: 25) {
                        ForEach(cards) { card in
                            GeometryReader(content: { proxy in
                                let cardSize = proxy.size
                                
                                let cardMidX = proxy.frame(in: .global).midX
                                let screenMidX = UIScreen.main.bounds.midX
                                let isCentered = abs(cardMidX - screenMidX) < 20
                                
                                if let uiImage = loadImageFromDocuments(card.cardImageName) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 272, height: 143)
                                        .clipShape(.rect(cornerRadius: 15))
                                        .onChange(of: cardMidX) {
                                            if isCentered {
                                                selectedCard = card
                                            }
                                        }
                                } else {
                                    Image("BasicCard")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 272, height: 143)
                                        .clipShape(.rect(cornerRadius: 15))
                                        .onChange(of: cardMidX) {
                                            if isCentered {
                                                selectedCard = card
                                            }
                                        }
                                }
                            })
                            .frame(width: size.width - 160, height: 143)
                            .scrollTransition(.interactive, axis: .horizontal) {
                                view, phase in
                                view
                                    .scaleEffect(phase.isIdentity ? 1 : 0.95)
                            }
                        }
                    }
                    .padding(.horizontal, 80)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
            })
            .padding(.horizontal, -15)
            .frame(height: 143)
            
            if let selectedCard {
                VStack(spacing: 3) {
                    VStack {
                        Text(selectedCard.cardTitle)
                            .font(.mainTextMedium13())
                            .foregroundStyle(Color("gray06"))
                        Text(String(selectedCard.cardAmount) + "원")
                            .font(.mainTextSemiBold18())
                    }
                    .padding(.vertical, 20)
                    
                    Text(maskCardNumber(selectedCard.cardNumber))
                        .font(.mainTextRegular12())
                    if remainingTime > 0 {
                        (
                            Text("카드 유효 시간 ")
                                .foregroundStyle(Color("gray04"))
                            +
                            Text(timeString(from: remainingTime))
                                .foregroundStyle(Color("green02"))
                        )
                        .font(.mainTextRegular12())
                    } else {
                        Text("유효 시간이 만료되었습니다!")
                            .foregroundStyle(Color.red)
                            .font(.mainTextRegular12())
                    }
                }
            }
            
            Spacer()
            
        }
        .onAppear {
            if selectedCard == nil {
                selectedCard = cards.first
            }
            if selectedCard != nil {
                resetTimer()
            }
        }
        .onChange(of: selectedCard) {
            if selectedCard != nil {
                resetTimer()
            }
        }
        .onChange(of: showingCardView) {
            if showingCardView == false {
                selectedCard = cards.first
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
        .sheet(isPresented: $showingCardView) {
            AddCardView()
                .presentationDragIndicator(.visible)
        }
        
    }
    
    private func deleteCard(at offsets: IndexSet) {
        for index in offsets {
            context.delete(cards[index])
        }
        try? context.save()
    }
    
    private func loadImageFromDocuments(_ filename: String) -> UIImage? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        return UIImage(contentsOfFile: url.path)
    }
    
    private func maskCardNumber(_ number: String) -> String {
        let digits = number.replacingOccurrences(of: "-", with: "")
        guard digits.count >= 4 else { return number }
        
        let last4 = digits.suffix(4)
        return "****-****-" + last4
    }

    private func resetTimer() {
        timer?.invalidate()
        remainingTime = 180

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }

    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}

#Preview {
    PayView()
}

//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Card.self, configurations: config)
//
//    let sampleCards = [
//        Card(cardImageName: "BasicCard", cardTitle: "스타벅스 카드 1", cardAmount: 10000, cardNumber: "1111-2222-3333"),
//        Card(cardImageName: "BasicCard", cardTitle: "스타벅스 카드 2", cardAmount: 20000, cardNumber: "5555-6666-7777"),
//        Card(cardImageName: "BasicCard", cardTitle: "스타벅스 카드 3", cardAmount: 30000, cardNumber: "9999-0000-1111"),
//        Card(cardImageName: "BasicCard", cardTitle: "스타벅스 카드 4", cardAmount: 40000, cardNumber: "3333-4444-5555"),
//        Card(cardImageName: "BasicCard", cardTitle: "스타벅스 카드 5", cardAmount: 50000, cardNumber: "7777-8888-9999")
//    ]
//    
//    for card in sampleCards {
//        container.mainContext.insert(card)
//    }
//
//    return PayView()
//        .modelContainer(container)
//}
