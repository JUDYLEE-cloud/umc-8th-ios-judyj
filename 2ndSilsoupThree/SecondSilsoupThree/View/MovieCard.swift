//
//  MovieCared.swift
//  SecondSilsoupThree
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct MovieCard: View {
    var movieViewModel: MovieViewModel = .init()
    
    var body: some View {
        VStack(spacing: 5) {
            let movie = movieViewModel.movieModel[movieViewModel.currentIndex]
            
            movie.movieImage
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 172)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 4)
            
                Text(movie.movieName)
                    .fontWeight(.bold)
            
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .frame(width: 15, height: 14)
                    Text("\(movie.movieLike)")
                        .font(.system(size: 9))
                    Spacer()
                        .frame(width: 18)
                    Text("예매율 \(String(format: "%.1f", movie.movieBooking))%")
                        .font(.system(size: 9))
                }
        }
        .frame(width: 120, height: 216)
    }
}

#Preview {
    MovieCard(movieViewModel: MovieViewModel())
}
