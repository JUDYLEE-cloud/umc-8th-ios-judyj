import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    @Environment(\.dismiss) var dismiss
    
    private var isSignupDisabled: Bool {
        viewModel.signupModel.nickname.isEmpty || viewModel.signupModel.id.isEmpty || viewModel.signupModel.password.isEmpty || viewModel.signupModel.passwordConfirm.isEmpty
    }

    var body: some View {
        ZStack(alignment: .top) {
            CustomNavigationBar(title: "가입하기") {
                dismiss()
            }
            
            VStack{
                CustomTextField(title: "닉네임", viewmodeltext: $viewModel.signupModel.nickname)
                CustomTextField(title: "아이디", viewmodeltext: $viewModel.signupModel.id)
                
                CustomTextField(title: "비밀번호", viewmodeltext: $viewModel.signupModel.password)
                
                CustomTextField(title: "비밀번호 확인",
                                viewmodeltext: $viewModel.signupModel.passwordConfirm,
                                isMatching: viewModel.signupModel.isPasswordMatching)
                .onChange(of: viewModel.signupModel.isPasswordMatching) {
                    viewModel.objectWillChange.send()
                }
                
                Spacer()
                
                Button {
                    viewModel.signup()
                    dismiss()
                } label: {
                    GreenButton(title: "생성하기", isDisabled: isSignupDisabled)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 19)
            .safeAreaPadding(.top, 210)
            .padding(.bottom, 72)
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

#Preview {
    return SignupView()
}
