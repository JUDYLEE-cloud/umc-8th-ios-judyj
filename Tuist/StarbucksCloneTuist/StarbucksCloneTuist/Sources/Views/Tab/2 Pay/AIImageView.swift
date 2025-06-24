//
//  AIImageView.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 6/23/25.
//

import SwiftUI
import CombineMoya
import Combine
import Moya

struct AIImageView: View {
    @Binding var imageName: String
    
    @State private var image: UIImage?
    @State private var isLoading = false
    @State private var progress: Double = 0.0
    
    @State private var cancellables = Set<AnyCancellable>()
    @StateObject var viewModel: CombineViewModel = .init()

    var body: some View {
        VStack {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Button {
                    isLoading = true
                    progress = 0.0
                    
                    //                        Task {
                    //                            while isLoading && progress < 1.0 {
                    //                                do {
                    //                                    let status = try await ImageServiceManager.shared.getProgress()
                    //                                    progress = status.progress
                    //                                } catch {
                    //                                    print("진행 상황 가져오기 실패:", error)
                    //                                }
                    //                                try? await Task.sleep(nanoseconds: 2_000_000_000) // 2초마다 받아옴
                    //                            }
                    //                        }
                    
                    do {
                        //                            if let generated = try await ImageServiceManager.shared.generateImage(
                        //                                prompt: "A realistic credit card with a modern, minimal design. The main color scheme should be various shades of green (from mint to forest green), with dynamic patterns like gradients, waves, or geometric shapes. Include a chip, card number, cardholder name, and expiration date, but all as placeholder text (e.g. 1234 5678 9012 3456). The card should be angled slightly or shown straight, with soft shadows to give a 3D feel. Background should be plain or slightly blurred for emphasis.",
                        //                                negativePrompt: "blurry, low quality, cropped"
                        //                            ) {
                        //                                image = generated
                        //                                if let data = generated.jpegData(compressionQuality: 0.8) {
                        //                                    let filename = UUID().uuidString + ".jpg"
                        //                                    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
                        //                                    try? data.write(to: url)
                        //                                    imageName = filename
                        //                                }
                        //                            }
                        viewModel.generateImage(
                            prompt: "A realistic credit card with a modern, minimal design. The main color scheme should be various shades of green (from mint to forest green), with dynamic patterns like gradients, waves, or geometric shapes. Include a chip, card number, cardholder name, and expiration date, but all as placeholder text (e.g. 1234 5678 9012 3456). The card should be angled slightly or shown straight, with soft shadows to give a 3D feel. Background should be plain or slightly blurred for emphasis.",
                            negativePrompt: "blurry, low quality, cropped"
                        )
                        .sink(receiveCompletion: { completion in
                            if case .failure(let error) = completion {
                                print("오류:", error)
                            }
                        }, receiveValue: { generated in
                            self.image = generated
                            
                            if let data = generated.jpegData(compressionQuality: 0.8) {
                                let filename = UUID().uuidString + ".jpg"
                                let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                                    .appendingPathComponent(filename)
                                try? data.write(to: url)
                                self.imageName = filename
                            }
                            
                            self.isLoading = false
                        })
                        .store(in: &cancellables)
                    } catch {
                        print("오류:", error)
                    }
                    
                    Timer
                        .publish(every: 2.0, on: .main, in: .common) // 2초마다 발생
                        .autoconnect()
                        .prefix(while: { _ in isLoading && progress < 1.0 }) // isLoading && progress < 1.0이 만족되는 동안만 타이머 유지
                        .flatMap { _ in
                            viewModel.getProgress()
                        } // 타이머 마다 getProgress 함수 호출
                        .sink { newProgress in
                            self.progress = newProgress
                        }
                        .store(in: &cancellables)
                    
                    // isLoading = false
                    
                } label: {
                    VStack(spacing: 15) {
                        if isLoading {
                            VStack(spacing: 7) {
                                ProgressView(value: progress)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .tint(Color("AccentColor"))
                                    .padding(.horizontal)
                                
                                Text("이미지 생성 중..")
                                
                                Text(String(format: "%.0f%%", progress * 100))
                                    .font(.mainTextMedium16())
                            }
                        } else {
                            Image(systemName: "plus")
                                .font(.system(size: 40))
                                .bold()

                            Text("카드 이미지 생성하기")
                                .font(.mainTextMedium16())
                        }
                    }
                    .foregroundStyle(Color("gray06"))
                    .frame(width: 350, height: 200)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color("white01"))
                    }
                } // Button
                .disabled(isLoading)

                
            }
            
        }
    }
}

#Preview {
    AIImageView(imageName: .constant(""))
}
