// URLSession: Swift에서 HTTP 또는 HTTPS 네트워크 통신을 위한 API
// 서버에 요청(Request)을 보내고, 응답(Response)을 받아 데이터를 처리
import UIKit
import SwiftUI

// POST Method

//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "POST"
//
//let parameters: [String: Any] = [
//    "name" : "주디제이",
//    "age" : 25,
//    "address" : "경기도 성남시",
//    "height" : 165
//]
//
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("❌ 에러: \(error)")
//        return
//    }
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()


// GET Method

//var urlComponents = URLComponents(string: "http://localhost:8080/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "주디제이")
//]
//
//let url = urlComponents.url!
//
//let task = URLSession.shared.dataTask(with: url) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString)")
//    }
//}
//task.resume()


// PATCH Method

//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PATCH"
//
//let parameters: [String: Any] = [
//    "name" : "JudyJ",
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

// PATCH Method

//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PATCH"
//
//let parameters: [String: Any] = [
//    "name" : "JudyJ",
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

// DELETE Method

//var urlComponents = URLComponents(string: "http://localhost:8080/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "주디제이")
//]
//
//let url = urlComponents.url!
//var request = URLRequest(url: url)
//request.httpMethod = "DELETE"
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("response 데이터: \(responseString!)")
//    }
//}
//task.resume()

// 비동기
actor NetworkManager {
    // GET Method(유저 정보 가져오기)
    func getUserData() async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
        
        // 최종 URL: http://localhost:8080/person?name=주디제이
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: "주디제이")
        ]
        
        // URL 유효성 확인
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        // URLSession을 통해 비동기 데이터 요청, 성공하면 data와 response 받아옴
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // HTTP 응답 상태 코드 확인
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // 받은 data를 문자열로 디코딩
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        // 응답 반환
        return responseString
    }
    
    // POST Method(새로운 유저 정보 추가하기)
    func addUserData() async throws -> String {
        var urlComponents = URLComponents(string : "http://localhost:8080/person")!
        
        // URL 유효성 검사
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        // 보낼 데이터
        let parameters: [String: Any] = [
            "name" : "글로니",
            "age" : 20,
            "address" : "경기도 샤방시",
            "height" : 170
        ]
        
        // json 데이터로 반환
        let jsonData = try JSONSerialization.data(withJSONObject: parameters)
        
        // 서버에 보내는 데이터를 body에 담아줌
        // 보내는 데이터는 JSON이라고 알려줌
        // Get Method에서는 기본 값이 Get이라 해당 코드가 없었음
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // 비동기 요청
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // HTTP 응답 상태 코드 확인
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // 받은 data를 문자열로 디코딩
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return responseString
    }
    
    // DELETE Method(기존 유저 삭제하기)
    func deleteUserData() async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
        
        // 최종 URL: http://localhost:8080/person?name=글로니
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: "글로니")
        ]
        
        // URL 유효성 검사
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        // 비동기 요청
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // HTTP 응답 상태 코드 확인
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // 받은 data를 문자열로 디코딩
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return responseString
    }
}

let networkManager = NetworkManager()
Task {
    do {
        let result = try await networkManager.getUserData()
        print("응답 데이터:", result)
    } catch {
        print("네트워크 에러", error)
    }
    
    do {
        let result = try await networkManager.addUserData()
            print("유저 추가 결과:", result)
        } catch {
            print("에러 발생:", error)
        }
    
    do {
        let result = try await networkManager.deleteUserData()
        print("응답 데이터:", result)
    } catch {
        print("네트워크 에러", error)
    }
}
