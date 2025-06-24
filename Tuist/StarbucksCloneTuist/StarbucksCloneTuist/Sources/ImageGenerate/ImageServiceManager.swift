////
////  ImageServiceManager.swift
////  StarbucksCloneTuist
////
////  Created by 이주현 on 6/23/25.
////
//
//import Foundation
//import Alamofire
//import UIKit
//
//final class ImageServiceManager {
//    static let shared = ImageServiceManager()
//
//    private init() {}
//
//    private let baseURL = "\(Config.imageURL)"
//
//    // 커스텀 타임아웃 세션
//    private let session: Session = {
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 30000 // 요청 타임아웃 (초)
//        configuration.timeoutIntervalForResource = 30000 // 리소스 전체 수신 타임아웃
//
//        return Session(configuration: configuration)
//    }()
//
//    func generateImage(prompt: String, negativePrompt: String) async throws -> UIImage? {
//        let generateURL =  "\(baseURL)/sdapi/v1/txt2img"
//        let request = Txt2ImgRequest(prompt: prompt, negativePrompt: negativePrompt)
//
//        let dataTask = session.request(
//            generateURL,
//            method: .post,
//            parameters: request,
//            encoder: JSONParameterEncoder.default
//        )
//        .validate()
//        .serializingDecodable(Txt2ImgImageOnlyResponse.self)
//
//        let result = try await dataTask.value
//
//        guard let base64 = result.images.first,
//              let data = Data(base64Encoded: base64),
//              let image = UIImage(data: data) else {
//            print("이미지 디코딩 실패")
//            return nil
//        }
//
//        return image
//    }
//    
//    func getProgress() async throws -> ProgressResponse {
//        let progressURL = "\(baseURL)/sdapi/v1/progress"
//        
//        let dataTask = session.request(
//            progressURL,
//            method: .get
//        )
//            .validate()
//            .serializingDecodable(ProgressResponse.self)
//        
//        return try await dataTask.value
//    }
//
//    
//}
//
