import Foundation
import SwiftUI
import Vision
import SwiftData

@Observable
class ReceiptsViewModel {
    var currentReceipts: [ReceiptsModel] = []
    var selectedImage: UIImage?
    
    // 사진 하나만 선택할 수 있게
    func startOCR() {
        guard let uiImage = UIImage(named: "receiptImage"),
              let cgImage = uiImage.cgImage else {
            self.currentReceipts = []
            selectedImage = nil
            return
        }
        selectedImage = uiImage
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self,
                  let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                self?.currentReceipts = []
                self?.selectedImage = nil
                return
            }
            
            let recognizedStrings = observations.compactMap {$0.topCandidates(1).first?.string}
            let fullText = recognizedStrings.joined(separator: "\n")
            // let parsed = self.parseWithoutRegex(from: fullText)
            let parsed = self.parseWithoutRegex(from: fullText)
            
            DispatchQueue.main.async {
                // if let parsed = parsed {
                if let parsed = parsed {
                    parsed.imageData = uiImage.jpegData(compressionQuality: 0.8)
                    self.currentReceipts.append(parsed)
                }
            }
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform( [request] )
        }
    }
    
    func startOCR(with image: UIImage) {
        guard let cgImage = image.cgImage else {
            self.currentReceipts = []
            selectedImage = nil
            return
        }
        
        selectedImage = image
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self,
                  let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                self?.currentReceipts = []
                self?.selectedImage = nil
                return
            }
            
            let recognizedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
            let fullText = recognizedStrings.joined(separator: "\n")
            let parsed = self.parseWithoutRegex(from: fullText)
            
            DispatchQueue.main.async {
                if let parsed = parsed {
                    parsed.imageData = image.jpegData(compressionQuality: 0.8)
                    self.currentReceipts.append(parsed)
                }
            }
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform([request])
        }
    }
    
    private func parseWithoutRegex(from text: String) -> ReceiptsModel? {
        let lines = text.components(separatedBy: .newlines)
        
        var store = "주문 가게 없음"
        var receiptDate = "주문 날짜 없음"
        var totalPrice = 0
        
        var i = 0
        
        print("==== OCR 디버그 시작 ====")
        
        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
            print("✅ [\(i)] \(trimmed)")
            
            // 지점
            if store == "주문 가게 없음", trimmed.contains("점") {
                store = "스타벅스" + trimmed
            }
            
            // 날짜
            // 이안거 따라쓰기
            if receiptDate == "주문 날짜 없음" {
                if trimmed.range(of: #"^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$"#, options: .regularExpression) != nil {
                    receiptDate = trimmed
                } else if trimmed.range(of: #"^\d{4}-\d{2}-\d{2}\d{2}:\d{2}:\d{2}$"#, options: .regularExpression) != nil {
                    // 띄어쓰기가 없는 경우, 중간에 공백 삽입
                    let index = trimmed.index(trimmed.startIndex, offsetBy: 10)
                    let corrected = trimmed.prefix(upTo: index) + " " + trimmed.suffix(from: index)
                    receiptDate = String(corrected)
                }
            }
            
            // 결제금액
            if trimmed.contains("결제금액"), i-1 >= 0 {
                let priceLine = lines[i-1].trimmingCharacters(in: .whitespaces)
                let numberOnly = priceLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let price = Int(numberOnly) {
                    totalPrice = price
                }
            }
            
            
            i += 1
        }
        
        print("==== OCR 디버그 끝 ====")
        print("🏪 매장명: \(store)")
        print("☕️ 주문 날짜: \(receiptDate)")
        print("💰 결제 금액: \(totalPrice)")
        
        return ReceiptsModel(store: store, receiptDate: receiptDate, totalPrice: totalPrice)
    }
}
