import SwiftUI

struct MovieView: View {
    var viewModel: MovieViewModel = .init()
    @AppStorage("saveMovieTitle") var savemovietitle: String = "미키17"
    
    var body: some View {
        VStack(spacing: 56) {
            MovieCard(movieViewModel: viewModel)
            MovieChange
            MovieSet
            PersonalSetting
        }
        .frame(width: 379, height: 594)
        .padding(.top, 94)
        .padding(.bottom, 268)
        .padding(.leading, 31)
        .padding(.trailing, 30)
    }
    
    private var MovieChange: some View {
        HStack {
            Button {
                viewModel.previousMovie()
            } label: {
                Image("ArrowLeft")
            }
            Text("영화 바꾸기")
                .padding(.horizontal, 61)
            Button {
                viewModel.nextMovie()
            } label: {
                Image("ArrowRight")
            }
        }
        .frame(width: 256, height: 30)
        .padding(.horizontal, 22)
        .padding(.vertical, 17)
    }
    
    private var MovieSet: some View {
        Button {
            savemovietitle = viewModel.movieModel[viewModel.currentIndex].movieName
            // [viewModel.currentIndex] 현재 선택된 영화가 몇 번째인지 가져옴
            // viewModel.movieModel이 배열을 뜻함
            // viewModel.movieModel[] 영화 목록 중 n번째 영화 객체를 가져옴
            // .movieName 해당 영화 객체의 제목을 꺼냄, 이를 @appstrage에 savemovietitle로 저장
        } label: {
            Text("대표 영화로 설정")
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(.top, 21)
                .padding(.bottom, 20)
                .padding(.horizontal, 52.5)
                .background(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 0.5))
        }
    }
    
    private var PersonalSetting: some View {
        VStack {
            Text("@AppStorage에 저장된 영화")
                .font(.system(size: 30))
                .padding(.bottom, 17)
            Text("현재 저장된 영화: \(savemovietitle)")
                .font(.system(size: 20))
                .foregroundColor(.red)
        }
    }
}

#Preview {
    MovieView()
}
