import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()

    var body: some View {
        VStack{
            CustomTextField(title: "닉네임", viewmodeltext: $viewModel.signupModel.nickname)
            CustomTextField(title: "아이디", viewmodeltext: $viewModel.signupModel.id)
            
            CustomTextField(title: "비밀번호", viewmodeltext: $viewModel.signupModel.password)
            
            CustomTextField(title: "비밀번호 확인",
                            viewmodeltext: $viewModel.signupModel.passwordConfirm,
                            isMatching: viewModel.signupModel.isPasswordMatching)
            .onChange(of: viewModel.signupModel.isPasswordMatching) { newValue in
                viewModel.objectWillChange.send()
            }
            
            Spacer()
            
            Button {
                viewModel.signup()
            } label: {
                GreenButton(title: "생성하기")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 19)
        .safeAreaPadding(.top, 210)
        .padding(.bottom, 72)
    }
}

#Preview {
    return SignupView()
}
