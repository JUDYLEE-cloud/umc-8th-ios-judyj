import Foundation
import SwiftUI

@Observable
class MovieViewModel {
    var currentIndex: Int = 0
    
    let movieModel: [MovieModel] = [
        .init(movieImage: Image("movie1"), movieName: "미키17", movieLike: 972, movieBooking: 30.8),
        .init(movieImage: Image("movie2"), movieName:
                "토이스토리", movieLike: 999, movieBooking: 99.8),
        .init(movieImage: Image("movie3"), movieName: "브루탈리스트", movieLike: 302, movieBooking: 24.8),
        .init(movieImage: Image("movie4"), movieName: "백설공주", movieLike: 332, movieBooking: 3.8),
        .init(movieImage: Image("movie5"), movieName: "위플래시", movieLike: 604, movieBooking: 62.2),
        .init(movieImage: Image("movie6"), movieName: "콘클라베", movieLike: 392, movieBooking: 43.9),
        .init(movieImage: Image("movie7"), movieName: "더폴", movieLike: 30, movieBooking: 2.1),
    ]
    
    public func previousMovie() {
        currentIndex = (currentIndex - 1 + movieModel.count) % movieModel.count
        // 첫번째 영화는 인덱스 0
        // movieModel.count = 총개수 = 7개
        // 만약 인덱스가 음수가 되면 배열의 마지막 인덱스로 돌아감, 인덱스가 0에서 마지막 인덱스(0)로 순환함
    }
    public func nextMovie() {
        currentIndex = (currentIndex + 1) % movieModel.count
    }
}
