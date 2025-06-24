import SwiftUI

struct ReceiptUpperBarView: View {
    var dismiss: DismissAction
    @Binding var showActionSheet: Bool
    @Binding var isShowingPicker: Bool
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                ZStack {
                    Text("전자영수증")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.mainTextMedium16())
                    
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding(.leading, 19)
                    
                    HStack {
                        Spacer()
                        Button {
                            showActionSheet = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .padding(.trailing, 19)
                        }
                        .confirmationDialog("사진 선택", isPresented: $showActionSheet, titleVisibility: .visible) {
                            Button("앨범에서 가져오기") {
                                isShowingPicker = true
                            }
                            Button("카메라로 촬영하기") {
                                // 카메라 촬영 로직 추가 예정
                            }
                            Button("취소", role: .cancel) { }
                        }
                    }
                }
                Spacer()
                    .frame(height: 22)
            }
        }
        .frame(height: 100)
        .padding(.top, 10)
    }
}
