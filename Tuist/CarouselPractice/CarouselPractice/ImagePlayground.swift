//
//  ImagePlayground.swift
//  CarouselPractice
//
//  Created by 이주현 on 6/23/25.
//

import SwiftUI
import ImagePlayground

struct ImagePlayground: View {
    @Environment(\.supportsImagePlayground) var supportsImagePlayground
    @State private var imageGenerationConcept = ""
    @State private var isShowingImagePlayground = false
    @State private var avatarImage: Image?
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Button {
                    //
                } label: {
                    VStack(spacing: 10) {
                        Text("새로운 카드 추가")
                            .font(.system(size: 30))
                        Image(systemName: "plus.circle")
                            .font(.system(size: 60))
                    }
                    .frame(width: 350, height: 200)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.gray)
                    }
                }
                
                if supportsImagePlayground {
                    TextField("프롬프트 작성", text: $imageGenerationConcept)
                        .font(.title3.bold())
                        .padding()
                        .background(.quaternary, in: .rect(cornerRadius: 15))
                    
                    Button("이미지 생성", systemImage: "sparkles") {
                        isShowingImagePlayground = true
                    }
                    .padding()
                    .foregroundStyle(.mint)
                    .fontWeight(.bold)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .stroke(.mint, lineWidth: 3)
                    )
                    
                } else {
                    Text("존재하지 않음..")
                }
                
            }
        }
        .imagePlaygroundSheet(isPresented: $isShowingImagePlayground, concept: imageGenerationConcept, sourceImage: avatarImage) { url in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) { avatarImage = Image(uiImage: image)}
            }
        } onCancellation: {
            imageGenerationConcept = ""
        }
    }
}

#Preview {
    ImagePlayground()
}
