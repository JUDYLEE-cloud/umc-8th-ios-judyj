// 카카오 책 api의 Response 값을 저장하는 view model
import Foundation
import UIKit
import Alamofire

@Observable
class ISBNScannerViewModel {
    var bookModel: BookModel.Documents?
    var errorMessage: String?
    
    var isShowSaveView: Bool = false
    
    // query를 사용하여 조회를 할 수 있도록 하는 alamofire 함수
    /// 네트워크 error 처리를 만들어야함 (async/await + throw 이용)
    func searchBook(isbn: String) async {
        self.errorMessage = nil
        
        do {
            let result = try await KakaoAPIService.shared.searchBook(query: isbn)
            bookModel = result.documents.first
            isShowSaveView = true
        } catch {
            self.errorMessage = error.localizedDescription
            print("❌ 전체 에러:", error)
        }
    }
    
    public func purchaseBook() {
        if let urlString = self.bookModel?.url,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("💸 구매 링크 연결 불가, 존재하지 않음")
        }
    }
}

