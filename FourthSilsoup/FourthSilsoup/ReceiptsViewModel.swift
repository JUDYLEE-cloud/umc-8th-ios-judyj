import Foundation
import SwiftUI
import Vision

@Observable
class ReceiptsViewModel {
    var selectedSegment: ReceiptSegment = .first {
        didSet {
            startOCR(selectedSegment)
        }
    }
    
    var currentReceipt: ReceiptsModel? = nil
    
    func startOCR(_ segment: ReceiptSegment) {
        guard let uiImage = UIImage(named: segment.imageName),
              let cgImage = uiImage.cgImage else {
            self.currentReceipt = nil
            return
        }
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self,
                  let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                self?.currentReceipt = nil
                return
            }
            
            let recognizedStrings = observations.compactMap {$0.topCandidates(1).first?.string}
            let fullText = recognizedStrings.joined(separator: "\n")
            let parsed = self.parseWithoutRegex(from: fullText)
            
            DispatchQueue.main.async {
                self.currentReceipt = parsed
            }
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform( [request] )
        }
    }
    
    private func parseWithoutRegex(from text: String) -> ReceiptsModel? {
        let lines = text.components(separatedBy: .newlines)
        
        var orderer = "주문자 없음"
        var store = "주문 가게 없음"
        var menuItems: [String] = []
        var totalPrice = 0
        var orderNumber = "주문번호 없음"
        
        var isMenuSection = false
        var i = 0
        
        print("==== OCR 디버그 시작 ====")
        
        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
            print("✅ [\(i)] \(trimmed)")
            
            if trimmed.range(of: #".+\([A-Z]-\d+\)"#, options: .regularExpression) != nil {
                let components = trimmed.components(separatedBy: "(")
                if components.count >= 2 {
                    orderer = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    isMenuSection = true
                    i += 1
                    continue
                }
            }
            
            if trimmed.range(of: #"^(\d+-)?T\)"#, options: .regularExpression) != nil {
                isMenuSection = true
                let cleanName = trimmed.components(separatedBy: ")").last?.trimmingCharacters(in: .whitespaces) ?? trimmed
                menuItems.append(cleanName)
                print("☕️ 메뉴 새로 추가: \(cleanName)")
                i += 1
                continue
            }
            
            if store == "주문 가게 없음", trimmed.contains("점") {
                store = "스타벅스" + trimmed
            }
            
            if trimmed.contains("결제금액"), i-1 >= 0 {
                let priceLine = lines[i-1].trimmingCharacters(in: .whitespaces)
                let numberOnly = priceLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let price = Int(numberOnly) {
                    totalPrice = price
                }
            }
            
            if trimmed.starts(with: "32"), trimmed.count >= 14, trimmed.allSatisfy({$0.isNumber}) {
                orderNumber = trimmed
            }
            
            if trimmed.contains("합계") || trimmed.contains("결제금액") {
                isMenuSection = false
                print("❗️메뉴 종료 지접 도달")
            }
            
            if trimmed.hasPrefix("L") {
                isMenuSection = false
                print("❗️옵션 줄 만나서 메뉴 하나 종료")
            }
            
            i += 1
        }
        
        print("==== OCR 디버그 끝 ====")
        print("👤 주문자: \(orderer)")
        print("🏪 매장명: \(store)")
        print("☕️ 주문 음료: \(menuItems)")
        print("💰 결제 금액: \(totalPrice)")
        print("🧾 주문번호: \(orderNumber)")
        
        return ReceiptsModel(orderer: orderer, store: store, menuItems: menuItems, totalPrice: totalPrice, orderNumber: orderNumber)
    }
}
