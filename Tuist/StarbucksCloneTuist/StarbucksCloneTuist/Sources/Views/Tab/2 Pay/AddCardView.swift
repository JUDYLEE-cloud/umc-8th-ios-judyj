//
//  PayView.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 6/23/25.
//

import SwiftUI
import SwiftData

struct AddCardView: View {
    @Environment(\.modelContext) private var context
    @Query private var cards: [Card]
    
    @State private var newCardTitle: String = ""
    @State private var newCardNumber: String = ""
    @State private var generatedImageName: String = ""
    @State private var isAddButtonDisabled: Bool = true
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 39)
            
            Text("카드 등록")
                .font(.mainTextBold24())
                .padding(.bottom, 50)
            
            CustomTextField(title: "카드명 최대 20자", viewmodeltext: $newCardTitle)
                .onChange(of: newCardTitle) { _, newValue in
                    if newValue.count > 20 {
                        newCardTitle = String(newValue.prefix(20))
                    }
                }
                .onChange(of: newCardTitle) {
                    updateAddButtonState()
                }

            CustomTextField(title: "카드 번호 12자 입력", viewmodeltext: $newCardNumber)
                .keyboardType(.numberPad)
                .onChange(of: newCardNumber) {
                    updateAddButtonState()
                }
                .onChange(of: newCardNumber) {
                    let digits = newCardNumber.filter { $0.isNumber }
                    let limited = String(digits.prefix(12))
                    var result = ""
                    
                    for (index, char) in limited.enumerated() {
                        if index != 0 && index%4 == 0 {
                            result += "-"
                        }
                        result.append(char)
                    }
                    if result != newCardNumber {
                        newCardNumber = result
                    }
                }
            
            AIImageView(imageName: $generatedImageName)
                .padding(.top, -15)
            
            Spacer()
            
            Button {
                addCard()
            } label: {
                GreenButton(title: "카드 등록하기", isDisabled: isAddButtonDisabled)
            }
            .disabled(isAddButtonDisabled)
        }
        .padding(.horizontal, 32)
    }
    
    private func updateAddButtonState() {
        let titleIsEmpty = newCardTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let numberIsValid = newCardNumber.filter { $0.isNumber }.count == 12
        
        isAddButtonDisabled = titleIsEmpty || !numberIsValid
    }
    
    private func addCard() {
        let trimmed = newCardTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        let imageName = generatedImageName.isEmpty ? "BasicCard" : generatedImageName
        let randomAmount = Int.random(in: 0...1000)*100
        let card = Card(cardImageName: imageName, cardTitle: trimmed, cardAmount: randomAmount, cardNumber: newCardNumber, createdAt: Date())
        context.insert(card)
        try? context.save()
        newCardTitle = ""
        newCardNumber = ""
        dismiss()
    }
}

#Preview {
    AddCardView()
}
